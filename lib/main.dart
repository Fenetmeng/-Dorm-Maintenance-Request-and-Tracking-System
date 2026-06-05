import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'core/routing/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    if (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }

  runApp(
    const ProviderScope(
      child: DormitoryApp(),
    ),
  );
}

class DormitoryApp extends StatelessWidget {
  const DormitoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DormFix',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}