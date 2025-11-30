import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../providers/app_settings_provider.dart';
import '../widgets/model_dropdown.dart';

class ModelSettingsPage extends ConsumerWidget {
  const ModelSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final settingsNotifier = ref.read(appSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.model.title'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'settings.model.subtitle'.tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          
          ModelDropdown(
            value: appSettings.defaultChatModel,
            label: 'settings.model.default_chat'.tr(),
            hint: 'settings.model.default_chat_hint'.tr(),
            autoLabel: 'settings.model.default_chat_auto'.tr(),
            onChanged: settingsNotifier.setDefaultChatModel,
          ),
          const SizedBox(height: 16),
          
          ModelDropdown(
            value: appSettings.defaultNamingModel,
            label: 'settings.model.default_naming'.tr(),
            hint: 'settings.model.default_naming_hint'.tr(),
            autoLabel: 'settings.model.default_naming_auto'.tr(),
            onChanged: settingsNotifier.setDefaultNamingModel,
          ),
          const SizedBox(height: 16),
          
          ModelDropdown(
            value: appSettings.defaultSearchQueryModel,
            label: 'settings.model.search_query'.tr(),
            hint: 'settings.model.search_query_hint'.tr(),
            autoLabel: 'settings.model.search_query_auto'.tr(),
            onChanged: settingsNotifier.setDefaultSearchQueryModel,
          ),
          const SizedBox(height: 16),
          
          ModelDropdown(
            value: appSettings.ocrModel,
            label: 'settings.model.ocr'.tr(),
            hint: 'settings.model.ocr_hint'.tr(),
            autoLabel: 'settings.model.ocr_none'.tr(),
            onChanged: settingsNotifier.setOcrModel,
          ),
        ],
      ),
    );
  }
}
