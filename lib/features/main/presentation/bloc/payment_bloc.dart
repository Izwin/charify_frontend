
import 'package:charify_front/features/main/data/repository/payment_repository.dart';
import 'package:charify_front/features/main/presentation/bloc/payment_event.dart';
import 'package:charify_front/features/main/presentation/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc({required this.paymentRepository})
      : super(PaymentState.initial()) {
    on<RequestPaymentEvent>(onRequestPaymentEvent);
  }

  void onRequestPaymentEvent(
      RequestPaymentEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    var result = await paymentRepository.requestPayment(
        event.amount, event.applicationId);
    await result.fold((l){
      emit(state.copyWith(status: PaymentStatus.error,errorMessage: l.errorMessage));
    }, (r)async{
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: r,
        merchantDisplayName: 'Charify'
      ));
      try{
        await Stripe.instance.presentPaymentSheet();
        emit(state.copyWith(status: PaymentStatus.successfullyMadePayment,));
      }
      catch (e){
        emit(state.copyWith(status: PaymentStatus.error,errorMessage: 'Payment Failure'));
      }
    });
  }
}
