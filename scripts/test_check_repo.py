"""Regression cases for the repository's supported Markdown conventions."""
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from check_repo import check


class RepositoryChecks(unittest.TestCase):
    def inspect(self, files, required=()):
        with TemporaryDirectory() as directory:
            root = Path(directory)
            for name, content in files.items():
                path = root / name
                path.parent.mkdir(parents=True, exist_ok=True)
                if isinstance(content, bytes):
                    path.write_bytes(content)
                else:
                    path.write_text(content, encoding="utf-8")
            return check(root, required)[0]

    def test_local_links_images_and_unicode_anchors(self):
        self.assertEqual([], self.inspect({
            "README.md": '[章节](notes/topic.md#知识点) [重复](notes/topic.md#知识点-1)\n'
                         '[显式](notes/topic.md#example) ![原稿](assets/a%20b.png)\n',
            "notes/topic.md": '# 知识点\n## 知识点\n<a id="example"></a>\n',
            "assets/a b.png": b"image fixture",
        }))

    def test_broken_targets_and_missing_anchors(self):
        errors = self.inspect({"README.md":
            '# 首页\n[失效](missing.md) ![缺图](missing.png) '
            '[缺锚点](#absent) [越界](../outside.md)\n'})
        self.assertEqual(4, len(errors))
        self.assertTrue(any("missing Markdown anchor" in e for e in errors))
        self.assertTrue(any("outside repository" in e for e in errors))

    def test_code_examples_do_not_create_links_or_math_delimiters(self):
        self.assertEqual([], self.inspect({"README.md":
            '~~~markdown\n[示例](missing.md) $$\n~~~\n'
            '`[行内](missing.md) $$` 和 ``带 ` 的 [示例](missing.md) $$``\n'}))

    def test_unclosed_fence_is_not_silently_accepted(self):
        errors = self.inspect({"README.md": '正文\n```java\nint n = 1;\n'})
        self.assertEqual(1, len(errors))
        self.assertIn("README.md:2: unclosed code fence", errors[0])

    def test_wrong_marker_short_fence_and_info_string_do_not_close(self):
        self.assertEqual([], self.inspect({"README.md":
            '````text\n```\n~~~~\n````java\n[仍在代码中](missing.md)\n````\n'}))

    def test_real_display_math_still_checked_outside_code(self):
        self.assertEqual([], self.inspect({"README.md": '`$$`\n$$\nx^2\n$$\n'}))
        errors = self.inspect({"README.md": '`$$`\n$$\nx^2\n'})
        self.assertEqual(1, len(errors))
        self.assertIn("display-math delimiters", errors[0])

    def test_required_files_and_encoding(self):
        errors = self.inspect({"bad.md": b"\xff"}, required=("README.md",))
        self.assertEqual(2, len(errors))
        self.assertTrue(any("Required file missing" in e for e in errors))
        self.assertTrue(any("not valid UTF-8" in e for e in errors))


if __name__ == "__main__":
    unittest.main()
