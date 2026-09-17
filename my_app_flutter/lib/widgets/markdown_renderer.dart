import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/blog_theme.dart';

class MarkdownRenderer extends StatelessWidget {
  final String rawContent;

  const MarkdownRenderer({super.key, required this.rawContent});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B);

    // Split content into blocks by double line breaks or code blocks
    final blocks = _parseBlocks(rawContent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.map((block) => _buildBlockWidget(context, block, textColor, isDark)).toList(),
    );
  }

  List<_BlockData> _parseBlocks(String content) {
    final List<_BlockData> blocks = [];
    final lines = content.split('\n');

    bool inCodeBlock = false;
    List<String> codeLines = [];
    String? codeLang;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.trim().startsWith('```')) {
        if (inCodeBlock) {
          // End code block
          blocks.add(_BlockData(_BlockType.codeBlock, codeLines.join('\n'), lang: codeLang));
          codeLines = [];
          inCodeBlock = false;
        } else {
          // Start code block
          inCodeBlock = true;
          codeLang = line.trim().replaceFirst('```', '').trim();
        }
        continue;
      }

      if (inCodeBlock) {
        codeLines.add(line);
        continue;
      }

      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        continue;
      }

      if (trimmed.startsWith('# ')) {
        blocks.add(_BlockData(_BlockType.h1, trimmed.substring(2).trim()));
      } else if (trimmed.startsWith('## ')) {
        blocks.add(_BlockData(_BlockType.h2, trimmed.substring(3).trim()));
      } else if (trimmed.startsWith('### ')) {
        blocks.add(_BlockData(_BlockType.h3, trimmed.substring(4).trim()));
      } else if (trimmed.startsWith('- ') || trimmed.startsWith('* ')) {
        blocks.add(_BlockData(_BlockType.bullet, trimmed.substring(2).trim()));
      } else if (RegExp(r'^\d+\.\s').hasMatch(trimmed)) {
        final match = RegExp(r'^\d+\.\s').firstMatch(trimmed)!;
        blocks.add(_BlockData(_BlockType.numbered, trimmed.substring(match.end).trim(), prefix: trimmed.substring(0, match.end)));
      } else {
        blocks.add(_BlockData(_BlockType.paragraph, trimmed));
      }
    }

    if (inCodeBlock && codeLines.isNotEmpty) {
      blocks.add(_BlockData(_BlockType.codeBlock, codeLines.join('\n'), lang: codeLang));
    }

    return blocks;
  }

  Widget _buildBlockWidget(BuildContext context, _BlockData block, Color textColor, bool isDark) {
    switch (block.type) {
      case _BlockType.h1:
        return Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: SelectableText(
            block.text,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.3,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
        );
      case _BlockType.h2:
        return Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: SelectableText(
            block.text,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
              color: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B),
            ),
          ),
        );
      case _BlockType.h3:
        return Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: SelectableText(
            block.text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.3,
              color: isDark ? BlogTheme.secondaryCyan : BlogTheme.primaryViolet,
            ),
          ),
        );
      case _BlockType.codeBlock:
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF090D16) : const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: BlogTheme.primaryViolet.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Code Block Header Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (block.lang != null && block.lang!.isNotEmpty) ? block.lang!.toUpperCase() : 'CODE',
                      style: const TextStyle(
                        color: BlogTheme.secondaryCyan,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: block.text));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code snippet copied to clipboard!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(6),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.copy_rounded, size: 14, color: Colors.white70),
                            SizedBox(width: 4),
                            Text('Copy', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Selectable Code Text
              Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SelectableText(
                    block.text,
                    style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 14,
                      color: Color(0xFF38BDF8),
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case _BlockType.bullet:
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, right: 10),
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: BlogTheme.primaryViolet,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: _buildRichText(block.text, textColor),
              ),
            ],
          ),
        );
      case _BlockType.numbered:
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                block.prefix ?? '1. ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: BlogTheme.primaryViolet,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildRichText(block.text, textColor),
              ),
            ],
          ),
        );
      case _BlockType.paragraph:
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _buildRichText(block.text, textColor),
        );
    }
  }

  Widget _buildRichText(String text, Color baseColor) {
    final spans = _parseInlineFormatting(text, baseColor);
    return SelectableText.rich(
      TextSpan(children: spans),
      style: TextStyle(fontSize: 16, height: 1.7, color: baseColor),
    );
  }

  List<TextSpan> _parseInlineFormatting(String text, Color baseColor) {
    final List<TextSpan> spans = [];
    final regex = RegExp(r'(\*\*(.*?)\*\*|\*(.*?)\*|`(.*?)`)');
    int lastMatchEnd = 0;

    for (final match in regex.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      final fullMatch = match.group(0)!;
      if (fullMatch.startsWith('**') && fullMatch.endsWith('**')) {
        spans.add(TextSpan(
          text: match.group(2),
          style: TextStyle(fontWeight: FontWeight.bold, color: baseColor),
        ));
      } else if (fullMatch.startsWith('*') && fullMatch.endsWith('*')) {
        spans.add(TextSpan(
          text: match.group(3),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ));
      } else if (fullMatch.startsWith('`') && fullMatch.endsWith('`')) {
        spans.add(TextSpan(
          text: match.group(4),
          style: const TextStyle(
            fontFamily: 'Courier',
            backgroundColor: Colors.black12,
            color: BlogTheme.secondaryCyan,
            fontWeight: FontWeight.bold,
          ),
        ));
      }

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return spans;
  }
}

enum _BlockType { h1, h2, h3, paragraph, bullet, numbered, codeBlock }

class _BlockData {
  final _BlockType type;
  final String text;
  final String? lang;
  final String? prefix;

  _BlockData(this.type, this.text, {this.lang, this.prefix});
}
