import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../../core/di/providers.dart';
import '../../../../core/storage/database/app_database.dart';
import '../../domain/entities/session_settings.dart';
import '../../../settings/presentation/widgets/slider_with_label.dart';

class SessionSettingsDialog extends ConsumerStatefulWidget {
  final String sessionId;
  final String sessionName;
  final String? settingsJson;

  const SessionSettingsDialog({
    super.key,
    required this.sessionId,
    required this.sessionName,
    this.settingsJson,
  });

  @override
  ConsumerState<SessionSettingsDialog> createState() =>
      _SessionSettingsDialogState();
}

class _SessionSettingsDialogState extends ConsumerState<SessionSettingsDialog> {
  late TextEditingController _nameController;
  late TextEditingController _promptController;
  late SessionSettings _settings;
  bool _showAdvanced = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.sessionName);

    if (widget.settingsJson != null && widget.settingsJson!.isNotEmpty) {
      try {
        final json = jsonDecode(widget.settingsJson!) as Map<String, dynamic>;
        _settings = SessionSettings.fromJson(json);
      } catch (e) {
        _settings = const SessionSettings();
      }
    } else {
      _settings = const SessionSettings();
    }

    _promptController = TextEditingController(
      text: _settings.systemPrompt ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final db = ref.read(databaseProvider);
    final session = await db.getSession(widget.sessionId);
    if (session == null) return;

    final updatedSettings = _settings.copyWith(
      systemPrompt: _promptController.text.isEmpty ? null : _promptController.text,
    );

    await db.updateSession(
      session.toCompanionWith(
        name: Value(_nameController.text),
        settingsJson: Value(jsonEncode(updatedSettings.toJson())),
        updatedAt: Value(DateTime.now()),
      ),
    );

    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '对话设置',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Avatar icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Icon(
                  Icons.smart_toy_outlined,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),

              // Name field
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '名称',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // System prompt
              TextField(
                controller: _promptController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: '系统提示（角色设定）',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Advanced settings
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ExpansionTile(
                        title: const Text('特定模型设置'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _settings = const SessionSettings();
                                });
                              },
                              child: const Text('重置'),
                            ),
                            Icon(
                              _showAdvanced
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                          ],
                        ),
                        onExpansionChanged: (expanded) {
                          setState(() => _showAdvanced = expanded);
                        },
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                IntSliderWithLabel(
                                  label: '上下文的消息数量上限',
                                  tooltip: '发送给 AI 的历史消息数量上限',
                                  value: _settings.maxContextMessages ?? 10,
                                  min: 0,
                                  max: 20,
                                  onChanged: (v) {
                                    setState(() {
                                      _settings = _settings.copyWith(
                                        maxContextMessages: v,
                                      );
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                SliderWithLabel(
                                  label: '温度',
                                  tooltip: '控制回复的随机性',
                                  value: _settings.temperature,
                                  min: 0,
                                  max: 2,
                                  onChanged: (v) {
                                    setState(() {
                                      _settings = _settings.copyWith(
                                        temperature: v,
                                      );
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                SliderWithLabel(
                                  label: 'Top P',
                                  tooltip: '控制采样范围',
                                  value: _settings.topP,
                                  min: 0,
                                  max: 1,
                                  onChanged: (v) {
                                    setState(() {
                                      _settings = _settings.copyWith(topP: v);
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '最大输出Token数',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '未设置',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                        ),
                                        controller: TextEditingController(
                                          text: _settings.maxOutputTokens
                                              ?.toString(),
                                        ),
                                        onChanged: (v) {
                                          final parsed = int.tryParse(v);
                                          setState(() {
                                            _settings = _settings.copyWith(
                                              maxOutputTokens: parsed,
                                            );
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                SwitchListTile(
                                  title: const Text('流式输出'),
                                  value: _settings.streamingOutput,
                                  onChanged: (v) {
                                    setState(() {
                                      _settings = _settings.copyWith(
                                        streamingOutput: v,
                                      );
                                    });
                                  },
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('取消'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _save,
                    child: const Text('保存'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension SessionCopyWith on Session {
  SessionsCompanion toCompanionWith({
    Value<String>? name,
    Value<String?>? settingsJson,
    Value<DateTime>? updatedAt,
  }) {
    return SessionsCompanion(
      id: Value(id),
      name: name ?? Value(this.name),
      type: Value(type),
      starred: Value(starred),
      copilotId: Value(copilotId),
      settingsJson: settingsJson ?? Value(this.settingsJson),
      createdAt: Value(createdAt),
      updatedAt: updatedAt ?? Value(this.updatedAt),
    );
  }
}
