import 'package:flutter/material.dart';
import 'package:supabase_test/src/base/const.dart';
import 'package:supabase_test/src/base/modals/error_dialog.dart';
import 'package:supabase_test/src/base/modals/loading_dialog.dart';
import 'package:supabase_test/src/components/home/home_page.dart';
import 'package:supabase_test/src/services/auth_service.dart';
import 'package:supabase_test/src/utils/app_context.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
            onPressed: _signUp,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('SignUp'),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: context.pop,
            child: const Text('Sign In'),
          )
        ]),
      ),
    );
  }

  void _signUp() async {
    const LoadingDialog().show(context);
    try {
      await AuthService.signupWithEmail(
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
