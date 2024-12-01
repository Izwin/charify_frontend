abstract class Failure{
  final String errorMessage;

  Failure({required this.errorMessage});
}

class AuthFailure extends Failure{
  AuthFailure({required super.errorMessage});

}

class CategoryFailure extends Failure{
  CategoryFailure({required super.errorMessage});

}
class ApplicationFailure extends Failure{
  ApplicationFailure({required super.errorMessage});
}
class PaymentFailure extends Failure{
  PaymentFailure({required super.errorMessage});
}
class DonationFailure extends Failure{
  DonationFailure({required super.errorMessage});
}