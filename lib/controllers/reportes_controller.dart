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

  var row = 2;
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

  var headers = reportes.docs[0].data().keys.toList();
  var data = reportes.docs.map((e) => e.data()).toList();
  var fileName = 'reportes_mantenimiento_$ciclo';
  crearExcel(headers, data, fileName);
}
