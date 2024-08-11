import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class JustificadoView extends StatefulWidget {
  const JustificadoView({super.key});

  @override
  State<JustificadoView> createState() => _JustificadoViewState();
}

class _JustificadoViewState extends State<JustificadoView> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController nombreProfesor = TextEditingController();
  List<QueryDocumentSnapshot> resultadosBusqueda = [];
  int profesorSeleccionado = -1;
  String fechaSeleccionada = 'dd/mm/aaaa';
  Timestamp? fechaSeleccionadaTimestamp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Justificar Falta de Asistencia',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Selecciona la fecha de la falta'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () async {
                        //selecciona la fecha de hoy en formato dd/mm/aaaa
                        final now = Timestamp.now();
                        final date = now.toDate();
                        fechaSeleccionadaTimestamp = now;
                        fechaSeleccionada =
                            '${date.day}/${date.month}/${date.year}';
                        setState(() {});
                      },
                      child: const Text('Agregar Hoy'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () async {
                        final DateTime? result =
                            await showMaterialDateTimePicker(
                          context: context,
                          mode: DateTimeFieldPickerMode.date,
                        );

                        if (result != null) {
                          final timestamp = Timestamp.fromDate(result);
                          fechaSeleccionadaTimestamp = timestamp;
                          fechaSeleccionada =
                              '${result.day}/${result.month}/${result.year}';
                          setState(() {});
                        }
                      },
                      child: const Text('Agregar fecha'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Fecha seleccionada: $fechaSeleccionada',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                const Text('Selecciona un profesor'),
                const SizedBox(height: 10),
                TextField(
                  controller: nombreProfesor,
                  decoration: const InputDecoration(
                    hintText: 'Nombre del profesor',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final nombre = nombreProfesor.text.trim();
                    profesorSeleccionado = -1;

                    print(nombre);
                    if (nombre.isNotEmpty) {
                      final querySnapshot = await firestore
                          .collection('ciclos')
                          .doc('TEST - 2023 - 3 Otoño')
                          .collection('profesores')
                          .get();

                      setState(() {
                        // Filtramos los resultados localmente
                        resultadosBusqueda = querySnapshot.docs.where((doc) {
                          print(doc.id);
                          final nombreDoc = doc.id.toLowerCase();
                          return nombreDoc
                              .contains(nombre); // Filtramos como un "LIKE"
                        }).toList();
                      });
                    }
                  },
                  child: const Text('Buscar'),
                ),
                const SizedBox(height: 20),
                if (resultadosBusqueda.isNotEmpty) ...[
                  const Text(
                    'Resultados de la búsqueda:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: resultadosBusqueda.length,
                    itemBuilder: (context, index) {
                      final doc = resultadosBusqueda[index];
                      return ListTile(
                        title: Text(doc.id),
                        onTap: () {
                          setState(() {
                            profesorSeleccionado = index;
                          });
                        },
                        tileColor: profesorSeleccionado == index
                            ? Colors.blue.withOpacity(0.2)
                            : null,
                      );
                    },
                  ),
                ],
                const SizedBox(height: 180),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          onPressed: () {
            if (profesorSeleccionado != -1 &&
                fechaSeleccionadaTimestamp != null) {
              final profesor = resultadosBusqueda[profesorSeleccionado];
              final idProfesor = profesor.id;
              const idCiclo = 'TEST - 2023 - 3 Otoño';

              // añade la falta justificada al profesor
              firestore
                  .collection('ciclos')
                  .doc(idCiclo)
                  .collection('profesores')
                  .doc(idProfesor)
                  .update(
                {
                  'faltas_justificadas':
                      FieldValue.arrayUnion([fechaSeleccionadaTimestamp])
                },
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Falta justificada correctamente'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selecciona un profesor y una fecha'),
                ),
              );
            }
          },
          child: const Icon(Icons.save, size: 40),
        ),
      ),
    );
  }
}
