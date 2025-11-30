import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../data/llm_service.dart';
import '../../data/model_fetcher.dart';
import '../../domain/provider_config.dart';

final llmServiceProvider = Provider<LLMService>((ref) {
  return LLMService();
});

final modelFetcherProvider = Provider<ModelFetcher>((ref) {
  return ModelFetcher();
});

final aiProvidersProvider =
    StateNotifierProvider<AIProvidersNotifier, List<AIProviderConfig>>((ref) {
  return AIProvidersNotifier(ref);
});

final currentProviderIdProvider = StateProvider<String?>((ref) => null);
final currentModelIdProvider = StateProvider<String?>((ref) => null);

class AIProvidersNotifier extends StateNotifier<List<AIProviderConfig>> {
  final Ref _ref;
  bool _initialized = false;

  AIProvidersNotifier(this._ref) : super([]) {
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    if (_initialized) return;
    _initialized = true;

    final db = _ref.read(databaseProvider);
    final json = await db.getSetting('ai_providers');
    if (json != null) {
      try {
        final list = jsonDecode(json) as List;
        state = list.map((e) => AIProviderConfig.fromJson(e)).toList();
        _registerAllProviders();
        _setDefaultSelection();
      } catch (e) {
        // Ignore parse errors, use default empty list
      }
    }
  }

  void _registerAllProviders() {
    final llm = _ref.read(llmServiceProvider);
    for (final config in state) {
      if (config.enabled) {
        llm.registerProvider(config);
      }
    }
  }

  void _setDefaultSelection() {
    if (state.isEmpty) return;

    final currentProviderId = _ref.read(currentProviderIdProvider);
    if (currentProviderId == null) {
      final firstEnabled = state.where((p) => p.enabled).firstOrNull;
      if (firstEnabled != null) {
        _ref.read(currentProviderIdProvider.notifier).state = firstEnabled.id;
        if (firstEnabled.models.isNotEmpty) {
          _ref.read(currentModelIdProvider.notifier).state =
              firstEnabled.models.first.id;
        }
      }
    }
  }

  Future<void> _saveProviders() async {
    final db = _ref.read(databaseProvider);
    final json = jsonEncode(state.map((e) => e.toJson()).toList());
    await db.setSetting('ai_providers', json);
  }

  Future<void> addProvider(AIProviderConfig config) async {
    final configWithModels = config.models.isEmpty
        ? config.copyWith(models: _getDefaultModels(config.type))
        : config;

    state = [...state, configWithModels];
    await _saveProviders();

    if (configWithModels.enabled) {
      _ref.read(llmServiceProvider).registerProvider(configWithModels);
    }

    _setDefaultSelection();
  }

  Future<void> updateProvider(AIProviderConfig config) async {
    final index = state.indexWhere((p) => p.id == config.id);
    if (index == -1) return;

    state = [
      ...state.sublist(0, index),
      config,
      ...state.sublist(index + 1),
    ];
    await _saveProviders();

    final llm = _ref.read(llmServiceProvider);
    llm.unregisterProvider(config.id);
    if (config.enabled) {
      llm.registerProvider(config);
    }
  }

  Future<void> removeProvider(String id) async {
    state = state.where((p) => p.id != id).toList();
    await _saveProviders();

    _ref.read(llmServiceProvider).unregisterProvider(id);

    if (_ref.read(currentProviderIdProvider) == id) {
      _ref.read(currentProviderIdProvider.notifier).state = null;
      _ref.read(currentModelIdProvider.notifier).state = null;
      _setDefaultSelection();
    }
  }

  /// 从 API 刷新提供商的模型列表
  Future<List<ModelConfig>> refreshModels(String providerId) async {
    final index = state.indexWhere((p) => p.id == providerId);
    if (index == -1) return [];

    final config = state[index];
    final fetcher = _ref.read(modelFetcherProvider);
    
    try {
      final models = await fetcher.fetchModels(config);
      if (models.isNotEmpty) {
        final updatedConfig = config.copyWith(models: models);
        state = [
          ...state.sublist(0, index),
          updatedConfig,
          ...state.sublist(index + 1),
        ];
        await _saveProviders();
        
        // 重新注册提供商
        final llm = _ref.read(llmServiceProvider);
        llm.unregisterProvider(providerId);
        if (updatedConfig.enabled) {
          llm.registerProvider(updatedConfig);
        }
        
        return models;
      }
    } catch (e) {
      // 获取失败，保持原有模型列表
      rethrow;
    }
    
    return config.models;
  }

