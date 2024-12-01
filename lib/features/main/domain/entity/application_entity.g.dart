// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationEntity _$ApplicationEntityFromJson(Map<String, dynamic> json) =>
    ApplicationEntity(
      id: json['_id'] as String,
      title: json['title'] as String,
      status: $enumDecode(_$ApplicationStatusEnumMap, json['status']),
      description: json['description'] as String,
      amount: (json['amount'] as num).toInt(),
      collectedPercentage: (json['collectedPercentage'] as num?)?.toDouble(),
      collectedAmount: (json['collectedAmount'] as num?)?.toInt(),
      donorCount: (json['donorCount'] as num?)?.toInt(),
      userDonations: (json['userDonations'] as List<dynamic>?)
              ?.map((e) => DonationEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      urgent: json['urgent'] as bool,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      deadline: DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$ApplicationEntityToJson(ApplicationEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'status': _$ApplicationStatusEnumMap[instance.status]!,
      'description': instance.description,
      'amount': instance.amount,
      'collectedPercentage': instance.collectedPercentage,
      'collectedAmount': instance.collectedAmount,
      'donorCount': instance.donorCount,
      'urgent': instance.urgent,
      'images': instance.images,
      'deadline': instance.deadline.toIso8601String(),
      'userDonations': instance.userDonations,
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.inProgress: 'inProgress',
  ApplicationStatus.completed: 'completed',
};
