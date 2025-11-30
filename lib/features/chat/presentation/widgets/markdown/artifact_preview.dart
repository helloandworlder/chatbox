import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ArtifactPreview extends StatefulWidget {
  final String htmlContent;
  final bool autoPreview;
  final String? title;

  const ArtifactPreview({
    super.key,
    required this.htmlContent,
    this.autoPreview = false,
    this.title,
  });

  @override
  State<ArtifactPreview> createState() => _ArtifactPreviewState();
}

class _ArtifactPreviewState extends State<ArtifactPreview> {
  bool _isExpanded = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.autoPreview;
  }

  String get _wrappedHtml => '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    * { box-sizing: border-box; }
    body { 
      margin: 0; 
      padding: 16px;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: white;
    }
  </style>
</head>
<body>
${widget.htmlContent}
</body>
</html>
''';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(8),
                  bottom: _isExpanded ? Radius.zero : const Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.code,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.title ?? 'HTML Artifact',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Copy HTML',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.htmlContent));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('HTML copied to clipboard'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  if (_isExpanded) ...[
                    IconButton(
                      icon: const Icon(Icons.fullscreen, size: 18),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Fullscreen',
                      onPressed: _openFullscreen,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),

          // Preview
          if (_isExpanded)
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
                child: Stack(
                  children: [
                    InAppWebView(
                      initialData: InAppWebViewInitialData(
                        data: _wrappedHtml,
                        mimeType: 'text/html',
                        encoding: 'utf-8',
                      ),
                      initialSettings: InAppWebViewSettings(
                        transparentBackground: false,
                        javaScriptEnabled: true,
                        supportZoom: true,
                      ),
                      onLoadStop: (controller, url) {
                        if (mounted) {
                          setState(() => _isLoading = false);
                        }
                      },
                    ),
                    if (_isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _openFullscreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _FullscreenPreview(
          html: _wrappedHtml,
          title: widget.title,
        ),
      ),
    );
  }
}

class _FullscreenPreview extends StatelessWidget {
  final String html;
  final String? title;

  const _FullscreenPreview({
    required this.html,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh handled by WebView
            },
          ),
        ],
      ),
      body: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: html,
          mimeType: 'text/html',
          encoding: 'utf-8',
        ),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          supportZoom: true,
        ),
      ),
    );
  }
}
