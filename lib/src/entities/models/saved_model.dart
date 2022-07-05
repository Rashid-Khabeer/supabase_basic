part of models;

@JsonSerializable(explicitToJson: true)
class SavedModel extends Model {
  SavedModel({
    required this.userId,
    required this.recipeId,
  });

  String userId;
  String recipeId;

  factory SavedModel.fromJson(Map<String, dynamic> json) =>
      _$SavedModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SavedModelToJson(this);
}
