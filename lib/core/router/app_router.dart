import 'package:charify_front/features/auth/presentation/page/auth_page.dart';
import 'package:charify_front/features/history/presentation/page/history_page.dart';
import 'package:charify_front/features/main/presentation/page/main_page.dart';
import 'package:charify_front/features/main/presentation/page/payment_page.dart';
import 'package:charify_front/features/main/presentation/page/single_application_page.dart';
import 'package:charify_front/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static var router = GoRouter(initialLocation: SplashPage.path,routes: [
    GoRoute(
        path: SplashPage.path,
        builder: (context, state) {
          return const SplashPage();
        }),
    GoRoute(
        path: AuthPage.path,
        builder: (context, state) {
          return const AuthPage();
        }),
    GoRoute(
        path: MainPage.path,
        builder: (context, state) {
          return const MainPage();
        }),
    GoRoute(path: '/application/:id',builder: (context,state){
      return SingleApplicationPage(applicationId: state.pathParameters['id'] ?? '',);
    }),
    GoRoute(path: '/payment/:id',builder: (context,state){
      return PaymentPage(applicationId: state.pathParameters['id'] ?? '',);
    }),
    GoRoute(path: HistoryPage.path,builder: (context,state){
      return const HistoryPage();
    })
  ]);
}
