DateTime inicioCiclo = DateTime(2024, 2, 19);
DateTime finCiclo = DateTime(2024, 4, 28);

List<List<String>> crearCalendario() {
  int semanas = calcularSemanas();
  List<List<String>> calendario = [];

  for (int i = 0; i < semanas; i++) {
    DateTime inicioSemana = inicioCiclo.add(Duration(days: 7 * i));
    List<String> semana = [];
    for (int j = 0; j < 5; j++) {
      DateTime dia = inicioSemana.add(Duration(days: j));
      semana.add('${dia.year}-${dia.month}-${dia.day}');
    }
    calendario.add(semana);
  }
  return calendario;
}

int calcularSemanas() {
  int semanas = finCiclo.difference(inicioCiclo).inDays ~/ 7;

  print('Semanas: $semanas');

  return semanas + 1;
}
