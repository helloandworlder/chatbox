import 'package:flutter/material.dart';

/// 解析思考内容的结果
class ParsedContent {
  final String? thinkingContent;
  final String mainContent;

  ParsedContent({
    this.thinkingContent,
    required this.mainContent,
  });

  bool get hasThinking => thinkingContent != null && thinkingContent!.isNotEmpty;
}

/// 解析包含 <think> 标签的内容
ParsedContent parseThinkingContent(String content) {
  // 匹配 <think>...</think> 标签
  final thinkPattern = RegExp(
    r'<think>([\s\S]*?)</think>',
    multiLine: true,
  );

  final match = thinkPattern.firstMatch(content);
  if (match != null) {
    final thinkingContent = match.group(1)?.trim();
    final mainContent = content
        .replaceFirst(thinkPattern, '')
        .trim();

    return ParsedContent(
      thinkingContent: thinkingContent,
      mainContent: mainContent,
    );
  }

  return ParsedContent(mainContent: content);
}

/// 思考内容折叠组件
class ThinkingBlock extends StatefulWidget {
  final String content;
  final Widget Function(String content) contentBuilder;

  const ThinkingBlock({
    super.key,
    required this.content,
    required this.contentBuilder,
  });

  @override
  State<ThinkingBlock> createState() => _ThinkingBlockState();
}

class _ThinkingBlockState extends State<ThinkingBlock>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部 - 可点击展开/折叠
          InkWell(
            onTap: _handleTap,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.psychology,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '思考过程',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  RotationTransition(
                    turns: _iconTurns,
                    child: Icon(
                      Icons.expand_more,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 内容 - 可折叠
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                  child: widget.contentBuilder(widget.content),
                ),
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

/// 带思考内容的消息显示组件
class MessageWithThinking extends StatelessWidget {
  final String content;
  final Widget Function(String content) contentBuilder;
  final bool isStreaming;

  const MessageWithThinking({
    super.key,
    required this.content,
    required this.contentBuilder,
    this.isStreaming = false,
  });

  @override
  Widget build(BuildContext context) {
    // 流式响应时不解析，等完成后再解析
    if (isStreaming) {
      return contentBuilder(content);
    }

    final parsed = parseThinkingContent(content);

    if (!parsed.hasThinking) {
      return contentBuilder(content);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThinkingBlock(
          content: parsed.thinkingContent!,
          contentBuilder: contentBuilder,
        ),
        if (parsed.mainContent.isNotEmpty)
          contentBuilder(parsed.mainContent),
      ],
    );
  }
}
