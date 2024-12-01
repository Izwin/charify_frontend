import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository{
  Future<Either<Failure,UserEntity>> signInWithGoogle();
  Future<Either<Failure,void>> logOut();
}