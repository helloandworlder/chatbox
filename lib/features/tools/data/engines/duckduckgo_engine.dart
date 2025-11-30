import 'package:dio/dio.dart';
import 'search_engine.dart';

class DuckDuckGoEngine implements SearchEngine {
  final Dio _dio;

  DuckDuckGoEngine({Dio? dio}) : _dio = dio ?? Dio();

  @override
  String get name => 'DuckDuckGo';

  @override
  Future<List<SearchResult>> search(String query, {int maxResults = 5}) async {
    try {
      // DuckDuckGo Instant Answer API
      // Note: This API is limited and may not return web results for all queries
      final response = await _dio.get(
        'https://api.duckduckgo.com/',
        queryParameters: {
          'q': query,
          'format': 'json',
          'no_html': '1',
          'skip_disambig': '1',
        },
      );

      final results = <SearchResult>[];
      final data = response.data;

      // Abstract (main result)
      if (data['Abstract'] != null && data['Abstract'].toString().isNotEmpty) {
        results.add(SearchResult(
          title: data['Heading'] as String? ?? query,
          snippet: data['Abstract'] as String,
          url: data['AbstractURL'] as String? ?? '',
        ));
      }

      // Related Topics
      final relatedTopics = data['RelatedTopics'] as List<dynamic>? ?? [];
      for (final topic in relatedTopics) {
        if (results.length >= maxResults) break;
        
        if (topic is Map && topic['Text'] != null) {
          results.add(SearchResult(
            title: _extractTitle(topic['Text'] as String? ?? ''),
            snippet: topic['Text'] as String? ?? '',
            url: topic['FirstURL'] as String? ?? '',
          ));
        }
      }

      // If no results from Instant Answer, try HTML scraping as fallback
      if (results.isEmpty) {
        return _scrapeHtmlResults(query, maxResults);
      }

      return results;
    } catch (e) {
      // Fallback to HTML scraping
      return _scrapeHtmlResults(query, maxResults);
    }
  }

  String _extractTitle(String text) {
    // Extract first sentence or first 50 chars as title
    final firstSentence = text.split('.').first;
    if (firstSentence.length <= 60) return firstSentence;
    return '${firstSentence.substring(0, 57)}...';
  }

  Future<List<SearchResult>> _scrapeHtmlResults(String query, int maxResults) async {
    try {
      // Use DuckDuckGo HTML version
      final response = await _dio.get(
        'https://html.duckduckgo.com/html/',
        queryParameters: {'q': query},
        options: Options(
          headers: {
            'User-Agent': 'Mozilla/5.0 (compatible; Chatbox/2.0)',
          },
        ),
      );

      final html = response.data.toString();
      final results = <SearchResult>[];

      // Simple regex-based parsing (not ideal but works for basic cases)
      final linkPattern = RegExp(
        r'<a[^>]+class="result__a"[^>]*href="([^"]*)"[^>]*>([^<]*)</a>',
        caseSensitive: false,
      );
      final snippetPattern = RegExp(
        r'<a[^>]+class="result__snippet"[^>]*>([^<]*)</a>',
        caseSensitive: false,
      );

      final linkMatches = linkPattern.allMatches(html).toList();
      final snippetMatches = snippetPattern.allMatches(html).toList();

      for (var i = 0; i < linkMatches.length && results.length < maxResults; i++) {
        final linkMatch = linkMatches[i];
        final url = _decodeUrl(linkMatch.group(1) ?? '');
        final title = _decodeHtml(linkMatch.group(2) ?? '');
        final snippet = i < snippetMatches.length 
            ? _decodeHtml(snippetMatches[i].group(1) ?? '')
            : '';

        if (url.isNotEmpty && title.isNotEmpty) {
          results.add(SearchResult(
            title: title,
            snippet: snippet,
            url: url,
          ));
        }
      }

      return results;
    } catch (e) {
      return [];
    }
  }

  String _decodeUrl(String url) {
    // DuckDuckGo uses redirect URLs, try to extract actual URL
    if (url.contains('uddg=')) {
      final match = RegExp(r'uddg=([^&]+)').firstMatch(url);
      if (match != null) {
        return Uri.decodeComponent(match.group(1) ?? url);
      }
    }
    return url;
  }

  String _decodeHtml(String html) {
    return html
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('<b>', '')
        .replaceAll('</b>', '')
        .trim();
  }
}
