import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//10922-CHAVIRA JUAREZ GABRIEL

class DiaInhabilView extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String ciclo;
  DiaInhabilView({
    super.key,
    this.ciclo = 'TEST - 2023 - 3 Otoño',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Días Inhábiles',
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
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Text(
                    'Administra los días inhábiles del ciclo escolar seleccionando las fechas '
                    'en las que no habrá actividades académicas. Estos días se añadirán a la '
                    'lista de días inhábiles para asegurar que no se consideren como días '
                    'de asistencia. Puedes agregar tantas fechas como necesites y '
                    'eliminarlas si es necesario.',
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                        final doc = await firestore
                            .collection('ciclos')
                            .doc(ciclo)
                            .get();

                        if (!doc.exists) {
                          await firestore.collection('ciclos').doc(ciclo).set({
                            'dias_inhabiles': [Timestamp.now()],
                          });
                        } else {
                          //si ya existe no lo agregues
                          final List<Timestamp> diasInhabiles =
                              List<Timestamp>.from(
                            doc.get('dias_inhabiles'),
                          );
                          if (!diasInhabiles.contains(Timestamp.now())) {
                            await firestore
                                .collection('ciclos')
                                .doc(ciclo)
                                .update({
                              'dias_inhabiles':
                                  FieldValue.arrayUnion([Timestamp.now()]),
                            });
                          }
                        }
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

                        //revisa si existe el ciclo
                        final doc = await firestore
                            .collection('ciclos')
                            .doc(ciclo)
                            .get();
                        if (!doc.exists) {
                          await firestore.collection('ciclos').doc(ciclo).set({
                            'dias_inhabiles': [result],
                          });
                        } else {
                          await firestore
                              .collection('ciclos')
                              .doc(ciclo)
                              .update({
                            'dias_inhabiles': FieldValue.arrayUnion([result]),
                          });
                        }
                      },
                      child: const Text('Agregar fecha'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                //lee los dias inhabiles del ciclo escolar
                StreamBuilder<DocumentSnapshot>(
                  stream: firestore.collection('ciclos').doc(ciclo).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.exists == false) {
                        return const Text('No hay días inhabiles');
                      }
                      final List<Timestamp> diasInhabiles =
                          List<Timestamp>.from(
                        snapshot.data?.get('dias_inhabiles'),
                      );

                      //ordenalo de fecha mas reciente a fecha mas antigua
                      diasInhabiles.sort((a, b) => b.compareTo(a));
                      return Column(
                        children: diasInhabiles
                            .map(
                              (e) => ListTile(
                                //conviertlo el timestamp a DateTime
                                title: Text(
                                  '${e.toDate().day} (${
                                  //pon el nombre del dia
                                  const [
                                    'Lunes',
                                    'Martes',
                                    'Miércoles',
                                    'Jueves',
                                    'Viernes',
                                    'Sábado',
                                    'Domingo',
                                  ][e.toDate().weekday - 1]}) / ${e.toDate().month} (${
                                  //pon el nombre del mes
                                  const [
                                    'Enero',
                                    'Febrero',
                                    'Marzo',
                                    'Abril',
                                    'Mayo',
                                    'Junio',
                                    'Julio',
                                    'Agosto',
                                    'Septiembre',
                                    'Octubre',
                                    'Noviembre',
                                    'Diciembre',
                                  ][e.toDate().month - 1]}) / ${e.toDate().year}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await firestore
                                        .collection('ciclos')
                                        .doc(ciclo)
                                        .update({
                                      'dias_inhabiles':
                                          FieldValue.arrayRemove([e]),
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
