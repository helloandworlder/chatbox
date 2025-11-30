import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_engine.freezed.dart';
part 'search_engine.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String title,
    required String snippet,
    required String url,
    String? rawContent,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

abstract class SearchEngine {
  String get name;
  
  Future<List<SearchResult>> search(String query, {int maxResults = 5});
}
