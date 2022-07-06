import 'package:flutter/material.dart';
import 'package:notas/src/helpers/nota_helper.dart';
import 'package:notas/src/helpers/object_box.dart';
import 'package:notas/src/views/home/home_page.dart';

late ObjectBox objectBox;
late NotaHelper notaHelper;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  runApp(MaterialApp(
    home: const HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.black),
    ),
  ));
}
