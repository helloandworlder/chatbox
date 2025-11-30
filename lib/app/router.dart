import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/chat/presentation/pages/chat_page.dart';
import '../features/chat/presentation/pages/session_list_page.dart';
import '../features/copilots/presentation/pages/copilots_page.dart';
import '../features/knowledge_base/presentation/pages/knowledge_base_list_page.dart';
import '../features/knowledge_base/presentation/pages/knowledge_base_detail_page.dart';
import '../features/mcp/presentation/pages/mcp_settings_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import 'shell_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/chat',
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => ShellPage(child: child),
      routes: [
        GoRoute(
          path: '/chat',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ChatPage(),
          ),
        ),
        GoRoute(
          path: '/copilots',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CopilotsPage(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/sessions',
      builder: (context, state) => const SessionListPage(),
    ),
    GoRoute(
      path: '/settings/mcp',
      builder: (context, state) => const McpSettingsPage(),
    ),
    GoRoute(
      path: '/settings/knowledge-bases',
      builder: (context, state) => const KnowledgeBaseListPage(),
    ),
    GoRoute(
      path: '/knowledge-base/:id',
      builder: (context, state) => KnowledgeBaseDetailPage(
        knowledgeBaseId: state.pathParameters['id']!,
      ),
    ),
  ],
);
