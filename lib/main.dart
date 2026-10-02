import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordapp/models/password_data.dart';
import 'package:passwordapp/pages/acount_management.dart';
import './pages/acountspage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PasswordDataAdapter());
  var box = await Hive.openBox<PasswordData>("Mybox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Generator',
      routes: {
        '/': (context) => const Acountspage(),
        AcountManagement.route: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as AcountManagementMode;

          return AcountManagement(mode: args);
        },
      },
    );
  }
}
