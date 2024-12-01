import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/main/data/datasource/application_remote_datasource.dart';
import 'package:charify_front/features/main/domain/entity/application_entity.dart';
import 'package:charify_front/features/main/domain/repository/application_repository.dart';
import 'package:dio/dio.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDatasource applicationRemoteDatasource;

  ApplicationRepositoryImpl({required this.applicationRemoteDatasource});

  @override
  Future<Either<Failure, List<ApplicationEntity>>> getApplications(
      {int? page,
      int? limit,
      String? categoryId,
      bool? isUrgent,
      String? search}) async {
    try {
      return Right(await applicationRemoteDatasource.getApplications(
        page: page,
        limit: limit,
        categoryId: categoryId,
        isUrgent: isUrgent,
        search: search,
      ));
    } on DioException catch (e) {
      return Left(
          ApplicationFailure(errorMessage: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, ApplicationEntity>> getApplicationById(
      String applicationId) async {
    try {
      return Right(
          await applicationRemoteDatasource.getApplicationById(applicationId));
    } on DioException catch (e) {
      return Left(
          ApplicationFailure(errorMessage: e.response?.data['message']));
    }
  }
}
