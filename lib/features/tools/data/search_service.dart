import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/domain/app_settings.dart';
import '../../settings/presentation/providers/app_settings_provider.dart';
import 'engines/search_engine.dart';
import 'engines/tavily_engine.dart';
import 'engines/bing_engine.dart';
import 'engines/duckduckgo_engine.dart';

export 'engines/search_engine.dart' show SearchResult;

final searchServiceProvider = Provider<SearchService>((ref) {
  final settings = ref.watch(appSettingsProvider);
  return SearchService(settings);
});

class SearchService {
  final AppSettings _settings;

  SearchService(this._settings);

  SearchEngine? _getEngine() {
    switch (_settings.searchProvider) {
      case 'tavily':
        if (_settings.tavilyApiKey?.isNotEmpty == true) {
          return TavilyEngine(
            apiKey: _settings.tavilyApiKey!,
            searchDepth: _settings.tavilySearchDepth,
          );
        }
        return null;
      case 'bing':
        if (_settings.bingApiKey?.isNotEmpty == true) {
          return BingEngine(apiKey: _settings.bingApiKey!);
        }
        return null;
      case 'duckduckgo':
        return DuckDuckGoEngine();
      default:
        return null;
    }
  }

  bool get isConfigured => _getEngine() != null;

  String get providerName => _settings.searchProvider;

  Future<List<SearchResult>> search(String query) async {
    final engine = _getEngine();
    if (engine == null) {
      throw Exception('Search engine not configured');
    }
    return engine.search(query, maxResults: _settings.searchMaxResults);
  }

  Future<String> searchAndFormat(String query) async {
    final results = await search(query);
    if (results.isEmpty) {
      return 'No search results found.';
    }

    final buffer = StringBuffer();
    for (var i = 0; i < results.length; i++) {
      final r = results[i];
      buffer.writeln('${i + 1}. ${r.title}');
      buffer.writeln('   URL: ${r.url}');
      buffer.writeln('   ${r.snippet}');
      buffer.writeln();
    }
    return buffer.toString();
  }
}
