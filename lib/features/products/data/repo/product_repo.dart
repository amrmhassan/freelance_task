import 'package:dartz/dartz.dart';
import 'package:freelance_task/core/errors/failure.dart';
import 'package:freelance_task/features/products/data/models/product_model.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<ProductModel>>> getProducts({
    List<String> categories = const [],
    double minPrice = 0,
    double maxPrice = double.infinity,
  });
}
