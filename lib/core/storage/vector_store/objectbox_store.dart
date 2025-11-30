import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../../objectbox.g.dart';
import '../../../features/knowledge_base/data/models/document_chunk.dart';

/// ObjectBox Store 单例管理
class ObjectBoxStore {
  static ObjectBoxStore? _instance;
  late final Store _store;

  ObjectBoxStore._internal(this._store);

  static Future<ObjectBoxStore> create() async {
    if (_instance != null) return _instance!;

    final dir = await getApplicationDocumentsDirectory();
    final storePath = p.join(dir.path, 'chatbox_objectbox');

    final store = await openStore(directory: storePath);
    _instance = ObjectBoxStore._internal(store);
    return _instance!;
  }

  Store get store => _store;

  Box<DocumentChunk> get documentChunkBox => _store.box<DocumentChunk>();
  Box<DocumentChunkLarge> get documentChunkLargeBox =>
      _store.box<DocumentChunkLarge>();

  void close() {
    _store.close();
    _instance = null;
  }
}
