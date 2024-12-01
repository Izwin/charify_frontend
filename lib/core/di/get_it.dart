import 'package:charify_front/core/api/api_client.dart';
import 'package:charify_front/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:charify_front/features/auth/data/datasource/payment_remote_datasource.dart';
import 'package:charify_front/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:charify_front/features/auth/data/repository/auth_repository_impl.dart';
import 'package:charify_front/features/auth/data/repository/payment_repository_impl.dart';
import 'package:charify_front/features/auth/data/repository/user_repository_impl.dart';
import 'package:charify_front/features/auth/domain/repository/auth_repository.dart';
import 'package:charify_front/features/auth/domain/repository/user_repository.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_bloc.dart';
import 'package:charify_front/features/history/data/datasource/history_remote_datasource.dart';
import 'package:charify_front/features/history/data/repository/history_repository_impl.dart';
import 'package:charify_front/features/history/domain/repository/history_repository.dart';
import 'package:charify_front/features/history/presentation/bloc/history_bloc.dart';
import 'package:charify_front/features/main/data/datasource/application_remote_datasource.dart';
import 'package:charify_front/features/main/data/datasource/category_remote_datasource.dart';
import 'package:charify_front/features/main/data/repository/application_repository_impl.dart';
import 'package:charify_front/features/main/data/repository/category_repository_impl.dart';
import 'package:charify_front/features/main/data/repository/payment_repository.dart';
import 'package:charify_front/features/main/domain/repository/application_repository.dart';
import 'package:charify_front/features/main/domain/repository/category_repository.dart';
import 'package:charify_front/features/main/presentation/bloc/main_bloc.dart';
import 'package:charify_front/features/main/presentation/bloc/payment_bloc.dart';
import 'package:charify_front/features/main/presentation/bloc/single_application_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

var getIt = GetIt.instance;

void setup() {
  initStripe();

  registerGoogleSignIn();
  registerApiClient();
  registerDatasources();
  registerRepositories();
  registerBloc();
}

void initStripe() {
  Stripe.publishableKey =
      'pk_test_51QN06FG19Ph4QwWEqWHCSkRXRgsAQKjw8mzjSqRcEkXJ6sRm2eV71KGBzmLbhOkHqDNWV8R4kI6TpS5E7GAdXD7300Ys8kJ381';
}

void registerGoogleSignIn() {
  getIt.registerSingleton(GoogleSignIn());
}

void registerApiClient() {
  getIt.registerSingleton(ApiClient());
}

void registerDatasources() {
  var dio = getIt<ApiClient>().getDio();
  var dioTokenInterceptor = getIt<ApiClient>().getDio(tokenInterceptor: true);
  getIt.registerSingleton(AuthRemoteDatasource(dio: dio));
  getIt.registerSingleton(UserRemoteDatasource(dio: dioTokenInterceptor));
  getIt.registerSingleton(CategoryRemoteDatasource(dio: dioTokenInterceptor));
  getIt
      .registerSingleton(ApplicationRemoteDatasource(dio: dioTokenInterceptor));
  getIt.registerSingleton(PaymentRemoteDatasource(dio: dioTokenInterceptor));
  getIt.registerSingleton(HistoryRemoteDatasource(dio: dioTokenInterceptor));
}

void registerRepositories() {
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(authRemoteDatasource: getIt(), googleSignIn: getIt()));
  getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(userRemoteDatasource: getIt()));
  getIt.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl(categoryRemoteDatasource: getIt()));
  getIt.registerSingleton<ApplicationRepository>(
      ApplicationRepositoryImpl(applicationRemoteDatasource: getIt()));
  getIt.registerSingleton<PaymentRepository>(
      PaymentRepositoryImpl(paymentRemoteDatasource: getIt()));
  getIt.registerSingleton<HistoryRepository>(
      HistoryRepositoryImpl(historyRemoteDatasource: getIt()));
}

void registerBloc() {
  getIt.registerFactory(
      () => UserBloc(authRepository: getIt(), userRepository: getIt()));

  getIt.registerFactory(() =>
      MainBloc(categoryRepository: getIt(), applicationRepository: getIt()));

  getIt.registerFactory(
      () => SingleApplicationBloc(applicationRepository: getIt()));

  getIt.registerFactory(() => PaymentBloc(paymentRepository: getIt()));

  getIt.registerFactory(() => HistoryBloc(historyRepository: getIt()));
}
