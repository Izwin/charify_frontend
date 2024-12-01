import 'package:charify_front/features/main/domain/entity/application_entity.dart';

enum SingleApplicationStatus { initial, loading, success, error }

class SingleApplicationState {
  final SingleApplicationStatus status;
  final String? errorMessage;

  final ApplicationEntity? applicationEntity;

  SingleApplicationState._(
      {required this.status, this.errorMessage, this.applicationEntity});

  factory SingleApplicationState.initial() =>
      SingleApplicationState._(status: SingleApplicationStatus.initial);

  SingleApplicationState copyWith(
      {SingleApplicationStatus? status,
      String? errorMessage,
      ApplicationEntity? applicationEntity}) {
    return SingleApplicationState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        applicationEntity: applicationEntity ?? this.applicationEntity);
  }
}
