/**
 * Custom startup header: pi tetris logo with loaded skills, extensions,
 * prompt templates and the pi version beside it.
 */
import { readdirSync, readFileSync } from "node:fs";
import { basename, join } from "node:path";
import type { ExtensionAPI, SourceInfo, Theme, ThemeColor } from "@earendil-works/pi-coding-agent";
import { getAgentDir, VERSION } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

// pi.dev logo on a 4x4 grid: J piece (P), T piece (B), bar (Y).
const LOGO = ["PPP.", "B.P.", "BB.Y", "B..Y"];
const PIECE_COLORS: Record<string, ThemeColor> = { P: "error", B: "border", Y: "warning" };
const CELL_WIDTH = 2;
const INDENT = " ";
const GAP = "   ";
const LABEL_WIDTH = "extensions".length + 2;

type Origin = "project" | "package" | "user";

// Display order of origin groups.
const ORIGIN_ORDER: Origin[] = ["project", "package", "user"];
// Own files stand out, installed packages recede, project-scoped items are orange.
const ORIGIN_COLORS: Record<Origin, ThemeColor> = { project: "accent", package: "muted", user: "text" };

interface Item {
	name: string;
	origin: Origin;
}

interface Row {
	label: string;
	color: ThemeColor;
	items: Item[];
}

function render_logo_row(theme: Theme, row: string): string {
	return [...row]
		.map((cell) => (cell === "." ? " ".repeat(CELL_WIDTH) : theme.fg(PIECE_COLORS[cell], "█".repeat(CELL_WIDTH))))
		.join("");
}

// Join as many items as fit in width, then add "+N" for the rest.
function fit_items(theme: Theme, items: Item[], width: number): string {
	if (items.length === 0) return theme.fg("dim", "none");
	const separator = theme.fg("dim", ", ");
	let text = "";
	for (let i = 0; i < items.length; i++) {
		const name = theme.fg(ORIGIN_COLORS[items[i].origin], items[i].name);
		const next = text ? text + separator + name : name;
		const rest = items.length - i - 1;
		const suffix = rest > 0 ? ` +${rest}` : "";
		if (visibleWidth(next + suffix) > width && text) {
			return `${text}${theme.fg("dim", ` +${items.length - i}`)}`;
		}
		text = next;
	}
	return text;
}

function origin_of(source: SourceInfo): Origin {
	if (source.scope === "project") return "project";
	return source.origin === "package" ? "package" : "user";
}

// First occurrence of a name wins, then sort by origin group and name.
function unique_sorted(items: Item[]): Item[] {
	const by_name = new Map<string, Item>();
	for (const item of items) if (!by_name.has(item.name)) by_name.set(item.name, item);
	const rank = (item: Item) => ORIGIN_ORDER.indexOf(item.origin);
	return [...by_name.values()].sort((a, b) => rank(a) - rank(b) || a.name.localeCompare(b.name));
}

function render_row(theme: Theme, row: Row, width: number): string {
	const label = theme.fg(row.color, row.label.padEnd(LABEL_WIDTH));
	return label + fit_items(theme, row.items, Math.max(0, width - LABEL_WIDTH));
}

function list_commands(pi: ExtensionAPI, source: "skill" | "prompt"): Item[] {
	const items = pi
		.getCommands()
		.filter((c) => c.source === source)
		.map((c) => ({
			name: source === "prompt" ? `/${c.name}` : c.name.replace(/^skill:/, ""),
			origin: origin_of(c.sourceInfo),
		}));
	return unique_sorted(items);
}

function package_name(source: string): string {
	if (/^[./~]/.test(source)) return basename(source);
	return source.replace(/^npm:/, "").replace(/^@[^/]+\//, "");
}

function file_name(path: string): string {
	return basename(path).replace(/\.[jt]s$/, "");
}

// Pi has no API listing loaded extensions, so combine what registered commands/tools
// report with global packages and files in the global extensions dir.
function list_extensions(pi: ExtensionAPI): Item[] {
	const registered = [...pi.getCommands().filter((c) => c.source === "extension"), ...pi.getAllTools()]
		.map((x) => x.sourceInfo)
		.filter((s) => s.source !== "builtin" && !s.path.startsWith("<"))
		.map((s) => ({
			name: s.origin === "package" ? package_name(s.source) : file_name(s.path),
			origin: origin_of(s),
		}));

	const agent_dir = getAgentDir();
	const packages = read_packages(join(agent_dir, "settings.json")).map(
		(p): Item => ({ name: package_name(p), origin: "package" }),
	);
	const files = read_dir(join(agent_dir, "extensions")).map((f): Item => ({ name: file_name(f), origin: "user" }));
	return unique_sorted([...registered, ...packages, ...files]);
}

function read_packages(settings_path: string): string[] {
	try {
		const packages: unknown[] = JSON.parse(readFileSync(settings_path, "utf8")).packages ?? [];
		return packages.map((p) => (typeof p === "string" ? p : (p as { source: string }).source));
	} catch {
		return [];
	}
}

function read_dir(dir: string): string[] {
	try {
		return readdirSync(dir).filter((f) => !f.startsWith("."));
	} catch {
		return [];
	}
}

function render_header(pi: ExtensionAPI, theme: Theme, width: number): string[] {
	const rows: Row[] = [
		{ label: "skills", color: "warning", items: list_commands(pi, "skill") },
		{ label: "extensions", color: "border", items: list_extensions(pi) },
		{ label: "prompts", color: "error", items: list_commands(pi, "prompt") },
	];
	const text_width = width - INDENT.length - LOGO[0].length * CELL_WIDTH - GAP.length;
	const right = [...rows.map((row) => render_row(theme, row, text_width)), theme.fg("dim", `v${VERSION}`)];
	const lines = LOGO.map((row, i) => `${INDENT}${render_logo_row(theme, row)}${GAP}${right[i]}`);
	return ["", ...lines, ""].map((line) => truncateToWidth(line, width));
}

export default function (pi: ExtensionAPI) {
	pi.on("session_start", async (_event, ctx) => {
		if (ctx.mode !== "tui") return;
		ctx.ui.setHeader((_tui, theme) => ({
			render: (width) => render_header(pi, theme, width),
			invalidate() {},
		}));
	});
}
