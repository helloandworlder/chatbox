import 'package:dio/dio.dart';
import 'search_engine.dart';

class TavilyEngine implements SearchEngine {
  final String apiKey;
  final String searchDepth;
  final Dio _dio;

  TavilyEngine({
    required this.apiKey,
    this.searchDepth = 'basic',
    Dio? dio,
  }) : _dio = dio ?? Dio();

  @override
  String get name => 'Tavily';

  @override
  Future<List<SearchResult>> search(String query, {int maxResults = 5}) async {
    try {
      final response = await _dio.post(
        'https://api.tavily.com/search',
        data: {
          'api_key': apiKey,
          'query': query,
          'search_depth': searchDepth,
          'max_results': maxResults,
          'include_raw_content': false,
        },
      );

      final results = response.data['results'] as List<dynamic>? ?? [];
      return results.map((r) => SearchResult(
        title: r['title'] as String? ?? '',
        snippet: r['content'] as String? ?? '',
        url: r['url'] as String? ?? '',
        rawContent: r['raw_content'] as String?,
      )).toList();
    } catch (e) {
      throw Exception('Tavily search failed: $e');
    }
  }
}
