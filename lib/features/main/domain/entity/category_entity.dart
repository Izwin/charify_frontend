import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String description;

  const CategoryEntity(
      {required this.id, required this.name, required this.description});

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  @override
  List<Object?> get props => [id, name, description];
}
