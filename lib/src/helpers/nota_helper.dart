import 'package:notas/objectbox.g.dart';
import 'package:notas/src/helpers/object_box.dart';
import 'package:notas/src/models/nota.dart';

class NotaHelper {
  late final Box<Nota> _notaBox;
  late ObjectBox objectBox;

  NotaHelper() {
    _notaBox = ObjectBox.box;
  }

  int save(Nota nota) {
    return _notaBox.put(nota);
  }

  Nota? get(int id) {
    final Nota? nota = _notaBox.get(id);

    return nota;
  }

  int edit(Nota nota){
   return _notaBox.put(nota);
  }

  bool delete(int id) {
    return _notaBox.remove(id);
  }

  List<Nota> getAll() {
    List<Nota> notas = [];
    List list = _notaBox.getAll();

    for (Nota nota in list) {
      notas.add(nota);
    }
    return notas;
  }
}
