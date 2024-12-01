// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonationEntity _$DonationEntityFromJson(Map<String, dynamic> json) =>
    DonationEntity(
      id: json['_id'] as String,
      application: json['application'] == null
          ? null
          : ApplicationEntity.fromJson(
              json['application'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      commission: (json['commission'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$DonationEntityToJson(DonationEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'application': instance.application,
      'date': instance.date.toIso8601String(),
      'commission': instance.commission,
      'totalAmount': instance.totalAmount,
      'amount': instance.amount,
    };
