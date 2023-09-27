import 'package:excel/excel.dart';

var excel;

void crearExcel() {
  excel = Excel.createExcel();

  Sheet sheetObject = excel['Sheet1'];
  sheetObject.appendRow(['Nombre', 'Apellido', 'Edad']);
  sheetObject.appendRow(['Juan', 'Perez', 25]);
  sheetObject.appendRow(['Maria', 'Gomez', 30]);

  var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
  print('File saved! Go find it in your file system.');
}
