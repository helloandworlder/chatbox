import 'package:flutter/material.dart';

class ApiKeyInput extends StatefulWidget {
  final String? value;
  final String label;
  final String? hint;
  final String? helpUrl;
  final String? helpUrlText;
  final ValueChanged<String?> onChanged;
  final Future<bool> Function(String)? onValidate;

  const ApiKeyInput({
    super.key,
    this.value,
    required this.label,
    this.hint,
    this.helpUrl,
    this.helpUrlText,
    required this.onChanged,
    this.onValidate,
  });

  @override
  State<ApiKeyInput> createState() => _ApiKeyInputState();
}

class _ApiKeyInputState extends State<ApiKeyInput> {
  late TextEditingController _controller;
  bool _obscureText = true;
  bool _isValidating = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(ApiKeyInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _validate() async {
    if (widget.onValidate == null || _controller.text.isEmpty) return;

    setState(() => _isValidating = true);

    try {
      final isValid = await widget.onValidate!(_controller.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isValid ? 'API Key 有效' : 'API Key 无效'),
            backgroundColor:
                isValid ? Colors.green : Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('验证失败: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isValidating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  ),
                ),
                onChanged: widget.onChanged,
              ),
            ),
            if (widget.onValidate != null) ...[
              const SizedBox(width: 8),
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: _isValidating ? null : _validate,
                  child: _isValidating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('检查'),
                ),
              ),
            ],
          ],
        ),
        if (widget.helpUrl != null) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // TODO: Launch URL
            },
            child: Text(
              widget.helpUrlText ?? '获取 API 密钥',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}
