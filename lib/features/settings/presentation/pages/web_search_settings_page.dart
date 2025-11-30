import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../providers/app_settings_provider.dart';
import '../widgets/api_key_input.dart';
import '../widgets/slider_with_label.dart';

class WebSearchSettingsPage extends ConsumerWidget {
  const WebSearchSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appSettings = ref.watch(appSettingsProvider);
    final settingsNotifier = ref.read(appSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.web_search.title'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'settings.web_search.subtitle'.tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),

          // Search Provider
          Text(
            'settings.web_search.provider'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: appSettings.searchProvider,
                items: [
                  DropdownMenuItem(
                    value: 'tavily',
                    child: Text('settings.web_search.tavily'.tr()),
                  ),
                  DropdownMenuItem(
                    value: 'bing',
                    child: Text('settings.web_search.bing'.tr()),
                  ),
                  DropdownMenuItem(
                    value: 'duckduckgo',
                    child: Text('settings.web_search.duckduckgo'.tr()),
                  ),
                ],
                onChanged: (v) {
                  if (v != null) settingsNotifier.setSearchProvider(v);
                },
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Tavily settings
          if (appSettings.searchProvider == 'tavily') ...[
            ApiKeyInput(
              value: appSettings.tavilyApiKey,
              label: 'settings.web_search.tavily_api_key'.tr(),
              onChanged: settingsNotifier.setTavilyApiKey,
              helpUrl: 'https://tavily.com/',
              helpUrlText: 'settings.web_search.get_api_key'.tr(),
            ),
            const SizedBox(height: 16),
            
            // Search Depth
            Text(
              'settings.web_search.search_depth'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'basic',
                  label: Text('settings.web_search.search_depth_basic'.tr()),
                ),
                ButtonSegment(
                  value: 'advanced',
                  label: Text('settings.web_search.search_depth_advanced'.tr()),
                ),
              ],
              selected: {appSettings.tavilySearchDepth},
              onSelectionChanged: (v) {
                settingsNotifier.setTavilySearchDepth(v.first);
              },
            ),
            const SizedBox(height: 16),
            
            IntSliderWithLabel(
              label: 'settings.web_search.max_results'.tr(),
              value: appSettings.searchMaxResults,
              min: 1,
              max: 10,
              onChanged: settingsNotifier.setSearchMaxResults,
            ),
          ],

          // Bing settings
          if (appSettings.searchProvider == 'bing') ...[
            ApiKeyInput(
              value: appSettings.bingApiKey,
              label: 'settings.web_search.bing_api_key'.tr(),
              onChanged: settingsNotifier.setBingApiKey,
              helpUrl: 'https://www.microsoft.com/en-us/bing/apis/bing-web-search-api',
              helpUrlText: 'settings.web_search.get_api_key'.tr(),
            ),
            const SizedBox(height: 16),
            IntSliderWithLabel(
              label: 'settings.web_search.max_results'.tr(),
              value: appSettings.searchMaxResults,
              min: 1,
              max: 10,
              onChanged: settingsNotifier.setSearchMaxResults,
            ),
          ],

          // DuckDuckGo settings (no API key needed)
          if (appSettings.searchProvider == 'duckduckgo') ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'DuckDuckGo does not require an API key.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            IntSliderWithLabel(
              label: 'settings.web_search.max_results'.tr(),
              value: appSettings.searchMaxResults,
              min: 1,
              max: 10,
              onChanged: settingsNotifier.setSearchMaxResults,
            ),
          ],
        ],
      ),
    );
  }
}
