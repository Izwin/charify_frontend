import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';

abstract class PaymentRepository{
  Future<Either<Failure,String>> requestPayment(double amount, String applicationId);
}