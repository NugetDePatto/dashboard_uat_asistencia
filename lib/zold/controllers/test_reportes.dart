import 'package:dashboard_uat_asistencia/zold/controllers/reportes_controller.dart';
import 'package:excel/excel.dart';

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