  /// 添加模型到指定提供商
  Future<void> addModel(String providerId, ModelConfig model) async {
    final index = state.indexWhere((p) => p.id == providerId);
    if (index == -1) return;

    final config = state[index];
    // 检查是否已存在
    if (config.models.any((m) => m.id == model.id)) return;

    final updatedConfig = config.copyWith(
      models: [...config.models, model],
    );
    
    state = [
      ...state.sublist(0, index),
      updatedConfig,
      ...state.sublist(index + 1),
    ];
    await _saveProviders();
    
    // 重新注册到 LLM 服务
    _reregisterProvider(updatedConfig);
  }

  /// 更新提供商中的模型
  Future<void> updateModel(String providerId, ModelConfig model) async {
    final providerIndex = state.indexWhere((p) => p.id == providerId);
    if (providerIndex == -1) return;

    final config = state[providerIndex];
    final modelIndex = config.models.indexWhere((m) => m.id == model.id);
    if (modelIndex == -1) return;

    final updatedModels = [
      ...config.models.sublist(0, modelIndex),
      model,
      ...config.models.sublist(modelIndex + 1),
    ];

    final updatedConfig = config.copyWith(models: updatedModels);
    
    state = [
      ...state.sublist(0, providerIndex),
      updatedConfig,
      ...state.sublist(providerIndex + 1),
    ];
    await _saveProviders();
    
    // 重新注册到 LLM 服务
    _reregisterProvider(updatedConfig);
  }

  /// 从提供商删除模型
  Future<void> removeModel(String providerId, String modelId) async {
    final index = state.indexWhere((p) => p.id == providerId);
    if (index == -1) return;

    final config = state[index];
    final updatedConfig = config.copyWith(
      models: config.models.where((m) => m.id != modelId).toList(),
    );
    
    state = [
      ...state.sublist(0, index),
      updatedConfig,
      ...state.sublist(index + 1),
    ];
    await _saveProviders();
    
    // 重新注册到 LLM 服务
    _reregisterProvider(updatedConfig);

    // 如果当前选中的模型被删除，切换到其他模型
    if (_ref.read(currentModelIdProvider) == modelId) {
      _ref.read(currentModelIdProvider.notifier).state =
          updatedConfig.models.firstOrNull?.id;
    }
  }

  /// 重置提供商模型为默认列表
  Future<void> resetModels(String providerId) async {
    final index = state.indexWhere((p) => p.id == providerId);
    if (index == -1) return;

    final config = state[index];
    final defaultModels = _getDefaultModels(config.type);
    
    final updatedConfig = config.copyWith(models: defaultModels);
    
    state = [
      ...state.sublist(0, index),
      updatedConfig,
      ...state.sublist(index + 1),
    ];
    await _saveProviders();
    
    // 重新注册到 LLM 服务
    _reregisterProvider(updatedConfig);
  }

  /// 重新注册 provider 到 LLM 服务
  void _reregisterProvider(AIProviderConfig config) {
    final llm = _ref.read(llmServiceProvider);
    llm.unregisterProvider(config.id);
    if (config.enabled) {
      llm.registerProvider(config);
    }
  }

  List<ModelConfig> _getDefaultModels(AIProviderType type) {
    return switch (type) {
      AIProviderType.openai => defaultOpenAIModels,
      AIProviderType.claude => defaultClaudeModels,
      AIProviderType.gemini => defaultGeminiModels,
      AIProviderType.deepseek => defaultDeepSeekModels,
      AIProviderType.openrouter => defaultOpenRouterModels,
      AIProviderType.ollama => defaultOllamaModels,
      _ => [],
    };
  }
}

final availableModelsProvider = Provider<List<ModelConfig>>((ref) {
  final providers = ref.watch(aiProvidersProvider);
  final currentProviderId = ref.watch(currentProviderIdProvider);

  if (currentProviderId == null) return [];

  final provider = providers.where((p) => p.id == currentProviderId).firstOrNull;
  return provider?.models ?? [];
});

final hasConfiguredProviderProvider = Provider<bool>((ref) {
  final providers = ref.watch(aiProvidersProvider);
  return providers.any((p) => p.enabled && p.apiKey != null && p.apiKey!.isNotEmpty);
});
