import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(const MiniMarketApp());
}

class MiniMarketApp extends StatelessWidget {
  const MiniMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mini Market',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }
}
