import 'package:dashboard_uat_asistencia/repositories/profesor_repositorie.dart';

class ReporteService {
  archivoReporte() async {
    Map<String, dynamic> calendarioProfesores =
        ProfesorRepository().crearCalendarioProfesores('2024-04-28');

    Map<String, dynamic> asistencias = {};

    for (var profesor in calendarioProfesores.entries) {
      asistencias[profesor.key] =
          obtenerDiasTotalesYAsistidosPorMateria(profesor.value);
    }
  }

  obtenerDiasTotalesYAsistidosPorMateria(materias) {
    Map<String, dynamic> asistencias = {};

    for (var materia in materias.entries) {
      List<List<bool?>> materiaCalendario = materia.value;
      int diasTotales = 0;
      int diasAsistidos = 0;

      for (var semana in materiaCalendario) {
        for (var dia in semana) {
          if (dia != null) {
            diasTotales++;
            if (dia) {
              diasAsistidos++;
            }
          }
        }
      }

      asistencias[materia.key] = {
        'diasTotales': diasTotales,
        'diasAsistidos': diasAsistidos,
        'porcentaje': (diasAsistidos / diasTotales * 100).toStringAsFixed(2),
      };

      print(materia.key);
      print(asistencias[materia.key]);
    }
  }
}


// dentro de un profesor, se tiene un mapa de materias ['materias'], en una materia lo que importa sacar es el nombre que esta en ['materia'], el grupo que esta en ['grupo'], y el horario que esta en ['horario'] y por si acaso el titulo que esta en ['titular'], el id de la materia es la conbinacion del grupo y la clave


//calendario es un mapa, continee profesores, que a su vez contiene materias, y en cada materia hay una lista de lista de bools, que representan la asistencia de cada dia de la semana por ejemplo puede serun alista de 9 semanas, q tiene un alsita de dias de la semana, y en cada dia de la semana tiene un bool que representa si el profesor asistio o no y si es null es que no se ha registrado la asistencia, entonces omitimos ese dia como si no hubiera clases ese dia