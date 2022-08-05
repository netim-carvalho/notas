import 'package:flutter/material.dart';
import 'package:notas/src/helpers/nota_helper.dart';
import 'package:notas/src/models/nota.dart';
import 'package:notas/src/repositories/nota_repository_objetbox_impl.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'look_nota_controller.dart';

class LookNotaPage extends StatefulWidget {
  final Nota nota;

  const LookNotaPage(this.nota, {Key? key}) : super(key: key);

  @override
  State<LookNotaPage> createState() => _LookNotaPageState();
}

class _LookNotaPageState extends State<LookNotaPage> {
  late final LookNotaController lookNotaController;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lookNotaController =
        LookNotaController(NotaRepositoryObjectboxImpl(NotaHelper()));
    lookNotaController.status.value = widget.nota.status;
    titleController.text = widget.nota.title ?? "";
    descriptionController.text = widget.nota.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              lookNotaController.status.value =
                  lookNotaController.status.value ? false : true;
            },
            icon: RxBuilder(
              builder: (BuildContext context) {
                return Icon(lookNotaController.status.value
                    ? Icons.lock_outline_sharp
                    : Icons.lock_open_sharp);
              },
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          "Notas",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          lookNotaController.edit(
              id: widget.nota.id!,
              title: titleController.text,
              description: descriptionController.text,
              status: lookNotaController.status.value);
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 20),
              child: TextField(
                controller: titleController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(fontSize: 28, color: Colors.black),
                decoration: const InputDecoration(
                    hintText: "Título",
                    hintStyle: TextStyle(fontSize: 28, color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, bottom: 2),
                child: TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 120,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Descrição",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black54),
                      border: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
