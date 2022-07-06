import 'package:flutter_test/flutter_test.dart';
import 'package:notas/src/helpers/nota_helper.dart';
import 'package:notas/src/helpers/object_box.dart';
import 'package:notas/src/models/nota.dart';
import 'package:notas/src/repositories/nota_repository_objetbox_impl.dart';

void main() {
  test("deve retornar o ID quando salvar a nota no db", () async {
    NotaRepositoryObjectboxImpl n =
        NotaRepositoryObjectboxImpl(new NotaHelper());
    var id = await n
        .save(new Nota(description: "d", date: DateTime.now(), status: true));
    expect(id, equals(1));
  });
}
