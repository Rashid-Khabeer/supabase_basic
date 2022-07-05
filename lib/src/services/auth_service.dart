import 'package:supabase/supabase.dart';
import 'package:supabase_test/src/base/data.dart';
import 'package:supabase_test/src/utils/supabase_manager.dart';

abstract class AuthService {
  AuthService._();

  static Future<User> signInWithEmail(String email, String password) async {
    try {
      final result = await SupabaseManager.client.auth.signIn(
        email: email,
        password: password,
      );
      if (result.error != null) {
        throw result.error!.message;
      }
      if (result.user == null) {
        throw 'User not found';
      }
      await AppData.insertId(result.user!.id);
      return result.user!;
    } catch (_) {
      rethrow;
    }
  }

  static Future<User> signupWithEmail(String email, String password) async {
    try {
      final result = await SupabaseManager.client.auth.signUp(
        email,
        password,
      );
      if (result.error != null) {
        throw result.error!.message;
      }
      if (result.user == null) {
        throw 'User did not create';
      }
      return await signInWithEmail(email, password);
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await SupabaseManager.client.auth.signOut();
  }
}
