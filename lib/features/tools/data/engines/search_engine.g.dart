// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_engine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      title: json['title'] as String,
      snippet: json['snippet'] as String,
      url: json['url'] as String,
      rawContent: json['rawContent'] as String?,
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'snippet': instance.snippet,
      'url': instance.url,
      'rawContent': instance.rawContent,
    };
