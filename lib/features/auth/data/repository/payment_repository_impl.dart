import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/auth/data/datasource/payment_remote_datasource.dart';
import 'package:charify_front/features/main/data/repository/payment_repository.dart';
import 'package:dio/dio.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDatasource paymentRemoteDatasource;

  PaymentRepositoryImpl({required this.paymentRemoteDatasource});

  @override
  Future<Either<Failure, String>> requestPayment(
      double amount, String applicationId) async {
    try{
      return Right(await paymentRemoteDatasource.requestPayment(amount, applicationId));
    }
    on DioException catch (e){
      return Left(PaymentFailure(errorMessage: e.response?.data['message']));
    }
  }
}
