import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/auth/domain/entity/user_entity.dart';

abstract class UserRepository{
  Future<Either<Failure,UserEntity>> getUser();
}