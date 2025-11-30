import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../features/mcp/presentation/providers/mcp_provider.dart';
import '../features/settings/presentation/providers/app_settings_provider.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class ChatboxApp extends ConsumerStatefulWidget {
  const ChatboxApp({super.key});

  @override
  ConsumerState<ChatboxApp> createState() => _ChatboxAppState();
}

class _ChatboxAppState extends ConsumerState<ChatboxApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(mcpActionsProvider).bootstrapEnabledServers();
    });
  }

  ThemeMode _getThemeMode(String mode) {
    return switch (mode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  @override
  Widget build(BuildContext context) {
    final appSettings = ref.watch(appSettingsProvider);
    
    return MaterialApp.router(
      title: 'Chatbox',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _getThemeMode(appSettings.themeMode),
      routerConfig: router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
