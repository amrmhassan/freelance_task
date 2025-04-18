import 'package:dartz/dartz.dart';
import 'package:freelance_task/core/errors/failure.dart';
import 'package:freelance_task/features/products/domain/enities/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    List<String> categories = const [],
    required double minPrice,
    required double maxPrice,
  });
}
