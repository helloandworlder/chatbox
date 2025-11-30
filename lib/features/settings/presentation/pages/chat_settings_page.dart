import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../providers/app_settings_provider.dart';
import '../widgets/slider_with_label.dart';

class ChatSettingsPage extends ConsumerWidget {
  const ChatSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final settingsNotifier = ref.read(appSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.chat_settings.title'.tr()),
      ),
      body: ListView(
        children: [
          // Default Settings Section
          _buildSection(
            context,
            title: 'settings.chat_settings.default_settings'.tr(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'settings.chat_settings.system_prompt'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: TextEditingController(
                        text: appSettings.defaultSystemPrompt,
                      ),
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        hintText: 'settings.chat_settings.system_prompt_hint'.tr(),
                      ),
                      onChanged: settingsNotifier.setDefaultSystemPrompt,
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => settingsNotifier.setDefaultSystemPrompt(
                        'You are a helpful assistant.',
                      ),
                      child: Text(
                        'settings.chat_settings.reset_prompt'.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: IntSliderWithLabel(
                  label: 'settings.chat_settings.max_context'.tr(),
                  tooltip: 'settings.chat_settings.max_context_hint'.tr(),
                  value: appSettings.maxContextMessages,
                  min: 0,
                  max: 20,
                  onChanged: settingsNotifier.setMaxContextMessages,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SliderWithLabel(
                  label: 'settings.chat_settings.temperature'.tr(),
                  tooltip: 'settings.chat_settings.temperature_hint'.tr(),
                  value: appSettings.defaultTemperature ?? 0.7,
                  min: 0,
                  max: 2,
                  onChanged: settingsNotifier.setDefaultTemperature,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SliderWithLabel(
                  label: 'settings.chat_settings.top_p'.tr(),
                  tooltip: 'settings.chat_settings.top_p_hint'.tr(),
                  value: appSettings.defaultTopP ?? 1.0,
                  min: 0,
                  max: 1,
                  onChanged: settingsNotifier.setDefaultTopP,
                ),
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.streaming'.tr()),
                value: appSettings.streamingOutput,
                onChanged: settingsNotifier.setStreamingOutput,
              ),
            ],
          ),

          const Divider(height: 32),

          // Display Section
          _buildSection(
            context,
            title: 'settings.chat_settings.display'.tr(),
            children: [
              SwitchListTile(
                title: Text('settings.chat_settings.show_word_count'.tr()),
                value: appSettings.showWordCount,
                onChanged: settingsNotifier.setShowWordCount,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.show_token_usage'.tr()),
                value: appSettings.showTokenUsage,
                onChanged: settingsNotifier.setShowTokenUsage,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.show_model_name'.tr()),
                value: appSettings.showModelName,
                onChanged: settingsNotifier.setShowModelName,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.show_timestamp'.tr()),
                value: appSettings.showTimestamp,
                onChanged: settingsNotifier.setShowTimestamp,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.show_first_token_latency'.tr()),
                value: appSettings.showFirstTokenLatency,
                onChanged: settingsNotifier.setShowFirstTokenLatency,
              ),
            ],
          ),

          const Divider(height: 32),

          // Features Section
          _buildSection(
            context,
            title: 'settings.chat_settings.features'.tr(),
            children: [
              SwitchListTile(
                title: Text('settings.chat_settings.auto_collapse_code'.tr()),
                value: appSettings.autoCollapseCodeBlocks,
                onChanged: settingsNotifier.setAutoCollapseCodeBlocks,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.auto_generate_title'.tr()),
                value: appSettings.autoGenerateChatTitle,
                onChanged: settingsNotifier.setAutoGenerateChatTitle,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.spell_check'.tr()),
                value: appSettings.spellCheck,
                onChanged: settingsNotifier.setSpellCheck,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.markdown_rendering'.tr()),
                value: appSettings.markdownRendering,
                onChanged: settingsNotifier.setMarkdownRendering,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.latex_rendering'.tr()),
                value: appSettings.latexRendering,
                onChanged: settingsNotifier.setLatexRendering,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.mermaid_rendering'.tr()),
                value: appSettings.mermaidRendering,
                onChanged: settingsNotifier.setMermaidRendering,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.inject_metadata'.tr()),
                subtitle: Text('settings.chat_settings.inject_metadata_hint'.tr()),
                value: appSettings.injectDefaultMetadata,
                onChanged: settingsNotifier.setInjectDefaultMetadata,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.auto_preview_artifacts'.tr()),
                subtitle: Text('settings.chat_settings.auto_preview_artifacts_hint'.tr()),
                value: appSettings.autoPreviewArtifacts,
                onChanged: settingsNotifier.setAutoPreviewArtifacts,
              ),
              SwitchListTile(
                title: Text('settings.chat_settings.paste_long_text'.tr()),
                subtitle: Text('settings.chat_settings.paste_long_text_hint'.tr()),
                value: appSettings.pasteLongTextAsFile,
                onChanged: settingsNotifier.setPasteLongTextAsFile,
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ...children,
      ],
    );
  }
}
