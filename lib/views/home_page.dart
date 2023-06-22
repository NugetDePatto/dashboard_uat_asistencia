import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_uat_asistencia/controllers/archivo_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArchivoController archivoController = ArchivoController();
  Map<String, dynamic> test = {
    'nombre': 'test',
    'algo': [
      {'a': 'a'},
      {'b': 'b'},
    ],
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel to JSON'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                  child: const Text('Cargar Ciclo 2023'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: archivoController.profesoresMapa.isEmpty
                      ? null
                      : () async {
                          var ref = FirebaseDatabase.instance.ref('ciclo2023');
                          test = archivoController.profesoresMapa;
                          await ref.set({
                            'profesores': test,
                          });
                        },
                  child: const Text('Prueba01'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
