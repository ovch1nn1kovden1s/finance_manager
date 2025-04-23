import 'package:flutter/material.dart';
import 'presentation/app_router.dart';
import 'data/db/hive_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initHive();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}