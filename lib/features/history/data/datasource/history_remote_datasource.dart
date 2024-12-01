import 'package:charify_front/features/main/domain/entity/donation_entity.dart';
import 'package:dio/dio.dart';

class HistoryRemoteDatasource {
  final Dio dio;

  HistoryRemoteDatasource({required this.dio});

  Future<List<DonationEntity>> getDonations({int? page, int? limit}) async {
    var result = await dio.get('/donations/');
    return (result.data['donations'] as List)
        .map((e) => DonationEntity.fromJson(e))
        .toList();
  }
}
