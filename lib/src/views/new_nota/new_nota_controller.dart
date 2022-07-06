import 'package:flutter/cupertino.dart';
import 'package:notas/src/models/nota.dart';
import 'package:notas/src/repositories/nota_repositoy.dart';

class NewNotaController {
  final NotaRepository notaRepository;

  NewNotaController(this.notaRepository);

  Future<int> save(
      {String? title,
      required BuildContext context,
      required String description,
      required bool status}) async {
    final nota = Nota(
        title: title,
        description: description,
        date: DateTime.now(),
        status: status);
    int id = notaRepository.save(nota);
    return id;
  }
}
