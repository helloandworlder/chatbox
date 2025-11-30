import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/tool_service.dart';

final toolServiceProvider = Provider<ToolService>((ref) {
  return ToolService();
});

final webSearchEnabledProvider = StateProvider<bool>((ref) => false);
