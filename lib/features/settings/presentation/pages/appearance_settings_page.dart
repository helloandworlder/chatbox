import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../providers/app_settings_provider.dart';
import '../widgets/avatar_picker.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final settingsNotifier = ref.read(appSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.appearance.title'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'settings.appearance.subtitle'.tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),

          // Theme Section
          Text(
            'settings.appearance.theme'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(
                value: 'system',
                label: Text('settings.appearance.theme_system'.tr()),
                icon: const Icon(Icons.brightness_auto),
              ),
              ButtonSegment(
                value: 'light',
                label: Text('settings.appearance.theme_light'.tr()),
                icon: const Icon(Icons.light_mode),
              ),
              ButtonSegment(
                value: 'dark',
                label: Text('settings.appearance.theme_dark'.tr()),
                icon: const Icon(Icons.dark_mode),
              ),
            ],
            selected: {appSettings.themeMode},
            onSelectionChanged: (v) {
              settingsNotifier.setThemeMode(v.first);
            },
          ),
          const SizedBox(height: 32),

          // Language Section
          Text(
            'settings.appearance.language'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          _buildLanguageOption(
            context,
            value: 'system',
            label: 'settings.appearance.language_system'.tr(),
            isSelected: appSettings.locale == 'system',
            onTap: () {
              settingsNotifier.setLocale('system');
              context.resetLocale();
            },
          ),
          _buildLanguageOption(
            context,
            value: 'zh',
            label: 'settings.appearance.language_zh'.tr(),
            isSelected: appSettings.locale == 'zh',
            onTap: () {
              settingsNotifier.setLocale('zh');
              context.setLocale(const Locale('zh'));
            },
          ),
          _buildLanguageOption(
            context,
            value: 'en',
            label: 'settings.appearance.language_en'.tr(),
            isSelected: appSettings.locale == 'en',
            onTap: () {
              settingsNotifier.setLocale('en');
              context.setLocale(const Locale('en'));
            },
          ),
          _buildLanguageOption(
            context,
            value: 'ja',
            label: 'settings.appearance.language_ja'.tr(),
            isSelected: appSettings.locale == 'ja',
            onTap: () {
              settingsNotifier.setLocale('ja');
              context.setLocale(const Locale('ja'));
            },
          ),
          const SizedBox(height: 32),

          // Avatar Section
          Text(
            'settings.appearance.avatar'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'settings.appearance.avatar_hint'.tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 16),
          AvatarPicker(
            avatarPath: appSettings.userAvatarPath,
            label: 'settings.appearance.user_avatar'.tr(),
            defaultIcon: Icons.person_outline,
            defaultIconColor: Colors.grey,
            onChanged: settingsNotifier.setUserAvatarPath,
          ),
          const SizedBox(height: 16),
          AvatarPicker(
            avatarPath: appSettings.assistantAvatarPath,
            label: 'settings.appearance.assistant_avatar'.tr(),
            defaultIcon: Icons.smart_toy_outlined,
            defaultIconColor: Theme.of(context).colorScheme.primary,
            onChanged: settingsNotifier.setAssistantAvatarPath,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String value,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            if (isSelected)
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
