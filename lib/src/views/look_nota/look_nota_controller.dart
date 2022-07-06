import 'package:notas/src/models/nota.dart';
import 'package:notas/src/repositories/nota_repositoy.dart';

class LookNotaController {
  final NotaRepository notaRepository;

  LookNotaController(this.notaRepository);

  Future<int> edit(
      {required int id,
      String? title,
      required String description,
      required bool status}) async {
    final nota = Nota(
        id: id,
        title: title,
        description: description,
        date: DateTime.now(),
        status: status);
    int idRetorno = notaRepository.edit(nota);
    return idRetorno;
  }
}
