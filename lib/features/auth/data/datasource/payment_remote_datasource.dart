import 'package:dio/dio.dart';

class PaymentRemoteDatasource{
  final Dio dio;

  PaymentRemoteDatasource({required this.dio});

  Future<String> requestPayment(double amount, String applicationId) async{
    var result = await dio.post('/payments/create-payment-intent',data: {
      'amount' : amount,
      'applicationId' : applicationId
    });
    return result.data['clientSecret'];
  }
}