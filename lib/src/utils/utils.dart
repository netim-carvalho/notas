import 'package:notas/src/models/nota.dart';
import 'package:rx_notifier/rx_notifier.dart';

class Utils{
  Nota searchNota(RxList rxList, int id){
    late final Nota nota;
    for(Nota n in rxList){
      if(n.id == id){
        nota = n;
      }
    }
    return nota;
  }

}