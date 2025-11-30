import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MermaidRenderer extends StatefulWidget {
  final String code;
  final double? height;

  const MermaidRenderer({
    super.key,
    required this.code,
    this.height,
  });

  @override
  State<MermaidRenderer> createState() => _MermaidRendererState();
}

class _MermaidRendererState extends State<MermaidRenderer> {
  double _contentHeight = 200;
  bool _isLoading = true;
  String? _errorMessage;

  String get _html => '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { 
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: transparent;
      display: flex;
      justify-content: center;
      padding: 16px;
    }
    .mermaid { 
      max-width: 100%;
    }
    .error {
      color: #dc3545;
      padding: 16px;
      background: #fff5f5;
      border-radius: 8px;
      font-family: monospace;
      white-space: pre-wrap;
    }
  </style>
</head>
<body>
  <div class="mermaid" id="mermaid-container">
${_escapeHtml(widget.code)}
  </div>
  <script>
    mermaid.initialize({ 
      startOnLoad: true,
      theme: '${_isDark ? 'dark' : 'default'}',
      securityLevel: 'loose',
    });
    
    mermaid.init(undefined, '.mermaid').then(() => {
      setTimeout(() => {
        const container = document.getElementById('mermaid-container');
        const height = container.scrollHeight + 32;
        window.flutter_inappwebview.callHandler('onRendered', height);
      }, 100);
    }).catch((error) => {
      window.flutter_inappwebview.callHandler('onError', error.message || 'Mermaid render error');
    });
  </script>
</body>
</html>
''';

  bool get _isDark =>
      Theme.of(context).brightness == Brightness.dark;

  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return _buildError();
    }

    return Container(
      height: widget.height ?? _contentHeight,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            InAppWebView(
              initialData: InAppWebViewInitialData(
                data: _html,
                mimeType: 'text/html',
                encoding: 'utf-8',
              ),
              initialSettings: InAppWebViewSettings(
                transparentBackground: true,
                javaScriptEnabled: true,
                disableHorizontalScroll: true,
                disableVerticalScroll: false,
              ),
              onWebViewCreated: (controller) {
                controller.addJavaScriptHandler(
                  handlerName: 'onRendered',
                  callback: (args) {
                    if (mounted && args.isNotEmpty) {
                      final height = (args[0] as num).toDouble();
                      setState(() {
                        _contentHeight = height.clamp(100, 600);
                        _isLoading = false;
                      });
                    }
                  },
                );
                controller.addJavaScriptHandler(
                  handlerName: 'onError',
                  callback: (args) {
                    if (mounted && args.isNotEmpty) {
                      setState(() {
                        _errorMessage = args[0].toString();
                        _isLoading = false;
                      });
                    }
                  },
                );
              },
              onLoadStop: (controller, url) {
                // Fallback timeout
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted && _isLoading) {
                    setState(() => _isLoading = false);
                  }
                });
              },
            ),
            if (_isLoading)
              Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Mermaid Error',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage ?? 'Unknown error',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Code:',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SelectableText(
              widget.code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
