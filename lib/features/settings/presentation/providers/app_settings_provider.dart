import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../domain/app_settings.dart';

const _settingsKey = 'app_settings';

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier(ref);
});

class AppSettingsNotifier extends StateNotifier<AppSettings> {
  final Ref _ref;

  AppSettingsNotifier(this._ref) : super(const AppSettings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final db = _ref.read(databaseProvider);
    final json = await db.getSetting(_settingsKey);
    if (json != null) {
      try {
        final map = jsonDecode(json) as Map<String, dynamic>;
        state = AppSettings.fromJson(map);
      } catch (e) {
        // Invalid JSON, keep default
      }
    }
  }

  Future<void> _saveSettings() async {
    final db = _ref.read(databaseProvider);
    final json = jsonEncode(state.toJson());
    await db.setSetting(_settingsKey, json);
  }

  // ===== 默认模型 =====
  Future<void> setDefaultChatModel(String? value) async {
    state = state.copyWith(defaultChatModel: value);
    await _saveSettings();
  }

  Future<void> setDefaultNamingModel(String? value) async {
    state = state.copyWith(defaultNamingModel: value);
    await _saveSettings();
  }

  Future<void> setDefaultSearchQueryModel(String? value) async {
    state = state.copyWith(defaultSearchQueryModel: value);
    await _saveSettings();
  }

  Future<void> setOcrModel(String? value) async {
    state = state.copyWith(ocrModel: value);
    await _saveSettings();
  }

  // ===== 联网搜索 =====
  Future<void> setSearchProvider(String value) async {
    state = state.copyWith(searchProvider: value);
    await _saveSettings();
  }

  Future<void> setTavilyApiKey(String? value) async {
    state = state.copyWith(tavilyApiKey: value);
    await _saveSettings();
  }

  Future<void> setBingApiKey(String? value) async {
    state = state.copyWith(bingApiKey: value);
    await _saveSettings();
  }

  Future<void> setTavilySearchDepth(String value) async {
    state = state.copyWith(tavilySearchDepth: value);
    await _saveSettings();
  }

  Future<void> setSearchMaxResults(int value) async {
    state = state.copyWith(searchMaxResults: value);
    await _saveSettings();
  }

  // ===== MCP 配置 =====
  Future<void> setMcpServersJson(String? value) async {
    state = state.copyWith(mcpServersJson: value);
    await _saveSettings();
  }

  Future<void> setMcpAutoConnect(bool value) async {
    state = state.copyWith(mcpAutoConnect: value);
    await _saveSettings();
  }

  // ===== 外观设置 =====
  Future<void> setLocale(String value) async {
    state = state.copyWith(locale: value);
    await _saveSettings();
  }

  Future<void> setThemeMode(String value) async {
    state = state.copyWith(themeMode: value);
    await _saveSettings();
  }

  // ===== 头像 =====
  Future<void> setUserAvatarPath(String? value) async {
    state = state.copyWith(userAvatarPath: value);
    await _saveSettings();
  }

  Future<void> setAssistantAvatarPath(String? value) async {
    state = state.copyWith(assistantAvatarPath: value);
    await _saveSettings();
  }

  // ===== 新对话默认设置 =====
  Future<void> setDefaultSystemPrompt(String value) async {
    state = state.copyWith(defaultSystemPrompt: value);
    await _saveSettings();
  }

  Future<void> setMaxContextMessages(int value) async {
    state = state.copyWith(maxContextMessages: value);
    await _saveSettings();
  }

  Future<void> setDefaultTemperature(double? value) async {
    state = state.copyWith(defaultTemperature: value);
    await _saveSettings();
  }

  Future<void> setDefaultTopP(double? value) async {
    state = state.copyWith(defaultTopP: value);
    await _saveSettings();
  }

  Future<void> setStreamingOutput(bool value) async {
    state = state.copyWith(streamingOutput: value);
    await _saveSettings();
  }

  // ===== 显示设置 =====
  Future<void> setShowWordCount(bool value) async {
    state = state.copyWith(showWordCount: value);
    await _saveSettings();
  }

  Future<void> setShowTokenUsage(bool value) async {
    state = state.copyWith(showTokenUsage: value);
    await _saveSettings();
  }

  Future<void> setShowModelName(bool value) async {
    state = state.copyWith(showModelName: value);
    await _saveSettings();
  }

  Future<void> setShowTimestamp(bool value) async {
    state = state.copyWith(showTimestamp: value);
    await _saveSettings();
  }

  Future<void> setShowFirstTokenLatency(bool value) async {
    state = state.copyWith(showFirstTokenLatency: value);
    await _saveSettings();
  }

  // ===== 功能设置 =====
  Future<void> setAutoCollapseCodeBlocks(bool value) async {
    state = state.copyWith(autoCollapseCodeBlocks: value);
    await _saveSettings();
  }

  Future<void> setAutoGenerateChatTitle(bool value) async {
    state = state.copyWith(autoGenerateChatTitle: value);
    await _saveSettings();
  }

  Future<void> setSpellCheck(bool value) async {
    state = state.copyWith(spellCheck: value);
    await _saveSettings();
  }

  Future<void> setMarkdownRendering(bool value) async {
    state = state.copyWith(markdownRendering: value);
    await _saveSettings();
  }

  Future<void> setLatexRendering(bool value) async {
    state = state.copyWith(latexRendering: value);
    await _saveSettings();
  }

  Future<void> setMermaidRendering(bool value) async {
    state = state.copyWith(mermaidRendering: value);
    await _saveSettings();
  }

  Future<void> setInjectDefaultMetadata(bool value) async {
    state = state.copyWith(injectDefaultMetadata: value);
    await _saveSettings();
  }

  Future<void> setAutoPreviewArtifacts(bool value) async {
    state = state.copyWith(autoPreviewArtifacts: value);
    await _saveSettings();
  }

  Future<void> setPasteLongTextAsFile(bool value) async {
    state = state.copyWith(pasteLongTextAsFile: value);
    await _saveSettings();
  }

  // ===== 重置 =====
  Future<void> resetToDefaults() async {
    state = const AppSettings();
    await _saveSettings();
  }
}
