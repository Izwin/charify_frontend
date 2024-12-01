import 'package:charify_front/features/auth/domain/entity/user_entity.dart';

enum UserStatus { initial, loading, success, error, logOut }

class UserState {
  final UserStatus status;
  final String? errorMessage;
  final UserEntity? userEntity;

  UserState._({required this.status, this.errorMessage, this.userEntity});

  factory UserState.initial() => UserState._(status: UserStatus.initial);

  UserState copyWith(
      {UserStatus? status, String? errorMessage, UserEntity? userEntity}) {
    return UserState._(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        userEntity: userEntity ?? this.userEntity);
  }
}
