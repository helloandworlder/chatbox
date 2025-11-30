import 'package:langchain/langchain.dart';
import 'package:langchain_community/langchain_community.dart';

import '../../settings/domain/app_settings.dart';

class ToolService {
  TavilySearchResultsTool? getTavilySearchTool(String? apiKey) {
    if (apiKey == null || apiKey.isEmpty) return null;
    return TavilySearchResultsTool(apiKey: apiKey);
  }

  TavilyAnswerTool? getTavilyAnswerTool(String? apiKey) {
    if (apiKey == null || apiKey.isEmpty) return null;
    return TavilyAnswerTool(apiKey: apiKey);
  }

  CalculatorTool getCalculatorTool() => CalculatorTool();

  List<Tool> getEnabledTools({
    required AppSettings settings,
    bool webSearchEnabled = false,
    bool calculatorEnabled = false,
  }) {
    final tools = <Tool>[];

    if (webSearchEnabled) {
      final tavilyTool = getTavilySearchTool(settings.tavilyApiKey);
      if (tavilyTool != null) tools.add(tavilyTool);
    }

    if (calculatorEnabled) {
      tools.add(getCalculatorTool());
    }

    return tools;
  }

  Future<String> runWebSearch({
    required String query,
    required String apiKey,
    int maxResults = 5,
  }) async {
    final tool = TavilySearchResultsTool(apiKey: apiKey);
    final result = await tool.invoke(query);
    return result.toString();
  }

  Future<bool> validateTavilyApiKey(String apiKey) async {
    try {
      final tool = TavilySearchResultsTool(apiKey: apiKey);
      await tool.invoke('test');
      return true;
    } catch (e) {
      return false;
    }
  }
}
