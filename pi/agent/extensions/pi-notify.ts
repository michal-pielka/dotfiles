/**
 * pi-notify - mako/desktop notification when a Pi run settles and waits for input.
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

export default function (pi: ExtensionAPI) {
	let startedAt = 0;

	pi.on("agent_start", async () => {
		startedAt = Date.now();
	});

	// agent_settled fires once the full run is done (after retries/compaction/queued work),
	// unlike agent_end which fires per low-level run.
	pi.on("agent_settled", async (_event, ctx) => {
		const elapsed = (Date.now() - startedAt) / 1000;
		if (elapsed < MIN_SECONDS) return;
		if (await isTerminalFocused()) return;

		const project = basename(ctx.cwd);
		const duration = elapsed >= 60 ? `${Math.round(elapsed / 60)}m ${Math.round(elapsed % 60)}s` : `${Math.round(elapsed)}s`;
		notify(`pi - ${project}`, `done in ${duration}, ready for input`);
	});
}
