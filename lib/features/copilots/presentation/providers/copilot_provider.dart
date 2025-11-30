import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/storage/database/app_database.dart';
import '../../domain/copilot.dart';

final copilotsProvider = StreamProvider<List<CopilotEntity>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllCopilots().map((copilots) => copilots
      .map((c) => CopilotEntity(
            id: c.id,
            name: c.name,
            picUrl: c.picUrl,
            prompt: c.prompt,
            starred: c.starred,
            usedCount: c.usedCount,
            createdAt: c.createdAt,
          ))
      .toList());
});

final copilotByIdProvider =
    FutureProvider.family<CopilotEntity?, String>((ref, id) async {
  final db = ref.watch(databaseProvider);
  final copilot = await db.getCopilot(id);
  if (copilot == null) return null;
  return CopilotEntity(
    id: copilot.id,
    name: copilot.name,
    picUrl: copilot.picUrl,
    prompt: copilot.prompt,
    starred: copilot.starred,
    usedCount: copilot.usedCount,
    createdAt: copilot.createdAt,
  );
});

class CopilotActions {
  final Ref _ref;
  final _uuid = const Uuid();

  CopilotActions(this._ref);

  AppDatabase get _db => _ref.read(databaseProvider);

  Future<void> create({
    required String name,
    required String prompt,
    String? picUrl,
  }) async {
    await _db.insertCopilot(CopilotsCompanion(
      id: Value(_uuid.v4()),
      name: Value(name),
      prompt: Value(prompt),
      picUrl: Value(picUrl),
      starred: const Value(false),
      usedCount: const Value(0),
      createdAt: Value(DateTime.now()),
    ));
  }

  Future<void> update({
    required String id,
    required String name,
    required String prompt,
    String? picUrl,
    bool? starred,
    int? usedCount,
  }) async {
    final existing = await _db.getCopilot(id);
    if (existing == null) return;

    await _db.updateCopilot(CopilotsCompanion(
      id: Value(id),
      name: Value(name),
      prompt: Value(prompt),
      picUrl: Value(picUrl),
      starred: Value(starred ?? existing.starred),
      usedCount: Value(usedCount ?? existing.usedCount),
      createdAt: Value(existing.createdAt),
    ));
  }

  Future<void> toggleStarred(String id) async {
    final existing = await _db.getCopilot(id);
    if (existing == null) return;

    await _db.updateCopilot(CopilotsCompanion(
      id: Value(id),
      name: Value(existing.name),
      prompt: Value(existing.prompt),
      picUrl: Value(existing.picUrl),
      starred: Value(!existing.starred),
      usedCount: Value(existing.usedCount),
      createdAt: Value(existing.createdAt),
    ));
  }

  Future<void> incrementUsedCount(String id) async {
    final existing = await _db.getCopilot(id);
    if (existing == null) return;

    await _db.updateCopilot(CopilotsCompanion(
      id: Value(id),
      name: Value(existing.name),
      prompt: Value(existing.prompt),
      picUrl: Value(existing.picUrl),
      starred: Value(existing.starred),
      usedCount: Value(existing.usedCount + 1),
      createdAt: Value(existing.createdAt),
    ));
  }

  Future<void> delete(String id) async {
    await _db.deleteCopilot(id);
  }
}

final copilotActionsProvider = Provider((ref) => CopilotActions(ref));
