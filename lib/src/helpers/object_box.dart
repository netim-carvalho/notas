import 'package:notas/objectbox.g.dart';
import 'package:notas/src/models/nota.dart';

class ObjectBox {
  late final Store _store;
  static late final Box<Nota> box;

  ObjectBox._init(this._store) {
    box = Box<Nota>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }
}
