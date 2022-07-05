import 'package:flutter/material.dart';
import 'package:supabase_test/src/base/const.dart';
import 'package:supabase_test/src/base/modals/error_dialog.dart';
import 'package:supabase_test/src/base/modals/loading_dialog.dart';
import 'package:supabase_test/src/components/auth/signup_page.dart';
import 'package:supabase_test/src/components/home/home_page.dart';
import 'package:supabase_test/src/services/auth_service.dart';
import 'package:supabase_test/src/utils/app_context.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextFormField(
            controller: _email,
            decoration: kInputDecoration.copyWith(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _password,
            decoration: kInputDecoration.copyWith(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _signIn,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('SignIn'),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              context.to(const SignUpPage());
            },
            child: const Text('Sign up'),
          )
        ]),
      ),
    );
  }

  void _signIn() async {
    const LoadingDialog().show(context);
    try {
      await AuthService.signInWithEmail(
        _email.text,
        _password.text,
      );
      if (!mounted) return;
      context.showSnackBar('Logged In successfully');
      context.navigateRemoveUntil(const HomePage());
    } catch (e) {
      context.pop();
      ErrorDialog(e.toString()).show(context);
    }
  }
}
