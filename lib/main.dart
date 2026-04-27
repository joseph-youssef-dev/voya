import 'package:flutter/material.dart';
import 'package:voya/app/app_root.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper().init();
  // Session persistence enabled



  runApp(const Voya());
}

class Voya extends StatelessWidget {
  const Voya({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: SafeArea(child: const AppRoot()),
    );
  }
}
