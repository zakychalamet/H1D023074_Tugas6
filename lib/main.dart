import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/form_data.dart';
import 'package:flutter_application_1/ui/tampil_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H1D023074_Tugas 6',
      home: const FormData(),
      routes: {
        '/form-data': (context) => const FormData(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/tampil-data' && settings.arguments is Map) {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
            builder: (context) => TampilData(
              nama: args['nama'] as String,
              nim: args['nim'] as String,
              tahunLahir: args['tahunLahir'] as int,
            ),
          );
        }
        return null;
      },
    );
  }
}
