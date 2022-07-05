library models;

import 'package:json_annotation/json_annotation.dart';

part 'models/recipe_model.dart';

part 'models/saved_model.dart';

part 'model.g.dart';

abstract class Model {
  String? id;

  Model({this.id});

  Map<String, dynamic> toJson();

  Model.fromJson(Map<String, dynamic> json);
}
