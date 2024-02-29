import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> cantidadProfesores(String path) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var ciclos = firestore.collection('ciclos');
  var ciclo = ciclos.doc(path);

  var profesores = await ciclo.collection('profesores').count().get();

  return profesores.count;
}

//funcion para ver en vivo una coleccion de datos
//recibe el path de la coleccion
//retorna un streambuilder

Stream<QuerySnapshot<Map<String, dynamic>>> verProfesoresFaltantes(
    String path) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var ciclos = firestore.collection('ciclos');
  var ciclo = ciclos.doc(path);
  var profesores = ciclo.collection('asistencias');
  var profesoresStream = profesores.snapshots();
  return profesoresStream;
}

Stream<QuerySnapshot<Map<String, dynamic>>> verReportes(String path) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var ciclos = firestore.collection('ciclos');
  var ciclo = ciclos.doc(path);
  var reportes = ciclo.collection('reportes');
  var reportesStream = reportes.snapshots();
  return reportesStream;
}
