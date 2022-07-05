import 'package:flutter/material.dart';
import 'package:supabase_test/src/components/auth/signin_page.dart';
import 'package:supabase_test/src/components/home/add_page.dart';
import 'package:supabase_test/src/components/home/saved_page.dart';
import 'package:supabase_test/src/components/simple_stream_builder.dart';
import 'package:supabase_test/src/entities/model.dart';
import 'package:supabase_test/src/services/auth_service.dart';
import 'package:supabase_test/src/services/supabase_service.dart';
import 'package:supabase_test/src/utils/app_context.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
            onPressed: () => context.to(const SavedPage()),
            child: const Icon(Icons.favorite),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.signOut();
              if (!mounted) return;
              context.navigateRemoveUntil(const SignInPage());
            },
            child: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SimpleStreamBuilder<List<RecipeModel>>.simpler(
        stream: RecipeService().fetchAllStream(),
        context: context,
        builder: (data) {
          return ListView.builder(
            itemBuilder: (ctx, i) {
              final item = data[i];
              return Column(
                children: [
                  Text(item.name),
                ],
              );
            },
            itemCount: data.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.to(const AddPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
