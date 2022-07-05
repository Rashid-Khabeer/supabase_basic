import 'package:flutter/material.dart';
import 'package:supabase_test/src/app.dart';

void main() async {
  await SupabaseApp.init();
  runApp(const SupabaseApp());
}
