enum PaymentStatus { initial, loading, successfullyMadePayment, error }

class PaymentState {
  final PaymentStatus status;
  final String? errorMessage;

  PaymentState._({required this.status, this.errorMessage});

  factory PaymentState.initial() =>
      PaymentState._(status: PaymentStatus.initial);

  PaymentState copyWith({PaymentStatus? status, String? errorMessage}) =>
      PaymentState._(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage);
}
