import 'package:flutter/material.dart';
import 'package:notas/src/models/nota.dart';
import 'package:notas/src/repositories/nota_repositoy.dart';
import 'package:notas/src/views/look_nota/look_nota_page.dart';
import 'package:notas/src/views/new_nota/new_nota_page.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomeController {
  final NotaRepository notaRepository;
  static String? returnError;

  RxList<Nota> rxList = RxList<Nota>([]);

  HomeController(this.notaRepository);

  void getAll() {
    final listNota = notaRepository.getAll();
    rxList.clear();
    rxList.addAll(listNota.toList());
  }

  void delete(int id) {
    notaRepository.delete(id);
    getAll();
  }

  void calledNewNotaPage(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewNotaPage()));
    getAll();
  }

  void calledLookNotaPage(
    BuildContext context, {
    required int index,
  }) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => LookNotaPage(rxList[index])));
    getAll();
  }
}
