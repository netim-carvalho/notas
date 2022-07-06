import 'package:objectbox/objectbox.dart';

@Entity()
class Nota {
  int? id;
  String? title;
  String description;
  DateTime date;
  bool status;

  Nota(
      {this.id = 0,
      this.title,
      required this.description,
      required this.date,
      required this.status});
}
