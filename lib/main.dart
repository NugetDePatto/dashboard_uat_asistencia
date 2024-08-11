import 'package:dashboard_uat_asistencia/firebase_options.dart';
import 'package:dashboard_uat_asistencia/views/dia_inhabil_view.dart';
import 'package:dashboard_uat_asistencia/views/home_page.dart';
import 'package:dashboard_uat_asistencia/views/justificado_view.dart';
import 'package:dashboard_uat_asistencia/views/ver_en_vivo_faltas_reportes_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';

import 'package:quick_notify/quick_notify.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  var hasPermission = await QuickNotify.hasPermission();
  var requestPermission = await QuickNotify.requestPermission();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: JustificadoView(),
      // home: const EnVivoFaltasYReportes(ciclo: 'TEST - 2023 - 3 Otoño'),
    );
  }
}
