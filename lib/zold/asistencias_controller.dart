import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_uat_asistencia/zold/constantes/mapa.dart';
import 'package:flutter/foundation.dart';

class AsistenciasController {
  String ciclo = kDebugMode ? 'TEST - 2023 - 3 Otoño' : '2023 - 3 Otoño';

  reportePrueba() {
    ciclo = '2024 - 1 Primavera';

    Map<String, dynamic> reporte =
        mapa; // idProfesor, idMateria, fecha, hora, asistencia

    //tengo que contar todas las asistencias de cada materia de cada profesor, y sacar el porcentaje

    Map<String, dynamic> reporteFinal = {};

    for (var key in reporte.keys) {
      reporteFinal.putIfAbsent(key, () => {});
      for (var key2 in reporte[key].keys) {
        reporteFinal[key].putIfAbsent(key2, () => {});
        int total = 0;
        int asistencias = 0;
        for (var key3 in reporte[key][key2].keys) {
          for (var key4 in reporte[key][key2][key3].keys) {
            total++;
            if (reporte[key][key2][key3][key4] == true) {
              asistencias++;
            }
          }
        }
        reporteFinal[key][key2] = {
          'total': total,
          'asistencias': asistencias,
          //procentaje con dos decimales
          'porcentaje': ((asistencias / total) * 100).toStringAsFixed(2),
        };
      }
    }

    // //imprmiir reporte com si fuera un mapa en consola con todo y comillas
    // print("{");
    // for (var key in reporteFinal.keys) {
    //   print("'$key': {");
    //   for (var key2 in reporteFinal[key].keys) {
    //     print("  '$key2': ${reporteFinal[key][key2]},");
    //   }
    //   print("},");
    // }
    // print("};");

    return reporteFinal;
  }

  // reportePrueba() async {
  //   ciclo = '2024 - 1 Primavera';

  //   //si tiene el campo idAsistencia tomar

  //   var ref = await FirebaseFirestore.instance
  //       .collection('ciclos')
  //       .doc(ciclo)
  //       .collection('asistencias')
  //       .where(
  //         'idAsistencia',
  //         isNull: false,
  //       )
  //       .get();

  //   Map<String, dynamic> reporte = {};

  //   for (var doc in ref.docs) {
  //     String idAsistencia = doc.get('idAsistencia');
  //     String idProfesor = idAsistencia.split('_')[0];
  //     String idMateria = idAsistencia.split('_')[1];
  //     String fecha = idAsistencia.split('_')[2];
  //     String hora = idAsistencia.split('_')[3];

  //     reporte.putIfAbsent(idProfesor, () => {});
  //     reporte[idProfesor].putIfAbsent(idMateria, () => {});
  //     reporte[idProfesor][idMateria].putIfAbsent(fecha, () => {});
  //     reporte[idProfesor][idMateria][fecha].putIfAbsent(hora, () => {});
  //     reporte[idProfesor][idMateria][fecha][hora] =
  //         doc.get('Tablet 01')['asistencia'];
  //   }

  //   //imprmiir reporte com si fuera un mapa en consola con todo y comillas
  //   print("{");
  //   for (var key in reporte.keys) {
  //     print("'$key': {");
  //     for (var key2 in reporte[key].keys) {
  //       print("  '$key2': {");
  //       for (var key3 in reporte[key][key2].keys) {
  //         print("    '$key3': {");
  //         for (var key4 in reporte[key][key2][key3].keys) {
  //           print("      '$key4': ${reporte[key][key2][key3][key4]},");
  //         }
  //         print("    },");
  //       }
  //       print("  },");
  //     }
  //     print("},");
  //   }
  //   print("};");

  //   return reporte;
  // }

  crearReporteAsistencia(inicio, fin) async {
    Map<String, dynamic> reporte = await crearMapaAsistencia(
      inicio.text,
      fin.text,
    );

    var ref = FirebaseFirestore.instance
        .collection('ciclos')
        .doc(ciclo)
        .collection('asistencias');
  }

  Future<Map<String, dynamic>> crearMapaAsistencia(
    String fechaInicio,
    String fechaFinal,
  ) async {
    Map<String, dynamic> reporte = {};

    var ref = FirebaseFirestore.instance
        .collection('ciclos')
        .doc(ciclo)
        .collection('asistencias');

    var query = await ref
        .where(
          'fecha',
          isGreaterThanOrEqualTo: fechaInicio,
          isLessThan: fechaFinal,
        )
        .get();

    for (var doc in query.docs) {
      var idProfesor = doc.get('idProfesor');
      var idMateria = doc.get('idMateria');
      var fecha = doc.get('fecha');
      var asistencia = doc.get('Tablet 01')['asistencia'];

      reporte.putIfAbsent(idProfesor, () => {});
      reporte[idProfesor].putIfAbsent(idMateria, () => {});
      reporte[idProfesor][idMateria][fecha] = asistencia;
    }

    for (var key in reporte.keys) {
      for (var key2 in reporte[key].keys) {
        for (var key3 in reporte[key][key2].keys) {
          print(
              'Profesor: $key, Materia: $key2, Fecha: $key3, Asistencia: ${reporte[key][key2][key3]}');
        }
      }
    }

    return reporte;
  }

  Future<int> asistioProfesorMateria(ciclo, profesor, materia, dia) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var ref =
        firestore.collection('ciclos').doc(ciclo).collection('asistencias');

    String prefijo = '${profesor}_${materia}_$dia';

    var query = await ref
        .where(
          'idAsistencia',
          isGreaterThanOrEqualTo: prefijo,
          isLessThan: '${prefijo}z',
        )
        .get();

    int asistio = -1;

    for (var doc in query.docs) {
      for (var key in doc.data().keys) {
        if (key != 'idAsistencia') {
          if (doc.data()[key]['asistencia'] == true) {
            return 1;
          } else {
            asistio = 0;
          }
        }
      }
      print('--------------------------');
    }

    return asistio;
  }
}
