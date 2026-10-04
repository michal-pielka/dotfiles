/**
 * pi-notify - mako/desktop notification when a Pi run settles or a subagent finishes.
 *
 * Skips the notification when:
 * - the run was quicker than PI_NOTIFY_MIN_SECONDS (default 15)
 * - the terminal window running Pi is currently focused (Hyprland)
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execFile } from "node:child_process";
import { readFileSync } from "node:fs";
import { basename } from "node:path";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);
const MIN_SECONDS = Number(process.env.PI_NOTIFY_MIN_SECONDS ?? 15);
const ICON = `${process.env.HOME}/.dotfiles/pi/assets/pi-logo.svg`;

function esc(text: string): string {
	return text.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

function formatDuration(seconds: number): string {
	const s = Math.round(seconds);
	return s >= 60 ? `${Math.floor(s / 60)}m ${s % 60}s` : `${s}s`;
}

function parentPids(): number[] {
	const pids: number[] = [];
	let pid = process.ppid;
	while (pid > 1) {
		pids.push(pid);
		try {
			const stat = readFileSync(`/proc/${pid}/stat`, "utf8");
			pid = Number(stat.slice(stat.lastIndexOf(")") + 2).split(" ")[1]);
		} catch {
			break;
		}
	}
	return pids;
}

// True when the focused Hyprland window is an ancestor process (the terminal running Pi).
async function isTerminalFocused(): Promise<boolean> {
	try {
		const { stdout } = await execFileAsync("hyprctl", ["activewindow", "-j"]);
		const win = JSON.parse(stdout);
		if (!win?.pid) return false;
		return parentPids().includes(win.pid);
	} catch {
		return false; // not on Hyprland or hyprctl failed: notify anyway
	}
}

function notify(title: string, body: string): void {
	execFile("notify-send", ["--app-name=pi", `--icon=${ICON}`, title, body], () => {});
}

// Short label for a subagent call: agent name, or the first words of the task.
function subagentLabel(args: { agent?: string; task?: string }): string {
	if (args?.agent) return args.agent;
	const task = (args?.task ?? "").replace(/\s+/g, " ").trim();
	return task.length > 60 ? `${task.slice(0, 57)}...` : task || "subagent";
}

export default function (pi: ExtensionAPI) {
	let startedAt = 0;
	const subagents = new Map<string, { label: string; startedAt: number }>();

	pi.on("agent_start", async () => {
		startedAt = Date.now();
	});

	pi.on("tool_execution_start", async (event) => {
		if (event.toolName !== "subagent" || event.parentToolCallId) return;
		subagents.set(event.toolCallId, { label: subagentLabel(event.args), startedAt: Date.now() });
	});

	pi.on("tool_execution_end", async (event) => {
		const sub = subagents.get(event.toolCallId);
		subagents.delete(event.toolCallId);
		if (!sub) return;
		const elapsed = (Date.now() - sub.startedAt) / 1000;
		if (elapsed < MIN_SECONDS) return;
		if (await isTerminalFocused()) return;

		const state = event.isError ? "subagent failed" : "subagent done";
		notify(`pi - ${state}`, `${esc(sub.label)}\n${formatDuration(elapsed)}`);
	});

	// agent_settled fires once the full run is done (after retries/compaction/queued work),
	// unlike agent_end which fires per low-level run.
	pi.on("agent_settled", async (_event, ctx) => {
		subagents.clear();
		const elapsed = (Date.now() - startedAt) / 1000;
		if (elapsed < MIN_SECONDS) return;
		if (await isTerminalFocused()) return;

		notify(`pi - ${basename(ctx.cwd)}`, `done in ${formatDuration(elapsed)}`);
	});
}
