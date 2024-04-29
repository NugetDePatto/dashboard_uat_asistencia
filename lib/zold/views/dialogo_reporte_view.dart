import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard_uat_asistencia/zold/constantes/mapa.dart';
import 'package:dashboard_uat_asistencia/zold/asistencias_controller.dart';
import 'package:dashboard_uat_asistencia/zold/controllers/pdf_service.dart';
import 'package:flutter/material.dart';

void dialogoCrearReporte(BuildContext context) {
  TextEditingController inicio = TextEditingController(text: '2024-4-15');
  TextEditingController fin = TextEditingController(text: '2024-4-22');

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Ver Reporte'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: inicio,
            onTap: () {
              //fecha inicial 2024-4-15
              showDatePicker(
                context: context,
                initialDate: DateTime(2024, 4, 15),
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
              ).then((value) {
                if (value == null) return;
                String fecha = '${value.year}-${value.month}-${value.day}';
                inicio.text = fecha;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Fecha Inicial',
            ),
            readOnly: true,
          ),
          TextField(
            controller: fin,
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2025),
              ).then((value) {
                if (value == null) return;
                String fecha = '${value.year}-${value.month}-${value.day}';
                fin.text = fecha;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Fecha Final',
            ),
            readOnly: true,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
            Map<String, dynamic> reporte =
                AsistenciasController().reportePrueba();
            Map<String, dynamic> totalAsistencias = mapa;

            PDFServices().ejemploPDF(reporte, totalAsistencias);

            // Map<String, dynamic> mapafinal = {};
            // for (var pr in reporte.keys) {
            //   var profesor = reporte[pr];
            //   var key = pr;

            //   List<String> m = [
            //     for (var key in profesor.keys) key.replaceFirst('-', ''),
            //   ];

            //   print(key);
            //   var p = await FirebaseFirestore.instance
            //       .collection('ciclos')
            //       .doc('2024 - 1 Primavera')
            //       .collection('profesores')
            //       .doc(key)
            //       .get();

            //   var nombre = p.get('nombre');

            //   var materias = [];

            //   var grupos = [];

            //   for (var key in m) {
            //     var materia = p.get('materias')[key];
            //     materias.add(materia['materia']);
            //     grupos.add(materia['grupo']);
            //   }

            //   var total = [];
            //   var asistencias = [];
            //   var porcentajes = [];

            //   for (var mat in profesor.values) {
            //     total.add(mat['total']);
            //     asistencias.add(mat['asistencias']);
            //     porcentajes.add(mat['porcentaje']);
            //   }

            //   // print(nombre);
            //   // print(materias);
            //   // print(grupos);
            //   // print(total);
            //   // print(asistencias);
            //   // print(porcentajes);

            //   //guardar en mapa, profesor: {materias: [materias], grupos: [grupos], total: [total], asistencias: [asistencias], porcentajes: [porcentajes]}

            //   mapafinal.putIfAbsent(
            //     pr,
            //     () => {
            //       'nombre': nombre,
            //       'materias': materias,
            //       'grupos': grupos,
            //       'total': total,
            //       'asistencias': asistencias,
            //       'porcentajes': porcentajes,
            //     },
            //   );
            //   // for (var key in mapafinal.keys) {
            //   //   print(key);
            //   //   print(mapafinal[key]);
            //   // }
            //   print('---------------------------------');
            // }
            // await PDFServices().ejemploPDF(mapafinal);
          },
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );
}
