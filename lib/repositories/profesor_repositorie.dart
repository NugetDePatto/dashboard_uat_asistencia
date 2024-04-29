import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_uat_asistencia/providers/firestore_provider.dart';
import 'package:dashboard_uat_asistencia/utils/asistencia.dart';
import 'package:dashboard_uat_asistencia/utils/calendario_utils.dart';
import 'package:dashboard_uat_asistencia/utils/profesores.dart';

class ProfesorRepository {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();

  CollectionReference<Map<String, dynamic>> getProfesores() {
    return _firestoreProvider.getCollection('profesores');
  }

  Map<String, dynamic> crearCalendarioProfesores(String finCalendario) {
    Map profesores = profesores_util;

    Map<String, dynamic> calendarioProfesores = {};

    List<List<String>> calendario = crearCalendario();

    for (var profesor in profesores.entries) {
      Map<String, dynamic> profesorCalendario = obtenerProfesorCalendario(
        profesor.key,
        profesor.value['materias'],
        finCalendario,
        calendario,
      );

      calendarioProfesores[profesor.key] = profesorCalendario;
    }

    return calendarioProfesores;
  }

  bool? obtenerAsistenciaMateria(idProfesor, idMateria, fecha, horario) {
    Map asistencias = asistencia_util;

    String id = idProfesor + '_' + idMateria + '_' + fecha + '_' + horario;

    if (asistencias.containsKey(id)) {
      return asistencias[id]['Tablet 01']['asistencia'];
    }

    return null;
  }

  Map<String, dynamic> obtenerProfesorCalendario(
    String idProfesor,
    Map<String, dynamic> materias,
    String finCalendario,
    List<List<String>> calendario,
  ) {
    Map<String, dynamic> profesorCalendario = {};

    for (var materiaEntrie in materias.entries) {
      List<List<bool?>> materiaCalendario = [];
      var materia = obtenerDatosMateria(idProfesor, materiaEntrie.key);
      List<String> horario = materia['horario'];
      for (int i = 0; i < calendario.length; i++) {
        List<bool?> semana = [];
        for (int j = 0; j < calendario[i].length; j++) {
          String fecha = calendario[i][j];
          String horarioMateria = horario[j].replaceAll(' ', '');
          String idMateria = materia['id'];
          bool? asistencia;
          if (horarioMateria != '-') {
            asistencia = obtenerAsistenciaMateria(
              idProfesor,
              idMateria,
              fecha,
              horarioMateria,
            );
          }
          semana.add(asistencia);
        }
        materiaCalendario.add(semana);
      }
      profesorCalendario[materia['idMateria']] = materiaCalendario;
    }

    return profesorCalendario;
  }

  Map<String, dynamic> obtenerDatosMateria(
    String idProfesor,
    String idMateria,
  ) {
    Map profesores = profesores_util;

    Map<String, dynamic> materia =
        profesores[idProfesor]['materias'][idMateria];

    return {
      'nombre': materia['materia'],
      'grupo': materia['grupo'],
      'titular': materia['titular'],
      'horario': materia['horario'],
      'id': materia['grupo'] + '-' + materia['clave'],
      'idMateria': idMateria,
    };
  }
}


  // dentro de un profesor, se tiene un mapa de materias ['materias'], en una materia lo que importa sacar es el nombre que esta en ['materia'], el grupo que esta en ['grupo'], y el horario que esta en ['horario'] y por si acaso el titulo que esta en ['titular'], el id de la materia es la conbinacion del grupo y la clave

        // 'idProfesor': {
      //   'nombre': 'nombreProfesor',
      //   'materias': {
      //     'idMateria': {
      //       'nombre': 'nombreMateria',
      //       'grupo': 'grupoMateria',
      //       'horario': [//apartir de las semanas hacer una lista del tamaño de las semanas con el horario de la materia en cada semana],
      //       'titular': 'titularMateria',
      //     },
      //   }
      // }
  //       crearMapaProfesores() async {
  //   Map<String, dynamic> mapa = {};

  //   var querySnapshot = await getProfesores().get();

  //   for (var element in querySnapshot.docs) {
  //     // Convertir Timestamp a un tipo serializable
  //     Map<String, dynamic> elementData = element.data();
  //     Map<String, dynamic> newData = {};
  //     elementData.forEach((key, value) {
  //       if (value is Timestamp) {
  //         newData[key] = {
  //           'seconds': value.seconds,
  //           'nanoseconds': value.nanoseconds
  //         };
  //       } else {
  //         newData[key] = value;
  //       }
  //     });
  //     mapa[element.id] = newData;
  //   }

  //   String json = jsonEncode(mapa);
  //   print(json);
  // }


     // for (var profesor in profesores.entries) {
    //   Map<String, dynamic> profesorCalendario = obtenerProfesorCalendario(
    //     profesor.key,
    //     profesor.value['materias'],
    //   );

    //   print(profesorCalendario);
    // }