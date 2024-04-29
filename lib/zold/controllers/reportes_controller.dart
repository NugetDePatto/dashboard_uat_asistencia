import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';

class ReporteController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String get ciclo {
    // enero a mayo = primavera
    // junio a julio = verano
    // agosto a diciembre = otoño

    int mesActual = DateTime.now().month;

    if (kDebugMode) {
      return '2023 - 3 Otoño';
    } else if (mesActual >= 1 && mesActual <= 5) {
      return '${DateTime.now().year} - 1 Primavera';
    } else if (mesActual >= 6 && mesActual <= 7) {
      return '${DateTime.now().year} - 2 Verano';
    } else {
      return '${DateTime.now().year} - 3 Otoño';
    }
  }

  reportePorCarrera() {
    var ciclos = firestore.collection('ciclos').doc(ciclo);
    var asistencias = ciclos.collection('asistencias').where(
          'idAsistencia',
        );
  }
}

var excel;

void crearExcel(
  List<String> headers,
  List<Map<String, dynamic>> data,
  String fileName,
) {
  headers.remove('timeServer');
  excel = Excel.createExcel();

  Sheet sheetObject = excel['Sheet1'];
  sheetObject.appendRow(headers);

  var row = 1;
  for (var i = 0; i < data.length; i++) {
    var datos = data[i];
    for (var j = 0; j < headers.length; j++) {
      sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: row))
              .value =
          datos[headers[j]].toString().isEmpty
              ? 'Sin mensaje'
              : datos[headers[j]].toString().trim();
    }
    row++;
    // sheetObject.appendRow(data[i].values.toList());
  }

  excel.save(fileName: '$fileName.xlsx');
}

Future<void> reportesMantenimiento(String ciclo) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var ciclos = firestore.collection('ciclos').doc(ciclo);
  var reportes = await ciclos.collection('reportes').get();

  if (reportes.docs.isEmpty) {
    return;
  }

  var headers = reportes.docs[0].data().keys.toList();

  var data = reportes.docs
      .where((element) {
        String firstChar = element.id[0];
        return RegExp(r'[A-Za-z]').hasMatch(firstChar);
      })
      .map((e) => e.data())
      .toList();

  var fileName = 'reportes_mantenimiento_$ciclo';
  crearExcel(headers, data, fileName);
}

Future<void> reportesProfesores(String ciclo) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var ciclos = firestore.collection('ciclos').doc(ciclo);
  var reportes = await ciclos.collection('reportes').get();

  if (reportes.docs.isEmpty) {
    return;
  }

  var headers = reportes.docs[0].data().keys.toList();

  var data = reportes.docs
      .where((element) {
        String firstChar = element.id[0];
        return !RegExp(r'[A-Za-z]').hasMatch(firstChar);
      })
      .map((e) => e.data())
      .toList();

  var fileName = 'reportes_profesores_$ciclo';
  crearExcel(headers, data, fileName);
}

Future<void> reportesTodos(String ciclo) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var ciclos = firestore.collection('ciclos').doc(ciclo);
  var reportes = await ciclos.collection('reportes').get();

  if (reportes.docs.isEmpty) {
    return;
  }

  var headers = reportes.docs[0].data().keys.toList();

  var data = reportes.docs.map((e) => e.data()).toList();

  var fileName = 'reportes_$ciclo';
  crearExcel(headers, data, fileName);
}

void borrarReportes(String ciclo) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var ciclos = firestore.collection('ciclos').doc(ciclo);
  ciclos.collection('reportes').get().then((value) {
    for (var element in value.docs) {
      element.reference.delete();
    }
  });
}

//quedó pendiente
void obtenerAsistenciaPorGrupos(List<String> grupos, String ciclo) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var ciclos = firestore.collection('ciclos').doc(ciclo);
  var asistencias =
      ciclos.collection('profesores').where('grupo', whereIn: grupos);
}
