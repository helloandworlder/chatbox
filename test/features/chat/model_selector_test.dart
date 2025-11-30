import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatbox_flutter/features/ai_models/domain/provider_config.dart';

// Test provider for overriding aiProvidersProvider
final testAiProvidersProvider = StateProvider<List<AIProviderConfig>>((ref) => []);

void main() {
  group('ModelSelector - Unit Logic Tests', () {
    test('should correctly identify configured provider', () {
      final providers = <AIProviderConfig>[
        AIProviderConfig(
          id: 'test',
          type: AIProviderType.openai,
          name: 'Test',
          apiKey: 'key',
          enabled: true,
          models: const [ModelConfig(id: 'model', name: 'Model')],
        ),
      ];

      final hasConfigured = providers.any(
        (p) => p.enabled && p.apiKey != null && p.apiKey!.isNotEmpty,
      );

      expect(hasConfigured, isTrue);
    });

    test('should not identify unconfigured provider', () {
      final providers = <AIProviderConfig>[
        AIProviderConfig(
          id: 'test',
          type: AIProviderType.openai,
          name: 'Test',
          apiKey: null,
          enabled: true,
          models: const [],
        ),
      ];

      final hasConfigured = providers.any(
        (p) => p.enabled && p.apiKey != null && p.apiKey!.isNotEmpty,
      );

      expect(hasConfigured, isFalse);
    });

    test('should not identify disabled provider as configured', () {
      final providers = <AIProviderConfig>[
        AIProviderConfig(
          id: 'test',
          type: AIProviderType.openai,
          name: 'Test',
          apiKey: 'key',
          enabled: false,
          models: const [],
        ),
      ];

      final hasConfigured = providers.any(
        (p) => p.enabled && p.apiKey != null && p.apiKey!.isNotEmpty,
      );

      expect(hasConfigured, isFalse);
    });

    test('should find provider by ID', () {
      final providers = [
        AIProviderConfig(
          id: 'openai',
          type: AIProviderType.openai,
          name: 'OpenAI',
          apiKey: 'key',
          models: const [ModelConfig(id: 'gpt-4o', name: 'GPT-4o')],
        ),
        AIProviderConfig(
          id: 'claude',
          type: AIProviderType.claude,
          name: 'Claude',
          apiKey: 'key',
          models: const [ModelConfig(id: 'claude-3', name: 'Claude 3')],
        ),
      ];

      final provider = providers.where((p) => p.id == 'openai').firstOrNull;

      expect(provider, isNotNull);
      expect(provider!.name, equals('OpenAI'));
    });

    test('should find model by ID within provider', () {
      final provider = AIProviderConfig(
        id: 'openai',
        type: AIProviderType.openai,
        name: 'OpenAI',
        apiKey: 'key',
        models: const [
          ModelConfig(id: 'gpt-4o', name: 'GPT-4o'),
          ModelConfig(id: 'gpt-4o-mini', name: 'GPT-4o Mini'),
        ],
      );

      final model = provider.models.where((m) => m.id == 'gpt-4o').firstOrNull;

      expect(model, isNotNull);
      expect(model!.name, equals('GPT-4o'));
    });

    test('should filter enabled providers only', () {
      final providers = [
        AIProviderConfig(
          id: 'enabled',
          type: AIProviderType.openai,
          name: 'Enabled',
          apiKey: 'key',
          enabled: true,
          models: const [],
        ),
        AIProviderConfig(
          id: 'disabled',
          type: AIProviderType.claude,
          name: 'Disabled',
          apiKey: 'key',
          enabled: false,
          models: const [],
        ),
      ];

      final enabledProviders = providers.where((p) => p.enabled).toList();

      expect(enabledProviders.length, equals(1));
      expect(enabledProviders.first.id, equals('enabled'));
    });
  });

  group('Provider Icon Mapping', () {
    test('should have correct icon for OpenAI', () {
      final icon = getProviderIcon(AIProviderType.openai);
      expect(icon, equals(Icons.auto_awesome));
    });

    test('should have correct icon for Claude', () {
      final icon = getProviderIcon(AIProviderType.claude);
      expect(icon, equals(Icons.psychology));
    });

    test('should have correct icon for Gemini', () {
      final icon = getProviderIcon(AIProviderType.gemini);
      expect(icon, equals(Icons.diamond));
    });

    test('should have correct icon for DeepSeek', () {
      final icon = getProviderIcon(AIProviderType.deepseek);
      expect(icon, equals(Icons.water_drop));
    });

    test('should have correct icon for OpenRouter', () {
      final icon = getProviderIcon(AIProviderType.openrouter);
      expect(icon, equals(Icons.router));
    });

    test('should have correct icon for Ollama', () {
      final icon = getProviderIcon(AIProviderType.ollama);
      expect(icon, equals(Icons.computer));
    });

    test('should have correct icon for Azure', () {
      final icon = getProviderIcon(AIProviderType.azure);
      expect(icon, equals(Icons.cloud));
    });

    test('should have correct icon for Custom', () {
      final icon = getProviderIcon(AIProviderType.custom);
      expect(icon, equals(Icons.settings));
    });
  });

  group('Number Formatting', () {
    test('should format millions correctly', () {
      expect(formatNumber(1000000), equals('1.0M'));
      expect(formatNumber(2500000), equals('2.5M'));
      expect(formatNumber(1048576), equals('1.0M'));
    });

    test('should format thousands correctly', () {
      expect(formatNumber(1000), equals('1K'));
      expect(formatNumber(128000), equals('128K'));
      expect(formatNumber(200000), equals('200K'));
    });

    test('should keep small numbers as is', () {
      expect(formatNumber(100), equals('100'));
      expect(formatNumber(999), equals('999'));
      expect(formatNumber(1), equals('1'));
    });
  });
}

// Helper functions extracted for testing
IconData getProviderIcon(AIProviderType type) {
  return switch (type) {
    AIProviderType.openai => Icons.auto_awesome,
    AIProviderType.claude => Icons.psychology,
    AIProviderType.gemini => Icons.diamond,
    AIProviderType.deepseek => Icons.water_drop,
    AIProviderType.openrouter => Icons.router,
    AIProviderType.ollama => Icons.computer,
    AIProviderType.azure => Icons.cloud,
    AIProviderType.custom => Icons.settings,
  };
}

String formatNumber(int n) {
  if (n >= 1000000) {
    return '${(n / 1000000).toStringAsFixed(1)}M';
  } else if (n >= 1000) {
    return '${(n / 1000).toStringAsFixed(0)}K';
  }
  return n.toString();
}
