import 'package:flutter/foundation.dart';

String get ciclo {
  // enero a mayo = primavera, junio a julio = verano, agosto a diciembre = otoño

  int mesActual = DateTime.now().month;

  if (kDebugMode) {
    return '2024 - 1 Primavera';
  } else if (mesActual >= 1 && mesActual <= 5) {
    return '${DateTime.now().year} - 1 Primavera';
  } else if (mesActual >= 6 && mesActual <= 7) {
    return '${DateTime.now().year} - 2 Verano';
  } else {
    return '${DateTime.now().year} - 3 Otoño';
  }
}
