import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/main/domain/entity/donation_entity.dart';

abstract class HistoryRepository {
  Future<Either<Failure, List<DonationEntity>>> getDonations(
      {int? page, int? limit});
}
