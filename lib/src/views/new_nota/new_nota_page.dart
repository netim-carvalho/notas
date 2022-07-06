import 'package:flutter/material.dart';
import 'package:notas/src/helpers/nota_helper.dart';
import 'package:notas/src/repositories/nota_repository_objetbox_impl.dart';
import 'package:notas/src/views/new_nota/new_nota_controller.dart';

class NewNotaPage extends StatefulWidget {
  const NewNotaPage({Key? key}) : super(key: key);

  @override
  State<NewNotaPage> createState() => _NewNotaPageState();
}

class _NewNotaPageState extends State<NewNotaPage> {
  late final NewNotaController newNotaController;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newNotaController =
        NewNotaController(NotaRepositoryObjectboxImpl(NotaHelper()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (status) {
                setState(() {
                  status = false;
                });
              } else {
                setState(() {
                  status = true;
                });
              }
            },
            icon:
                Icon(status ? Icons.lock_outline_sharp : Icons.lock_open_sharp),
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
          newNotaController.save(
              title: titleController.text,
              context: context,
              description: descriptionController.text,
              status: status);
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.save,
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
