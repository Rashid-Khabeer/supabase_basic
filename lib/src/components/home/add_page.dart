import 'package:flutter/material.dart';
import 'package:supabase_test/src/base/const.dart';
import 'package:supabase_test/src/base/data.dart';
import 'package:supabase_test/src/base/modals/error_dialog.dart';
import 'package:supabase_test/src/base/modals/loading_dialog.dart';
import 'package:supabase_test/src/entities/model.dart';
import 'package:supabase_test/src/services/supabase_service.dart';
import 'package:supabase_test/src/utils/app_context.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late RecipeModel _model;

  @override
  void initState() {
    super.initState();
    _model = RecipeModel(
      name: '',
      ingredients: '',
      steps: '',
      time: '',
      createdBy: AppData.id,
    )..id = DateTime.now().toIso8601String();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextFormField(
            onChanged: (value) => _model.name = value,
            initialValue: _model.name,
            decoration: kInputDecoration.copyWith(
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: (value) => _model.steps = value,
            initialValue: _model.steps,
            decoration: kInputDecoration.copyWith(
              labelText: 'Steps',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: (value) => _model.ingredients = value,
            initialValue: _model.ingredients,
            decoration: kInputDecoration.copyWith(
              labelText: 'Ingredients',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onChanged: (value) => _model.time = value,
            initialValue: _model.time,
            decoration: kInputDecoration.copyWith(
              labelText: 'Time',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _add,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Add'),
          ),
        ]),
      ),
    );
  }

  void _add() async {
    try {
      const LoadingDialog().show(context);
      await RecipeService().insert(_model);
      if (!mounted) return;
      context.showSnackBar('Recipe added!');
      context.pop();
      context.pop();
    } catch (e) {
      context.pop();
      ErrorDialog(e.toString()).show(context);
    }
  }
}
