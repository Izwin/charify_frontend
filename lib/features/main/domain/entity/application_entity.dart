import 'package:charify_front/features/main/domain/entity/donation_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'application_entity.g.dart';

enum ApplicationStatus {
  inProgress,
  completed,
}

@JsonSerializable()
class ApplicationEntity extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final ApplicationStatus status;
  final String description;
  final int amount;
  final double? collectedPercentage;
  final int? collectedAmount;
  final int? donorCount;
  final bool urgent;
  @JsonKey(defaultValue: [])
  final List<String> images;
  final DateTime deadline;

  @JsonKey(defaultValue: [])
  final List<DonationEntity> userDonations;

  const ApplicationEntity(
      {required this.id,
      required this.title,
      required this.status,
      required this.description,
      required this.amount,
      this.collectedPercentage,
      this.collectedAmount,
      this.donorCount,
        required this.userDonations,
      required this.urgent,
      required this.images,
      required this.deadline});

  Map<String, dynamic> toJson() => _$ApplicationEntityToJson(this);

  factory ApplicationEntity.fromJson(Map<String, dynamic> json) =>
      _$ApplicationEntityFromJson(json);

  @override
  List<Object?> get props => [
        id,
        title,
        status,
        description,
        amount,
        collectedPercentage,
        collectedAmount,
        donorCount,
        urgent,
        images,
        deadline
      ];
}
