import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:charify_front/features/auth/domain/entity/user_entity.dart';
import 'package:charify_front/features/auth/domain/repository/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository{
  final UserRemoteDatasource userRemoteDatasource;

  UserRepositoryImpl({required this.userRemoteDatasource});
  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try{
      return Right(await userRemoteDatasource.getUser());
    }
    on DioException catch (e){
      return Left(AuthFailure(errorMessage: e.response?.data['message']));
    }
  }

}