import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';

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

void descargarTestDeAsistencia(List<String> grupos, String ciclo) {
  excel = Excel.createExcel();

  Sheet sheetObject = excel['Sheet1'];
  sheetObject.appendRow([
    'Nombre de docente',
    'Materia',
    'Grado',
    'Grupo',
    'Días de clase en el periodo',
    'Días de clase reportados',
    'Porcentaje de asistencia',
  ]);
  sheetObject.appendRow([
    'ADRIANA MONTOTO GONZALEZ',
    'FUNDAMENTOS DE PROGRAMACION',
    1,
    'I',
    10,
    7,
    '70%',
  ]);

  sheetObject.appendRow([
    '',
    'FUNDAMENTOS DE PROGRAMACION',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);

  sheetObject.appendRow([
    'ALEJANDRO HUMBERTO GARCIA RUIZ',
    'AUTOMATIZACION Y ROBOTICA',
    9,
    'G',
    6,
    6,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    'AUTOMATIZACION Y ROBOTICA',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);

  sheetObject.appendRow([
    'ARMANDO BECERRA DEL ANGEL',
    'AUTOMATIZACION Y ROBOTICA',
    9,
    'G',
    6,
    6,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    'AUTOMATIZACION Y ROBOTICA',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);

  sheetObject.appendRow([
    'ADRIANA MONTOTO GONZALEZ',
    'FUNDAMENTOS DE PROGRAMACION',
    1,
    'I',
    10,
    7,
    '70%',
  ]);

  sheetObject.appendRow([
    '',
    'FUNDAMENTOS DE PROGRAMACION',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);

  sheetObject.appendRow([
    'ALEJANDRO HUMBERTO GARCIA RUIZ',
    'AUTOMATIZACION Y ROBOTICA',
    9,
    'G',
    6,
    6,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    'AUTOMATIZACION Y ROBOTICA',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);

  sheetObject.appendRow([
    'ARMANDO BECERRA DEL ANGEL',
    'AUTOMATIZACION Y ROBOTICA',
    9,
    'G',
    6,
    6,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    'AUTOMATIZACION Y ROBOTICA',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);
  sheetObject.appendRow([
    'ADRIANA MONTOTO GONZALEZ',
    'FUNDAMENTOS DE PROGRAMACION',
    1,
    'I',
    10,
    7,
    '70%',
  ]);

  sheetObject.appendRow([
    '',
    'FUNDAMENTOS DE PROGRAMACION',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);

  sheetObject.appendRow([
    'ALEJANDRO HUMBERTO GARCIA RUIZ',
    'AUTOMATIZACION Y ROBOTICA',
    9,
    'G',
    6,
    6,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    'AUTOMATIZACION Y ROBOTICA',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);

  sheetObject.appendRow([
    'ARMANDO BECERRA DEL ANGEL',
    'AUTOMATIZACION Y ROBOTICA',
    9,
    'G',
    6,
    6,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    'AUTOMATIZACION Y ROBOTICA',
    1,
    'J',
    8,
    7,
    '87%',
  ]);
  sheetObject.appendRow([
    '',
    'PROGRAMACION ORIENTADA A OBJETOS',
    2,
    'G',
    8,
    8,
    '100%',
  ]);

  sheetObject.appendRow([
    '',
    '',
    '',
    '',
    '',
    'TOTOAL:',
    '86%',
  ]);
  excel.save(
      fileName: 'asistencia_${grupos[0]}_${grupos[1]}_${grupos[2]}.xlsx');
}
