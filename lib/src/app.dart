import 'package:flutter/material.dart';
import 'package:supabase_test/src/base/data.dart';
import 'package:supabase_test/src/components/auth/signin_page.dart';
import 'package:supabase_test/src/components/home/home_page.dart';

class SupabaseApp extends StatefulWidget {
  const SupabaseApp({Key? key}) : super(key: key);

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppData.init();
  }

  @override
  State<SupabaseApp> createState() => _SupabaseAppState();
}

class _SupabaseAppState extends State<SupabaseApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase',
      debugShowCheckedModeBanner: false,
      color: Colors.pink,
      theme: ThemeData(
        primaryColor: Colors.pink,
        useMaterial3: true,
      ),
      home: AppData.isLogin ? const HomePage() : const SignInPage(),
    );
  }
}
