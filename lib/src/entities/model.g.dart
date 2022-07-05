// GENERATED CODE - DO NOT MODIFY BY HAND

part of models;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
      name: json['name'] as String,
      ingredients: json['ingredients'] as String,
      steps: json['steps'] as String,
      time: json['time'] as String,
      createdBy: json['createdBy'] as String,
    )..id = json['id'] as String?;

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'steps': instance.steps,
      'ingredients': instance.ingredients,
      'time': instance.time,
      'createdBy': instance.createdBy,
    };

SavedModel _$SavedModelFromJson(Map<String, dynamic> json) => SavedModel(
      userId: json['userId'] as String,
      recipeId: json['recipeId'] as String,
    )..id = json['id'] as String?;

Map<String, dynamic> _$SavedModelToJson(SavedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'recipeId': instance.recipeId,
    };
