import 'package:community_material_icon/community_material_icon.dart';
import 'package:dashboard_uat_asistencia/controllers/reportes_controller.dart';
import 'package:flutter/material.dart';

void verdescargasReportes(context) {
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
              reportesMantenimiento('TEST - 2023 - 3 Otoño');
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
            onPressed: () {},
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
            onPressed: () {},
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
            onPressed: () {},
            label: const Text(
              'Borrar Actuales',
            ),
          ),
        ],
      ),
    ),
  );
}
