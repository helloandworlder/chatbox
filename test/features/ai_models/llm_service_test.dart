import 'package:flutter_test/flutter_test.dart';
import 'package:langchain/langchain.dart';

import 'package:chatbox_flutter/features/ai_models/data/llm_service.dart';
import 'package:chatbox_flutter/features/ai_models/domain/provider_config.dart';

void main() {
  group('LLMService', () {
    late LLMService llmService;

    setUp(() {
      llmService = LLMService();
    });

    group('Provider Registration', () {
      test('should register OpenAI provider with valid API key', () {
        final config = AIProviderConfig(
          id: 'test-openai',
          type: AIProviderType.openai,
          name: 'Test OpenAI',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'gpt-4o', name: 'GPT-4o'),
          ],
        );

        llmService.registerProvider(config);

        expect(llmService.hasProvider('test-openai'), isTrue);
        expect(llmService.getAvailableModels('test-openai'), contains('gpt-4o'));
      });

      test('should not register provider without API key (except Ollama)', () {
        final config = AIProviderConfig(
          id: 'test-no-key',
          type: AIProviderType.openai,
          name: 'Test No Key',
          apiKey: null,
          models: const [
            ModelConfig(id: 'gpt-4o', name: 'GPT-4o'),
          ],
        );

        llmService.registerProvider(config);

        expect(llmService.hasProvider('test-no-key'), isFalse);
      });

      test('should register Ollama provider without API key', () {
        final config = AIProviderConfig(
          id: 'test-ollama',
          type: AIProviderType.ollama,
          name: 'Test Ollama',
          apiKey: null,
          baseUrl: 'http://localhost:11434/api',
          models: const [
            ModelConfig(id: 'llama3.3', name: 'Llama 3.3'),
          ],
        );

        llmService.registerProvider(config);

        expect(llmService.hasProvider('test-ollama'), isTrue);
        expect(llmService.getAvailableModels('test-ollama'), contains('llama3.3'));
      });

      test('should register Claude provider', () {
        final config = AIProviderConfig(
          id: 'test-claude',
          type: AIProviderType.claude,
          name: 'Test Claude',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'claude-3-5-sonnet-20241022', name: 'Claude 3.5 Sonnet'),
          ],
        );

        llmService.registerProvider(config);

        expect(llmService.hasProvider('test-claude'), isTrue);
      });

      test('should register Gemini provider with OpenAI compatible API', () {
        final config = AIProviderConfig(
          id: 'test-gemini',
          type: AIProviderType.gemini,
          name: 'Test Gemini',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'gemini-2.0-flash', name: 'Gemini 2.0 Flash'),
          ],
        );

        llmService.registerProvider(config);

        expect(llmService.hasProvider('test-gemini'), isTrue);
      });

      test('should register DeepSeek provider', () {
        final config = AIProviderConfig(
          id: 'test-deepseek',
          type: AIProviderType.deepseek,
          name: 'Test DeepSeek',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'deepseek-chat', name: 'DeepSeek V3'),
          ],
        );

        llmService.registerProvider(config);

        expect(llmService.hasProvider('test-deepseek'), isTrue);
      });

      test('should register OpenRouter provider', () {
        final config = AIProviderConfig(
          id: 'test-openrouter',
          type: AIProviderType.openrouter,
          name: 'Test OpenRouter',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'openai/gpt-4o', name: 'GPT-4o (via OpenRouter)'),
          ],
        );

        llmService.registerProvider(config);

        expect(llmService.hasProvider('test-openrouter'), isTrue);
      });

      test('should register custom OpenAI compatible provider', () {
        final config = AIProviderConfig(
          id: 'test-custom',
          type: AIProviderType.custom,
          name: 'Test Custom',
          apiKey: 'test-api-key',
          baseUrl: 'https://custom-api.example.com/v1',
          models: const [
            ModelConfig(id: 'custom-model', name: 'Custom Model'),
          ],
        );

        llmService.registerProvider(config);

        expect(llmService.hasProvider('test-custom'), isTrue);
      });

      test('custom provider without baseUrl registers but has no models', () {
        final config = AIProviderConfig(
          id: 'test-custom-no-url',
          type: AIProviderType.custom,
          name: 'Test Custom No URL',
          apiKey: 'test-api-key',
          baseUrl: null,
          models: const [
            ModelConfig(id: 'custom-model', name: 'Custom Model'),
          ],
        );

        llmService.registerProvider(config);

        // Provider is registered but no models are available since baseUrl is null
        expect(llmService.getAvailableModels('test-custom-no-url'), isEmpty);
      });
    });

    group('Provider Unregistration', () {
      test('should unregister provider', () {
        final config = AIProviderConfig(
          id: 'test-openai',
          type: AIProviderType.openai,
          name: 'Test OpenAI',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'gpt-4o', name: 'GPT-4o'),
            ModelConfig(id: 'gpt-4o-mini', name: 'GPT-4o Mini'),
          ],
        );

        llmService.registerProvider(config);
        expect(llmService.hasProvider('test-openai'), isTrue);

        llmService.unregisterProvider('test-openai');
        expect(llmService.hasProvider('test-openai'), isFalse);
        expect(llmService.getAvailableModels('test-openai'), isEmpty);
      });
    });

    group('Model Access', () {
      test('should return model for registered provider', () {
        final config = AIProviderConfig(
          id: 'test-openai',
          type: AIProviderType.openai,
          name: 'Test OpenAI',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'gpt-4o', name: 'GPT-4o'),
          ],
        );

        llmService.registerProvider(config);
        final model = llmService.getModel('test-openai', 'gpt-4o');

        expect(model, isNotNull);
        expect(model, isA<BaseChatModel>());
      });

      test('should return null for non-existent model', () {
        final model = llmService.getModel('non-existent', 'gpt-4o');
        expect(model, isNull);
      });

      test('should return all available models for provider', () {
        final config = AIProviderConfig(
          id: 'test-openai',
          type: AIProviderType.openai,
          name: 'Test OpenAI',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'gpt-4o', name: 'GPT-4o'),
            ModelConfig(id: 'gpt-4o-mini', name: 'GPT-4o Mini'),
            ModelConfig(id: 'gpt-4-turbo', name: 'GPT-4 Turbo'),
          ],
        );

        llmService.registerProvider(config);
        final models = llmService.getAvailableModels('test-openai');

        expect(models.length, equals(3));
        expect(models, containsAll(['gpt-4o', 'gpt-4o-mini', 'gpt-4-turbo']));
      });
    });

    group('Chat Exception Handling', () {
      test('should throw exception for non-existent provider', () {
        expect(
          () async {
            await for (final _ in llmService.streamChat(
              providerId: 'non-existent',
              modelId: 'gpt-4o',
              messages: [ChatMessage.humanText('Hello')],
            )) {}
          },
          throwsException,
        );
      });

      test('should throw exception for non-existent model', () {
        final config = AIProviderConfig(
          id: 'test-openai',
          type: AIProviderType.openai,
          name: 'Test OpenAI',
          apiKey: 'test-api-key',
          models: const [
            ModelConfig(id: 'gpt-4o', name: 'GPT-4o'),
          ],
        );

        llmService.registerProvider(config);

        expect(
          () async {
            await for (final _ in llmService.streamChat(
              providerId: 'test-openai',
              modelId: 'non-existent-model',
              messages: [ChatMessage.humanText('Hello')],
            )) {}
          },
          throwsException,
        );
      });
    });

    group('Multiple Providers', () {
      test('should support multiple providers simultaneously', () {
        final openaiConfig = AIProviderConfig(
          id: 'openai',
          type: AIProviderType.openai,
          name: 'OpenAI',
          apiKey: 'openai-key',
          models: const [ModelConfig(id: 'gpt-4o', name: 'GPT-4o')],
        );

        final claudeConfig = AIProviderConfig(
          id: 'claude',
          type: AIProviderType.claude,
          name: 'Claude',
          apiKey: 'claude-key',
          models: const [ModelConfig(id: 'claude-3-5-sonnet-20241022', name: 'Claude 3.5')],
        );

        final geminiConfig = AIProviderConfig(
          id: 'gemini',
          type: AIProviderType.gemini,
          name: 'Gemini',
          apiKey: 'gemini-key',
          models: const [ModelConfig(id: 'gemini-2.0-flash', name: 'Gemini 2.0')],
        );

        llmService.registerProvider(openaiConfig);
        llmService.registerProvider(claudeConfig);
        llmService.registerProvider(geminiConfig);

        expect(llmService.hasProvider('openai'), isTrue);
        expect(llmService.hasProvider('claude'), isTrue);
        expect(llmService.hasProvider('gemini'), isTrue);

        expect(llmService.getModel('openai', 'gpt-4o'), isNotNull);
        expect(llmService.getModel('claude', 'claude-3-5-sonnet-20241022'), isNotNull);
        expect(llmService.getModel('gemini', 'gemini-2.0-flash'), isNotNull);
      });
    });
  });

  group('ChatChunk', () {
    test('should create text chunk', () {
      final chunk = ChatChunk(text: 'Hello, world!');
      expect(chunk.text, equals('Hello, world!'));
      expect(chunk.isFinished, isFalse);
    });

    test('should create finished chunk', () {
      final chunk = ChatChunk(
        isFinished: true,
        finishReason: 'stop',
        inputTokens: 10,
        outputTokens: 20,
      );
      expect(chunk.isFinished, isTrue);
      expect(chunk.finishReason, equals('stop'));
      expect(chunk.inputTokens, equals(10));
      expect(chunk.outputTokens, equals(20));
    });
  });

  group('ChatMessageConverter', () {
    test('should convert message list to ChatMessages', () {
      final messages = [
        {'role': 'system', 'content': 'You are a helpful assistant'},
        {'role': 'user', 'content': 'Hello'},
        {'role': 'assistant', 'content': 'Hi! How can I help?'},
      ];

      final chatMessages = messages.toChatMessages();

      expect(chatMessages.length, equals(3));
      expect(chatMessages[0], isA<SystemChatMessage>());
      expect(chatMessages[1], isA<HumanChatMessage>());
      expect(chatMessages[2], isA<AIChatMessage>());
    });

    test('should handle unknown role as human message', () {
      final messages = [
        {'role': 'unknown', 'content': 'Some message'},
      ];

      final chatMessages = messages.toChatMessages();

      expect(chatMessages.length, equals(1));
      expect(chatMessages[0], isA<HumanChatMessage>());
    });
  });

  group('AIProviderConfig', () {
    test('should create config with defaults', () {
      final config = AIProviderConfig(
        id: 'test',
        type: AIProviderType.openai,
        name: 'Test',
      );

      expect(config.enabled, isTrue);
      expect(config.models, isEmpty);
    });

    test('should preserve all fields when creating', () {
      final config = AIProviderConfig(
        id: 'test-openai',
        type: AIProviderType.openai,
        name: 'Test OpenAI',
        apiKey: 'sk-test-key',
        enabled: true,
        models: const [
          ModelConfig(
            id: 'gpt-4o',
            name: 'GPT-4o',
            supportsVision: true,
            supportsFunctionCalling: true,
            contextWindow: 128000,
          ),
        ],
      );

      expect(config.id, equals('test-openai'));
      expect(config.type, equals(AIProviderType.openai));
      expect(config.name, equals('Test OpenAI'));
      expect(config.apiKey, equals('sk-test-key'));
      expect(config.models.length, equals(1));
      expect(config.models.first.id, equals('gpt-4o'));
      expect(config.models.first.supportsVision, isTrue);
      expect(config.models.first.contextWindow, equals(128000));
    });

    test('should support copyWith', () {
      final config = AIProviderConfig(
        id: 'test',
        type: AIProviderType.openai,
        name: 'Original',
        apiKey: 'key',
      );

      final updated = config.copyWith(name: 'Updated');

      expect(updated.id, equals('test'));
      expect(updated.name, equals('Updated'));
    });
  });

  group('ModelConfig', () {
    test('should create config with defaults', () {
      const config = ModelConfig(id: 'test', name: 'Test');

      expect(config.supportsStreaming, isTrue);
      expect(config.supportsVision, isFalse);
      expect(config.supportsFunctionCalling, isFalse);
      expect(config.maxTokens, isNull);
      expect(config.contextWindow, isNull);
    });

    test('should serialize and deserialize to JSON', () {
      const config = ModelConfig(
        id: 'gpt-4o',
        name: 'GPT-4o',
        supportsStreaming: true,
        supportsVision: true,
        supportsFunctionCalling: true,
        maxTokens: 4096,
        contextWindow: 128000,
      );

      final json = config.toJson();
      final restored = ModelConfig.fromJson(json);

      expect(restored.id, equals(config.id));
      expect(restored.supportsVision, isTrue);
      expect(restored.contextWindow, equals(128000));
    });
  });

  group('Default Provider Configurations', () {
    test('should have default OpenAI models', () {
      expect(defaultOpenAIModels.isNotEmpty, isTrue);
      expect(defaultOpenAIModels.any((m) => m.id == 'gpt-4o'), isTrue);
    });

    test('should have default Claude models', () {
      expect(defaultClaudeModels.isNotEmpty, isTrue);
      expect(defaultClaudeModels.any((m) => m.id.contains('claude')), isTrue);
    });

    test('should have default Gemini models', () {
      expect(defaultGeminiModels.isNotEmpty, isTrue);
      expect(defaultGeminiModels.any((m) => m.id.contains('gemini')), isTrue);
    });

    test('should have default DeepSeek models', () {
      expect(defaultDeepSeekModels.isNotEmpty, isTrue);
      expect(defaultDeepSeekModels.any((m) => m.id.contains('deepseek')), isTrue);
    });

    test('should have default Ollama models', () {
      expect(defaultOllamaModels.isNotEmpty, isTrue);
    });

    test('should have correct base URLs for all provider types', () {
      expect(providerDefaultBaseUrls[AIProviderType.openai], contains('openai.com'));
      expect(providerDefaultBaseUrls[AIProviderType.claude], contains('anthropic.com'));
      expect(providerDefaultBaseUrls[AIProviderType.gemini], contains('googleapis.com'));
      expect(providerDefaultBaseUrls[AIProviderType.deepseek], contains('deepseek.com'));
      expect(providerDefaultBaseUrls[AIProviderType.openrouter], contains('openrouter.ai'));
      expect(providerDefaultBaseUrls[AIProviderType.ollama], contains('localhost'));
    });
  });
}
