import 'package:charify_front/core/model/either.dart';
import 'package:charify_front/core/model/failure.dart';
import 'package:charify_front/features/main/domain/entity/category_entity.dart';

abstract class CategoryRepository{
  Future<Either<Failure,List<CategoryEntity>>> getCategories();
}