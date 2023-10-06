import 'package:community_material_icon/community_material_icon.dart';
import 'package:dashboard_uat_asistencia/controllers/reportes_controller.dart';
import 'package:flutter/material.dart';

void verdescargasReportes(context, ciclo) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('¿Qué tipo de reporte desea descargar?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(
              CommunityMaterialIcons.tools,
            ),
            onPressed: () {
              reportesMantenimiento(ciclo);

              Navigator.pop(context);
            },
            label: const Text(
              'Mantenimiento',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(
              CommunityMaterialIcons.account_tie,
            ),
            onPressed: () {
              reportesProfesores(ciclo);

              Navigator.pop(context);
            },
            label: const Text(
              'Profesores',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(
              CommunityMaterialIcons.book,
            ),
            onPressed: () {
              reportesTodos(ciclo);

              Navigator.pop(context);
            },
            label: const Text(
              'Todos los reportes',
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(
              CommunityMaterialIcons.trash_can,
            ),
            onPressed: () {
              //crea un dialogo de confirmación y despues borra
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('¿Está seguro de borrar los reportes?'),
                  content: const Text(
                      'Esta acción no se puede deshacer, los reportes se borrarán de la base de datos.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        borrarReportes(ciclo);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Borrar'),
                    ),
                  ],
                ),
              );
            },
            label: const Text(
              'Borrar Actuales',
            ),
          ),
        ],
      ),
    ),
  );
}
