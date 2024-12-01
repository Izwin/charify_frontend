import 'package:charify_front/core/utils/map_utils.dart';
import 'package:charify_front/features/main/domain/entity/application_entity.dart';
import 'package:dio/dio.dart';

class ApplicationRemoteDatasource {
  final Dio dio;

  ApplicationRemoteDatasource({required this.dio});

  Future<List<ApplicationEntity>> getApplications({
    int? page,
    int? limit,
    String? categoryId,
    bool? isUrgent,
    String? search,
  }) async {
    var result = await dio.get('applications/', queryParameters: {
      'page': page,
      'limit': limit,
      'category': categoryId,
      'urgent': isUrgent,
      'search': search
    }.withoutNulls());
    return (result.data['applications'] as List)
        .map((e) => ApplicationEntity.fromJson(e))
        .toList();
  }

  Future<ApplicationEntity> getApplicationById(String applicationId) async {
    var result = await dio.get('/applications/$applicationId');
    return ApplicationEntity.fromJson(result.data);
  }
}
