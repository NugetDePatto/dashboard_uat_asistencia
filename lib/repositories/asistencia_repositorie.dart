import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_uat_asistencia/providers/firestore_provider.dart';
import 'package:dashboard_uat_asistencia/utils/asistencia.dart';

class AsistenciaRepositorie {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();

  CollectionReference<Map<String, dynamic>> getAsistencias() {
    return _firestoreProvider.getCollection('asistencias');
  }

  Future<List> crearListaAsistencias() async {
    List lista = [];

    Map asistecias = asistencia_util;

    for (var asistencia in asistecias.entries) {
      lista.add({
        'idAsistencia': asistencia.key,
        ...asistencia.value,
      });
      // print('idAsistencia: ${asistencia.key}');
    }

    return lista;
  }
}
