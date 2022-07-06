import 'package:notas/src/models/nota.dart';

abstract class NotaRepository {
  int save(Nota nota);

  Nota? get(int id);

  int edit(Nota nota);

  bool delete(int id);

  List<Nota> getAll();
}
