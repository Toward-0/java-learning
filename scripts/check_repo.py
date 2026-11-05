#!/usr/bin/env python3
"""Check repository Markdown without dependencies; not a full Markdown parser.

Supports simple inline links/images, ATX headings and explicit anchor IDs.
Reference links, raw HTML image sources and external URLs are not checked.
"""
from __future__ import annotations

from pathlib import Path
from urllib.parse import unquote, urlsplit
import re
import sys
import unicodedata

ROOT = Path(__file__).resolve().parents[1]
# Repository convention: simple inline links, optionally angle-bracketed.
# Reference links and raw HTML image src attributes are not parsed.
LINK = re.compile(r"!?\[[^\]]*\]\((<[^>]+>|[^\s)]+)(?:\s+\"[^\"]*\")?\)")
REQUIRED = [
    "README.md", "AGENTS.md", "current.md", "PROMPTS.md", "docs/concepts.md",
    "docs/learning.md", "practice/README.md",
]


def without_fences(data: str) -> tuple[str, int]:
    """Return prose and the opening line of an unclosed code fence (0 if closed)."""
    lines = []
    fence = ""
    opening_line = 0
    for number, line in enumerate(data.splitlines(), 1):
        match = re.match(r"^ {0,3}(\x60{3,}|~{3,})(.*)$", line)
        if match:
            marker, rest = match.groups()
            if not fence:
                # Backtick info strings cannot themselves contain backticks.
                if marker[0] == "`" and "`" in rest:
                    lines.append(line)
                    continue
                fence = marker
                opening_line = number
            elif (marker[0] == fence[0] and len(marker) >= len(fence)
                  and not rest.strip()):
                fence = ""
                opening_line = 0
            continue
        if not fence:
            lines.append(line)
    return "\n".join(lines), opening_line


def without_inline_code(data: str) -> str:
    # Match equal-length backtick delimiters; unmatched backticks remain prose.
    return re.sub(r"(?<!`)(`+)(?!`)([\s\S]*?)(?<!`)\1(?!`)", "", data)


def anchors(data: str) -> set[str]:
    """GitHub-style slugs for the plain ATX headings used in this repository."""
    result = set(re.findall(r'<a\s+id=["\']([^"\']+)["\']', data))
    used = set()
    for heading in re.findall(r"^#{1,6}\s+(.+?)(?:\s+#+)?\s*$", data, re.M):
        heading = re.sub(r"<[^>]*>", "", heading).strip().lower()
        slug = "".join(c for c in heading if c in " -_" or
                       unicodedata.category(c)[0] in "LNM").replace(" ", "-")
        unique, suffix = slug, 0
        while unique in used:
            suffix += 1
            unique = f"{slug}-{suffix}"
        used.add(unique)
        result.add(unique)
    return result


def check(root: Path, required=REQUIRED) -> tuple[list[str], int]:
    root = root.resolve()
    errors = []
    for file in required:
        if not (root / file).is_file():
            errors.append(f"Required file missing: {file}")

    documents = {}
    for path in sorted(root.rglob("*.md")):
        if ".git" in path.relative_to(root).parts:
            continue
        try:
            prose, opening_line = without_fences(path.read_text(encoding="utf-8"))
            documents[path] = prose
            if opening_line:
                errors.append(f"{path.relative_to(root)}:{opening_line}: unclosed code fence")
        except UnicodeError as exc:
            errors.append(f"{path.relative_to(root)}: not valid UTF-8 ({exc})")
    targets = {path: anchors(data) for path, data in documents.items()}
    for path, data in documents.items():
        relative = path.relative_to(root)
        data = without_inline_code(data)
        if data.count("$$") % 2:
            errors.append(f"{relative}: odd number of $$ display-math delimiters")
        for raw in LINK.findall(data):
            target = raw.strip("<>")
            parts = urlsplit(target)
            if parts.scheme or parts.netloc:
                continue
            local = unquote(parts.path)
            candidate = (path.parent / local).resolve() if local else path
            if not candidate.is_relative_to(root):
                errors.append(f"{relative}: link points outside repository: {target}")
            elif not candidate.exists():
                errors.append(f"{relative}: broken relative link/image: {target}")
            elif parts.fragment and candidate.suffix.lower() == ".md":
                fragment = unquote(parts.fragment)
                if fragment not in targets.get(candidate, set()):
                    errors.append(f"{relative}: missing Markdown anchor: {target}")
    return errors, len(documents)


def main() -> int:
    errors, count = check(ROOT)
    if errors:
        for error in errors:
            print("FAIL:", error)
        print(f"{len(errors)} issue(s) detected")
        return 1
    print(f"OK: {count} Markdown files; required files, UTF-8, code fences, display math, local links/images and Markdown anchors passed")
    print("Note: external URLs, content correctness and learning level are not verified.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
