part of models;

@JsonSerializable(explicitToJson: true)
class RecipeModel extends Model {
  RecipeModel({
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.time,
    required this.createdBy,
  });

  String name;
  String steps;
  String ingredients;
  String time;
  String createdBy;

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}
