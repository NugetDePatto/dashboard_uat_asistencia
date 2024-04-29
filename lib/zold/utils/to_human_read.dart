import 'package:intl/intl.dart';

String humanMonth(int month) {
  return month == 1
      ? 'Enero'
      : month == 2
          ? 'Febrero'
          : month == 3
              ? 'Marzo'
              : month == 4
                  ? 'Abril'
                  : month == 5
                      ? 'Mayo'
                      : month == 6
                          ? 'Junio'
                          : month == 7
                              ? 'Julio'
                              : month == 8
                                  ? 'Agosto'
                                  : month == 9
                                      ? 'Septiembre'
                                      : month == 10
                                          ? 'Octubre'
                                          : month == 11
                                              ? 'Noviembre'
                                              : month == 12
                                                  ? 'Diciembre'
                                                  : '';
}

String formatRelativeTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return 'Hace unos minutos';
  } else if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return 'Hace $minutes ${minutes == 1 ? 'minuto' : 'minutos'}';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return 'Hace $hours ${hours == 1 ? 'hora' : 'horas'}';
  } else if (difference.inDays < 7) {
    final days = difference.inDays;
    return 'Hace $days ${days == 1 ? 'día' : 'días'}';
  } else {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
