import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/highlight.dart' as hl;
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:markdown/markdown.dart' as md;

import 'mermaid_renderer.dart';
import 'artifact_preview.dart';

class MarkdownRenderer extends StatelessWidget {
  final String content;
  final bool selectable;
  final bool enableMermaid;
  final bool enableArtifacts;
  final bool autoPreviewArtifacts;

  const MarkdownRenderer({
    super.key,
    required this.content,
    this.selectable = true,
    this.enableMermaid = true,
    this.enableArtifacts = true,
    this.autoPreviewArtifacts = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Pre-process content to handle LaTeX blocks
    final processedContent = _processLatexBlocks(content);

    return MarkdownBody(
      data: processedContent,
      selectable: selectable,
      onTapLink: (text, href, title) {
        if (href != null) {
          _launchUrl(href);
        }
      },
      styleSheet: _buildStyleSheet(context),
      builders: {
        'pre': CodeBlockBuilder(
          isDark: isDark,
          enableMermaid: enableMermaid,
          enableArtifacts: enableArtifacts,
          autoPreviewArtifacts: autoPreviewArtifacts,
        ),
        'latex': LatexElementBuilder(),
        'latexblock': LatexElementBuilder(displayMode: true),
      },
      inlineSyntaxes: [
        LatexInlineSyntax(),
      ],
      blockSyntaxes: [
        LatexBlockSyntax(),
      ],
    );
  }

  String _processLatexBlocks(String content) {
    // Convert $$ ... $$ blocks to custom tags
    return content.replaceAllMapped(
      RegExp(r'\$\$(.+?)\$\$', dotAll: true),
      (match) => '<latexblock>${match.group(1)}</latexblock>',
    );
  }

  MarkdownStyleSheet _buildStyleSheet(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MarkdownStyleSheet(
      p: theme.textTheme.bodyMedium,
      h1: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      h2: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      h3: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      h4: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      h5: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      h6: theme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      code: TextStyle(
        backgroundColor: colorScheme.surfaceContainerHighest,
        fontFamily: 'monospace',
        fontSize: 13,
      ),
      codeblockDecoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      blockquote: TextStyle(
        color: colorScheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      ),
      blockquoteDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: colorScheme.primary,
            width: 4,
          ),
        ),
      ),
      blockquotePadding: const EdgeInsets.only(left: 16),
      a: TextStyle(
        color: colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
      listBullet: theme.textTheme.bodyMedium,
      tableHead: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      tableBody: theme.textTheme.bodyMedium,
      tableBorder: TableBorder.all(
        color: colorScheme.outlineVariant,
        width: 1,
      ),
      tableCellsPadding: const EdgeInsets.all(8),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class CodeBlockBuilder extends MarkdownElementBuilder {
  final bool isDark;
  final bool enableMermaid;
  final bool enableArtifacts;
  final bool autoPreviewArtifacts;

  CodeBlockBuilder({
    required this.isDark,
    this.enableMermaid = true,
    this.enableArtifacts = true,
    this.autoPreviewArtifacts = false,
  });

  @override
  Widget visitElementAfter(element, preferredStyle) {
    final code = element.textContent;
    String language = '';

    // Extract language from class attribute
    if (element.attributes.containsKey('class')) {
      final classes = element.attributes['class']!;
      final match = RegExp(r'language-(\w+)').firstMatch(classes);
      if (match != null) {
        language = match.group(1) ?? '';
      }
    }

    // Handle Mermaid diagrams
    if (enableMermaid && language.toLowerCase() == 'mermaid') {
      return MermaidRenderer(code: code.trim());
    }

    // Handle HTML artifacts
    if (enableArtifacts && 
        (language.toLowerCase() == 'html' || language.toLowerCase() == 'artifact')) {
      return ArtifactPreview(
        htmlContent: code.trim(),
        autoPreview: autoPreviewArtifacts,
        title: language.toLowerCase() == 'artifact' ? 'Artifact' : 'HTML Preview',
      );
    }

    return CodeBlockWidget(
      code: code,
      language: language,
      isDark: isDark,
    );
  }
}

class CodeBlockWidget extends StatelessWidget {
  final String code;
  final String language;
  final bool isDark;

  const CodeBlockWidget({
    super.key,
    required this.code,
    required this.language,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = isDark ? atomOneDarkTheme : atomOneLightTheme;

    hl.Result? highlighted;
    try {
      if (language.isNotEmpty) {
        // Try to parse with specified language, fallback to auto detection
        try {
          highlighted = hl.highlight.parse(code.trim(), language: language);
        } catch (_) {
          highlighted = hl.highlight.parse(code.trim(), autoDetection: true);
        }
      } else {
        highlighted = hl.highlight.parse(code.trim(), autoDetection: true);
      }
    } catch (_) {
      highlighted = null;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF282C34) : const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(51),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withAlpha(128),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                if (language.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      language.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Copy code',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code.trim()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Code copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(12),
            child: highlighted != null
                ? _buildHighlightedCode(highlighted, theme)
                : SelectableText(
                    code.trim(),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedCode(
    hl.Result result,
    Map<String, TextStyle> theme,
  ) {
    final spans = <TextSpan>[];
    _buildSpans(result.nodes!, spans, theme);

    return SelectableText.rich(
      TextSpan(
        children: spans,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: theme['root']?.color,
        ),
      ),
    );
  }

  void _buildSpans(
    List<hl.Node> nodes,
    List<TextSpan> spans,
    Map<String, TextStyle> theme,
  ) {
    for (final node in nodes) {
      if (node.value != null) {
        spans.add(TextSpan(
          text: node.value,
          style: theme[node.className],
        ));
      } else if (node.children != null) {
        _buildSpans(node.children!, spans, theme);
      }
    }
  }
}

// LaTeX inline syntax for $...$
class LatexInlineSyntax extends md.InlineSyntax {
  LatexInlineSyntax() : super(r'\$([^\$]+)\$');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final latex = match.group(1)!;
    final element = md.Element.text('latex', latex);
    parser.addNode(element);
    return true;
  }
}

// LaTeX block syntax for $$...$$
class LatexBlockSyntax extends md.BlockSyntax {
  @override
  RegExp get pattern => RegExp(r'^\$\$(.*)$');

  @override
  md.Node parse(md.BlockParser parser) {
    final buffer = StringBuffer();
    parser.advance();
    
    while (!parser.isDone) {
      final line = parser.current.content;
      if (line.contains(r'$$')) {
        final endIndex = line.indexOf(r'$$');
        if (endIndex > 0) {
          buffer.write(line.substring(0, endIndex));
        }
        parser.advance();
        break;
      }
      buffer.writeln(line);
      parser.advance();
    }
    
    return md.Element.text('latexblock', buffer.toString().trim());
  }
}

// LaTeX element builder
class LatexElementBuilder extends MarkdownElementBuilder {
  final bool displayMode;

  LatexElementBuilder({this.displayMode = false});

  @override
  Widget visitElementAfter(element, preferredStyle) {
    return LatexWidget(
      latex: element.textContent,
      displayMode: displayMode,
    );
  }
}

class LatexWidget extends StatelessWidget {
  final String latex;
  final bool displayMode;

  const LatexWidget({
    super.key,
    required this.latex,
    this.displayMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Container(
      padding: displayMode
          ? const EdgeInsets.symmetric(vertical: 8)
          : EdgeInsets.zero,
      alignment: displayMode ? Alignment.center : null,
      child: Math.tex(
        latex,
        textStyle: TextStyle(
          fontSize: displayMode ? 18 : 14,
          color: textColor,
        ),
        onErrorFallback: (error) {
          return Text(
            displayMode ? '\$\$$latex\$\$' : '\$$latex\$',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontFamily: 'monospace',
            ),
          );
        },
      ),
    );
  }
}
