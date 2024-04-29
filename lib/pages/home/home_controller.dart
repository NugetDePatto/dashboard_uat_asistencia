import 'package:dashboard_uat_asistencia/services/reporte_service.dart';

class HomeController {
  crearReporte() async {
    // Lógica para crear un reporte
    await ReporteService().archivoReporte();
  }
}
