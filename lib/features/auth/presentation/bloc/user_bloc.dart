
import 'package:charify_front/features/auth/domain/repository/auth_repository.dart';
import 'package:charify_front/features/auth/domain/repository/user_repository.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_event.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  UserBloc({required this.authRepository,required this.userRepository}) : super(UserState.initial()) {
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<GetUserEvent>(onGetUserEvent);
    on<LogoutEvent>(onLogoutEvent);
  }

  void onSignInWithGoogleEvent(
      SignInWithGoogleEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await authRepository.signInWithGoogle();
    result.fold((l) {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(status: UserStatus.success, userEntity: r));
    });
  }

  void onGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await userRepository.getUser();
    result.fold((l) {
      emit(state.copyWith(
          status: UserStatus.error, errorMessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(status: UserStatus.success, userEntity: r));
    });
  }

  void onLogoutEvent(LogoutEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await authRepository.logOut();
    result.fold((l) {
      emit(state.copyWith(status: UserStatus.error,errorMessage: l.errorMessage));
    }, (r){
      emit(state.copyWith(status: UserStatus.logOut));
    });
  }
}
