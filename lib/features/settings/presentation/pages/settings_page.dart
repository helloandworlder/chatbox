import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ai_models/presentation/pages/provider_settings_page.dart';
import '../../../ai_models/presentation/providers/ai_provider.dart';
import '../../../knowledge_base/presentation/providers/knowledge_base_provider.dart';
import '../../../mcp/presentation/providers/mcp_provider.dart';
import 'model_settings_page.dart';
import 'web_search_settings_page.dart';
import 'chat_settings_page.dart';
import 'appearance_settings_page.dart';
import 'data_settings_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(aiProvidersProvider);
    final enabledCount = providers.where((p) => p.enabled).length;
    final mcpServers = ref.watch(mcpServersProvider);
    final mcpRunningCount = ref.watch(hasRunningMcpServersProvider) ? 1 : 0;
    final knowledgeBases = ref.watch(knowledgeBasesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr()),
      ),
      body: ListView(
        children: [
          // Model Settings
          _buildSettingsItem(
            context,
            icon: Icons.psychology,
            title: 'settings.model.title'.tr(),
            subtitle: 'settings.model.subtitle'.tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ModelSettingsPage()),
            ),
          ),

          // AI Providers
          _buildSettingsItem(
            context,
            icon: Icons.auto_awesome,
            title: 'settings.providers.title'.tr(),
            subtitle: enabledCount > 0
                ? 'settings.providers.enabled_count'.tr(args: ['$enabledCount'])
                : 'settings.providers.no_providers'.tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProviderSettingsPage()),
            ),
          ),

          // Web Search
          _buildSettingsItem(
            context,
            icon: Icons.search,
            title: 'settings.web_search.title'.tr(),
            subtitle: 'settings.web_search.subtitle'.tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WebSearchSettingsPage()),
            ),
          ),

          // Chat Settings
          _buildSettingsItem(
            context,
            icon: Icons.chat_bubble_outline,
            title: 'settings.chat_settings.title'.tr(),
            subtitle: 'settings.chat_settings.subtitle'.tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatSettingsPage()),
            ),
          ),

          // Appearance
          _buildSettingsItem(
            context,
            icon: Icons.palette_outlined,
            title: 'settings.appearance.title'.tr(),
            subtitle: 'settings.appearance.subtitle'.tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AppearanceSettingsPage()),
            ),
          ),

          const Divider(height: 32),

          // MCP Servers
          _buildSettingsItem(
            context,
            icon: Icons.extension,
            title: 'settings.mcp.title'.tr(),
            subtitle: mcpServers.when(
              data: (servers) {
                final count = servers.length;
                if (count == 0) return 'settings.providers.no_providers'.tr();
                final running =
                    mcpRunningCount > 0 ? ' ($mcpRunningCount running)' : '';
                return '$count server${count > 1 ? 's' : ''}$running';
              },
              loading: () => 'common.loading'.tr(),
              error: (e, s) => 'common.error'.tr(),
            ),
            onTap: () => context.push('/settings/mcp'),
          ),

          // Knowledge Bases
          _buildSettingsItem(
            context,
            icon: Icons.folder_special,
            title: 'settings.knowledge_base.title'.tr(),
            subtitle: knowledgeBases.when(
              data: (kbs) {
                final count = kbs.length;
                if (count == 0) return 'settings.knowledge_base.no_knowledge_bases'.tr();
                final totalChunks =
                    kbs.fold<int>(0, (sum, kb) => sum + kb.chunkCount);
                return '$count KB${count > 1 ? 's' : ''} · $totalChunks chunks';
              },
              loading: () => 'common.loading'.tr(),
              error: (e, s) => 'common.error'.tr(),
            ),
            onTap: () => context.push('/settings/knowledge-bases'),
          ),

          const Divider(height: 32),

          // Data Management
          _buildSettingsItem(
            context,
            icon: Icons.storage_outlined,
            title: 'settings.data.title'.tr(),
            subtitle: 'settings.data.subtitle'.tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DataSettingsPage()),
            ),
          ),

          const Divider(height: 32),

          // About
          _buildSettingsItem(
            context,
            icon: Icons.info_outline,
            title: 'settings.about.title'.tr(),
            subtitle: '${'common.version'.tr()} 2.0.0',
            onTap: null,
          ),
          
          _buildSettingsItem(
            context,
            icon: Icons.code,
            title: 'settings.about.github'.tr(),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: () => _openUrl('https://github.com/nicepkg/chatbox'),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
