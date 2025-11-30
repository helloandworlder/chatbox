import 'package:flutter/material.dart';

import '../../domain/mcp_config.dart';

/// MCP 服务器状态指示器
class MCPStatusIndicator extends StatelessWidget {
  final MCPServerStatus status;
  final double size;

  const MCPStatusIndicator({
    super.key,
    required this.status,
    this.size = 8,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final shouldAnimate = status.state == MCPServerState.starting ||
        status.state == MCPServerState.stopping;

    if (status.error != null) {
      return Tooltip(
        message: status.error!,
        child: _buildDot(color, false),
      );
    }

    return _buildDot(color, shouldAnimate);
  }

  Widget _buildDot(Color color, bool animate) {
    final dot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );

    if (animate) {
      return _PulsingDot(color: color, size: size);
    }

    return dot;
  }

  Color _getColor() {
    if (status.error != null) {
      return Colors.red;
    }
    return switch (status.state) {
      MCPServerState.idle => Colors.grey,
      MCPServerState.starting => Colors.blue,
      MCPServerState.running => Colors.green,
      MCPServerState.stopping => Colors.orange,
    };
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;
  final double size;

  const _PulsingDot({required this.color, required this.size});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}

/// 聚合 MCP 状态指示器 (显示在 InputBox 中)
class MCPAggregateStatus extends StatelessWidget {
  final Map<String, MCPServerStatus> statuses;
  final VoidCallback? onTap;

  const MCPAggregateStatus({
    super.key,
    required this.statuses,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final runningCount = statuses.values
        .where((s) => s.state == MCPServerState.running)
        .length;
    final hasError = statuses.values.any((s) => s.error != null);
    final isStarting = statuses.values.any((s) => s.state == MCPServerState.starting);

    if (statuses.isEmpty) {
      return const SizedBox.shrink();
    }

    Color color;
    if (hasError) {
      color = Colors.red;
    } else if (isStarting) {
      color = Colors.blue;
    } else if (runningCount > 0) {
      color = Colors.green;
    } else {
      color = Colors.grey;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.extension,
              size: 16,
              color: color,
            ),
            if (runningCount > 0) ...[
              const SizedBox(width: 4),
              Text(
                '$runningCount',
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
