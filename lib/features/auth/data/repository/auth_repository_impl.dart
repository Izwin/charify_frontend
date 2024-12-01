import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:charify_front/features/auth/domain/entity/user_entity.dart';
import 'package:charify_front/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final GoogleSignIn googleSignIn;

  AuthRepositoryImpl(
      {required this.authRemoteDatasource, required this.googleSignIn});

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final firebaseCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final token = await firebaseCredentials.user?.getIdToken();

      if (token != null) {
        return Right(await authRemoteDatasource.signInWithGoogle(token));
      } else {
        return Left(AuthFailure(errorMessage: 'Auth failure'));
      }
    } on DioException catch (e) {
      return Left(AuthFailure(errorMessage: e.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try{
      await FirebaseAuth.instance.signOut();
      return Right(null);
    }
    catch (e){
      return Left(AuthFailure(errorMessage: 'Logout Failure'));
    }
  }
}
