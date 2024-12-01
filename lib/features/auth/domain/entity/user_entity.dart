import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey(name: 'userId')
  final String id;
  final String email;
  final String displayName;
  final String photoURL;
  final int? totalDonated;
  final int? projectsSupported;

  UserEntity(
      {required this.id,
      required this.email,
      required this.displayName,
      required this.photoURL,
      this.totalDonated,
      this.projectsSupported});

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
