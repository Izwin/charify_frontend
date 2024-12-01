import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/history/data/datasource/history_remote_datasource.dart';
import 'package:charify_front/features/history/domain/repository/history_repository.dart';
import 'package:charify_front/features/main/domain/entity/donation_entity.dart';
import 'package:dio/dio.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDatasource historyRemoteDatasource;

  HistoryRepositoryImpl({required this.historyRemoteDatasource});

  @override
  Future<Either<Failure, List<DonationEntity>>> getDonations(
      {int? page, int? limit}) async {
    try {
      return Right(
          await historyRemoteDatasource.getDonations(page: page, limit: limit));
    } on DioException catch (e) {
      return Left(DonationFailure(errorMessage: e.response?.data['message']));
    }
  }
}
