import 'package:supabase/supabase.dart';

abstract class SupabaseManager {
  SupabaseManager._();

  static const _url = '';
  static const _key = '';

  static final _client = SupabaseClient(_url, _key);

  static SupabaseClient get client => _client;
}
