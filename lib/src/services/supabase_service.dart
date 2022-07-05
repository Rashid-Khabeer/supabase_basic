library supabase_service;

import 'dart:developer';
import 'package:supabase/supabase.dart';
import 'package:supabase_test/src/entities/model.dart';
import 'package:supabase_test/src/utils/supabase_manager.dart';

part 'supabase/recipe_service.dart';

abstract class SupabaseService<T extends Model> {
  String get tableName;

  T parseModel(Map<String, dynamic> document);

  Future<void> insert(T model) async {
    try {
      final insertResponse = await SupabaseManager.client
          .from(tableName)
          .insert(model.toJson())
          .execute();
      if (insertResponse.error != null) {
        throw insertResponse.error!.message;
      }
      log('insertResponse.data: ${insertResponse.data}');
    } catch (_) {
      rethrow;
    }
  }

  Future<void> update(T model) async {
    try {
      final updateResponse = await SupabaseManager.client
          .from(tableName)
          .update(model.toJson())
          .eq('id', model.id)
          .execute();
      if (updateResponse.error != null) {
        throw updateResponse.error!.message;
      }
      log('updateResponse.data: ${updateResponse.data}');
    } catch (_) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      final deleteResponse = await SupabaseManager.client
          .from(tableName)
          .delete()
          .eq('id', id)
          .execute();
      if (deleteResponse.error != null) {
        throw deleteResponse.error!.message;
      }
      log('deleteResponse.data: ${deleteResponse.data}');
    } catch (_) {
      rethrow;
    }
  }

  Future<List<T>> fetchAll() async {
    try {
      final selectResponse = await SupabaseManager.client
          .from(tableName)
          .select()
          .execute(count: CountOption.exact);
      if (selectResponse.error != null) {
        throw selectResponse.error!.message;
      }
      return selectResponse.data.map<T>((e) {
        return parseModel(e);
      }).toList();
    } catch (_) {
      rethrow;
    }
  }

  Stream<List<T>> fetchAllStream() async* {
    try {
      final result = SupabaseManager.client
          .from(tableName)
          .stream(['id'])
          .order('createdAt')
          .execute()
          .asBroadcastStream();
      await for (final item in result) {
        yield item.map<T>((e) => parseModel(e)).toList();
      }
    } catch (_) {
      rethrow;
    }
  }
}
