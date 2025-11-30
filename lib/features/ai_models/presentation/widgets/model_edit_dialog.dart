import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/provider_config.dart';

/// 模型编辑对话框
class ModelEditDialog extends StatefulWidget {
  final ModelConfig? model; // null 表示新建
  final ValueChanged<ModelConfig> onSave;

  const ModelEditDialog({
    super.key,
    this.model,
    required this.onSave,
  });

  @override
  State<ModelEditDialog> createState() => _ModelEditDialogState();
}

class _ModelEditDialogState extends State<ModelEditDialog> {
  late final TextEditingController _idController;
  late final TextEditingController _nicknameController;
  late final TextEditingController _contextWindowController;
  late final TextEditingController _maxOutputTokensController;

  late ModelType _modelType;
  late bool _supportsVision;
  late bool _supportsReasoning;
  late bool _supportsFunctionCalling;

  bool get _isEditing => widget.model != null;

  @override
  void initState() {
    super.initState();
    final model = widget.model;
    _idController = TextEditingController(text: model?.id ?? '');
    _nicknameController = TextEditingController(text: model?.nickname ?? '');
    _contextWindowController = TextEditingController(
      text: model?.contextWindow?.toString() ?? '',
    );
    _maxOutputTokensController = TextEditingController(
      text: model?.maxOutputTokens?.toString() ?? '',
    );

    _modelType = model?.type ?? ModelType.chat;
    _supportsVision = model?.supportsVision ?? false;
    _supportsReasoning = model?.supportsReasoning ?? false;
    _supportsFunctionCalling = model?.supportsFunctionCalling ?? false;
  }

  @override
  void dispose() {
    _idController.dispose();
    _nicknameController.dispose();
    _contextWindowController.dispose();
    _maxOutputTokensController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? '编辑模型' : '新建模型'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 模型 ID
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: '模型ID',
                  hintText: '如 gpt-4o, claude-3-sonnet',
                  border: OutlineInputBorder(),
                ),
                enabled: !_isEditing, // 编辑时不允许修改 ID
              ),
              const SizedBox(height: 16),

              // 显示名称
              TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  labelText: '显示名称',
                  hintText: '可选',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // 模型类型
              DropdownButtonFormField<ModelType>(
                value: _modelType,
                decoration: const InputDecoration(
                  labelText: '模型类型',
                  border: OutlineInputBorder(),
                ),
                items: ModelType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(_getModelTypeName(type)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _modelType = value);
                  }
                },
              ),
              const SizedBox(height: 16),

              // 能力
              Text(
                '能力',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: const Text('视觉'),
                    selected: _supportsVision,
                    onSelected: (v) => setState(() => _supportsVision = v),
                    avatar: Icon(
                      Icons.visibility,
                      size: 18,
                      color: _supportsVision
                          ? Theme.of(context).colorScheme.onSecondaryContainer
                          : null,
                    ),
                  ),
                  FilterChip(
                    label: const Text('推理'),
                    selected: _supportsReasoning,
                    onSelected: (v) => setState(() => _supportsReasoning = v),
                    avatar: Icon(
                      Icons.psychology,
                      size: 18,
                      color: _supportsReasoning
                          ? Theme.of(context).colorScheme.onSecondaryContainer
                          : null,
                    ),
                  ),
                  FilterChip(
                    label: const Text('工具使用'),
                    selected: _supportsFunctionCalling,
                    onSelected: (v) => setState(() => _supportsFunctionCalling = v),
                    avatar: Icon(
                      Icons.build,
                      size: 18,
                      color: _supportsFunctionCalling
                          ? Theme.of(context).colorScheme.onSecondaryContainer
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 高级设置
              Text(
                '高级设置',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _contextWindowController,
                      decoration: const InputDecoration(
                        labelText: '上下文窗口',
                        hintText: '如 128000',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _maxOutputTokensController,
                      decoration: const InputDecoration(
                        labelText: '最大输出Token',
                        hintText: '如 4096',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('保存'),
        ),
      ],
    );
  }

  String _getModelTypeName(ModelType type) {
    return switch (type) {
      ModelType.chat => '聊天',
      ModelType.embedding => '嵌入',
      ModelType.rerank => '重排',
    };
  }

  void _submit() {
    final id = _idController.text.trim();
    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入模型ID')),
      );
      return;
    }

    final nickname = _nicknameController.text.trim();
    final contextWindow = int.tryParse(_contextWindowController.text);
    final maxOutputTokens = int.tryParse(_maxOutputTokensController.text);

    final model = ModelConfig(
      id: id,
      nickname: nickname.isNotEmpty ? nickname : null,
      type: _modelType,
      supportsVision: _supportsVision,
      supportsReasoning: _supportsReasoning,
      supportsFunctionCalling: _supportsFunctionCalling,
      contextWindow: contextWindow,
      maxOutputTokens: maxOutputTokens,
    );

    widget.onSave(model);
    Navigator.pop(context);
  }
}

/// 显示模型编辑对话框
Future<void> showModelEditDialog({
  required BuildContext context,
  ModelConfig? model,
  required ValueChanged<ModelConfig> onSave,
}) {
  return showDialog(
    context: context,
    builder: (context) => ModelEditDialog(
      model: model,
      onSave: onSave,
    ),
  );
}
