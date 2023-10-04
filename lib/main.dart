import 'package:artify/screens/signup_page.dart';
import 'package:artify/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://dhtvydpeepyrtnigfoin.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRodHZ5ZHBlZXB5cnRuaWdmb2luIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQ4MTQwOTgsImV4cCI6MjAxMDM5MDA5OH0.xgyFDxRkm4yISrmXPGPr3qThQF8uCEMqDf_SXaQvTvo',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: const SplashScreen(),
    );
  }
}
