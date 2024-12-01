import 'package:charify_front/core/di/get_it.dart';
import 'package:charify_front/core/router/app_router.dart';
import 'package:charify_front/core/theme/app_theme.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_bloc.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_event.dart';
import 'package:charify_front/features/auth/presentation/bloc/user_state.dart';
import 'package:charify_front/features/auth/presentation/page/auth_page.dart';
import 'package:charify_front/features/history/presentation/bloc/history_bloc.dart';
import 'package:charify_front/features/history/presentation/bloc/history_event.dart';
import 'package:charify_front/features/main/presentation/bloc/main_bloc.dart';
import 'package:charify_front/features/main/presentation/bloc/payment_bloc.dart';
import 'package:charify_front/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) =>
        getIt<UserBloc>()
          ..add(GetUserEvent()),
      ),
      BlocProvider(
        create: (context) => getIt<MainBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt<PaymentBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt<HistoryBloc>()..add(LoadDonationsEvent(refresh: true)),
      ),
    ],
    child: MaterialApp.router(
      routerConfig: AppRouter.router,
      builder: (context, widget) {
        return BlocListener<UserBloc, UserState>(listener: (context, state) {
          if (state.status == UserStatus.error ||
              state.status == UserStatus.logOut) {
            AppRouter.router.go(AuthPage.path);
          }
        }, child: widget,);
      },
      theme: AppTheme.getTheme(),
    ),
  ));
}
