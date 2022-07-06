import 'package:notas/src/helpers/nota_helper.dart';
import 'package:notas/src/models/nota.dart';
import 'package:notas/src/repositories/nota_repositoy.dart';

class NotaRepositoryObjectboxImpl implements NotaRepository {
  final NotaHelper notaHelper;

  NotaRepositoryObjectboxImpl(this.notaHelper);

  @override
  int save(Nota nota) {
    return notaHelper.save(nota);
  }

  @override
  bool delete(int id) {
    return notaHelper.delete(id);
  }

  @override
  List<Nota> getAll() {
    return notaHelper.getAll();
  }

  @override
  Nota? get(int id) {
    return notaHelper.get(id);
  }

  @override
  int edit(Nota nota) {
    return notaHelper.edit(nota);
  }
}
