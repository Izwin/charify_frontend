abstract class PaymentEvent{

}
class RequestPaymentEvent extends PaymentEvent{
  final double amount;
  final String applicationId;

  RequestPaymentEvent({required this.amount, required this.applicationId});
}