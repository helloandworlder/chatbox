import 'package:flutter/material.dart';

class SliderWithLabel extends StatelessWidget {
  final String label;
  final String? tooltip;
  final double? value;
  final double min;
  final double max;
  final int? divisions;
  final bool allowNull;
  final String nullLabel;
  final ValueChanged<double?> onChanged;
  final String Function(double)? valueFormatter;

  const SliderWithLabel({
    super.key,
    required this.label,
    this.tooltip,
    this.value,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.allowNull = true,
    this.nullLabel = '未设置',
    required this.onChanged,
    this.valueFormatter,
  });

  @override
  Widget build(BuildContext context) {
    final displayValue = value ?? min;
    final isSet = value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (tooltip != null) ...[
              const SizedBox(width: 4),
              Tooltip(
                message: tooltip!,
                child: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                  activeTrackColor: isSet
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                  inactiveTrackColor:
                      Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                  thumbColor: isSet
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
                child: Slider(
                  value: displayValue,
                  min: min,
                  max: max,
                  divisions: divisions,
                  onChanged: (v) => onChanged(v),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 64,
              child: allowNull && !isSet
                  ? OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: const Size(64, 36),
                      ),
                      child: Text(
                        nullLabel,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    )
                  : Container(
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        valueFormatter?.call(displayValue) ??
                            displayValue.toStringAsFixed(
                                displayValue == displayValue.roundToDouble()
                                    ? 0
                                    : 1),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
            ),
            if (allowNull && isSet) ...[
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: () => onChanged(null),
                tooltip: '重置为未设置',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class IntSliderWithLabel extends StatelessWidget {
  final String label;
  final String? tooltip;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const IntSliderWithLabel({
    super.key,
    required this.label,
    this.tooltip,
    required this.value,
    this.min = 0,
    this.max = 20,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (tooltip != null) ...[
              const SizedBox(width: 4),
              Tooltip(
                message: tooltip!,
                child: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                ),
                child: Slider(
                  value: value.toDouble(),
                  min: min.toDouble(),
                  max: max.toDouble(),
                  divisions: max - min,
                  onChanged: (v) => onChanged(v.round()),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 48,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
