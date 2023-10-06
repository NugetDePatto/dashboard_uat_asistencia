import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:dashboard_uat_asistencia/controllers/firestore_controller.dart';
import 'package:dashboard_uat_asistencia/utils/dialogo_reportes.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quick_notify/quick_notify.dart';

class EnVivoFaltasYReportes extends StatefulWidget {
  final String ciclo;
  const EnVivoFaltasYReportes({
    super.key,
    required this.ciclo,
  });

  @override
  EnVivoFaltasYReportesState createState() => EnVivoFaltasYReportesState();
}

class EnVivoFaltasYReportesState extends State<EnVivoFaltasYReportes> {
  bool saberIntervalo(String horarioProfesor) {
    String horarioActual =
        '${DateTime.now().hour}:00-${DateTime.now().hour + 1}:00';
    if (horarioActual == horarioProfesor) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'Faltantes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    'Reportes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    icon: const Icon(CommunityMaterialIcons.download),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      verdescargasReportes(context, widget.ciclo);
                    },
                    label: const Text('Descargar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: verProfesoresFaltantes(widget.ciclo),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data?.docs.length);
                    int reportesLocales = GetStorage().read('faltantes') ?? 0;

                    if (reportesLocales != snapshot.data?.docs.length) {
                      GetStorage()
                          .write('faltantes', snapshot.data?.docs.length);

                      QuickNotify.notify(
                        title: 'Profesores aún no llegan a clase',
                        content:
                            'Revisa la lista de profesores para ver más detalles',
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        var dispositivos = snapshot.data?.docs[index].data();
                        dispositivos?.remove('asistencia');
                        var llaves = dispositivos?.keys.toList();
                        print(llaves);
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dispositivos?[llaves?[0]]['titular']}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                dispositivos![llaves?[0]]['aula'],
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              for (var llave in llaves!)
                                Text(
                                  "${"$llave " + dispositivos[llave]['hora']} ${Timestamp(dispositivos[llave]['timeServer'].seconds, dispositivos[llave]['timeServer'].nanoseconds).toDate().toString().split(' ')[0]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),
                          // subtitle: Text(snapshot.data?.docs[index]['horario']),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: verReportes(widget.ciclo),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int reportesLocales = GetStorage().read('reportes') ?? 0;

                    if (reportesLocales != snapshot.data?.docs.length) {
                      GetStorage()
                          .write('reportes', snapshot.data?.docs.length);

                      QuickNotify.notify(
                        title: 'Tienes nuevos reportes',
                        content: 'Revisa la lista de reportes',
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        var id = index.toString();
                        var aux = id.split('_');
                        var salon = snapshot.data?.docs[index]['aula'];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 5,
                          ),
                          subtitle: Text(
                            snapshot.data?.docs[index]['titular'],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          title: Text(
                            (snapshot.data?.docs[index]['mensaje'] == ''
                                    ? 'Sin mensaje'
                                    : snapshot.data?.docs[index]['mensaje'])
                                .toString()
                                .toUpperCase()
                                .trim(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          trailing: Text(
                            '${snapshot.data?.docs[index]['fecha']}\n$salon',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
