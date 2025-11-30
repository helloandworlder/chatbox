import 'package:dio/dio.dart';
import 'search_engine.dart';

class BingEngine implements SearchEngine {
  final String apiKey;
  final Dio _dio;

  BingEngine({
    required this.apiKey,
    Dio? dio,
  }) : _dio = dio ?? Dio();

  @override
  String get name => 'Bing';

  @override
  Future<List<SearchResult>> search(String query, {int maxResults = 5}) async {
    try {
      final response = await _dio.get(
        'https://api.bing.microsoft.com/v7.0/search',
        queryParameters: {
          'q': query,
          'count': maxResults,
          'responseFilter': 'Webpages',
        },
        options: Options(
          headers: {
            'Ocp-Apim-Subscription-Key': apiKey,
          },
        ),
      );

      final webPages = response.data['webPages']?['value'] as List<dynamic>? ?? [];
      return webPages.map((r) => SearchResult(
        title: r['name'] as String? ?? '',
        snippet: r['snippet'] as String? ?? '',
        url: r['url'] as String? ?? '',
      )).toList();
    } catch (e) {
      throw Exception('Bing search failed: $e');
    }
  }
}
