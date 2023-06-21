import 'package:dashboard_uat_asistencia/views/profesor_view.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_uat_asistencia/controllers/archivo_controller.dart';

import 'calendario_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArchivoController archivoController = ArchivoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel to JSON'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await archivoController.abrirExcel();
                    setState(() {});
                  },
                  child: const Text('Seleccionar archivo Excel'),
                ),
                const SizedBox(height: 20),
                archivoController.archivo != null
                    ? Text(archivoController.archivo!.files.single.name)
                    : const Text('No se ha seleccionado un archivo'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: archivoController.archivo == null
                      ? null
                      : () {
                          archivoController.leerExcel();
                          setState(() {});
                        },
                  child: const Text('Convertir a JSON'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: archivoController.archivo == null
                      ? null
                      : () {
                          archivoController.crearMapaHorarios();
                          setState(() {});
                        },
                  child: const Text('Crear Calendario'),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarioView(),
                      ),
                    );
                  },
                  child: const Text('Ver Calendario'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfesorView(),
                      ),
                    );
                  },
                  child: const Text('Ver Profesores'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
