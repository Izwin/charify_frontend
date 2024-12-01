import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/main/data/datasource/category_remote_datasource.dart';
import 'package:charify_front/features/main/domain/entity/category_entity.dart';
import 'package:charify_front/features/main/domain/repository/category_repository.dart';
import 'package:dio/dio.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource categoryRemoteDatasource;

  CategoryRepositoryImpl({required this.categoryRemoteDatasource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      return Right(await categoryRemoteDatasource.getCategories());
    } on DioException catch (e) {
      return Left(CategoryFailure(errorMessage: e.response?.data['message']));
    }
  }
}
