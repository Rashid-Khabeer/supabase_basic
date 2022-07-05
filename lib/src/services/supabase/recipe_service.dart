part of supabase_service;

class RecipeService extends SupabaseService<RecipeModel> {
  @override
  RecipeModel parseModel(Map<String, dynamic> document) {
    return RecipeModel.fromJson(document);
  }

  @override
  String get tableName => 'recipes';
}
