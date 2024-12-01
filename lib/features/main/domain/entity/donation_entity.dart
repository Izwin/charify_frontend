import 'package:charify_front/features/main/domain/entity/application_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'donation_entity.g.dart';

@JsonSerializable()
class DonationEntity {
  @JsonKey(name: '_id')
  final String id;
  final ApplicationEntity? application;
  final DateTime date;
  final double commission;
  final double totalAmount;
  final double amount;

  DonationEntity(
      {required this.id,
      this.application,
      required this.date,
      required this.commission,
      required this.totalAmount,
      required this.amount});

  Map<String, dynamic> toJson() => _$DonationEntityToJson(this);

  factory DonationEntity.fromJson(Map<String, dynamic> json) =>
      _$DonationEntityFromJson(json);
}
