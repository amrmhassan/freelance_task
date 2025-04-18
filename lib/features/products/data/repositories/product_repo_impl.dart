import 'package:dartz/dartz.dart';
import 'package:freelance_task/core/errors/failure.dart';
import 'package:freelance_task/features/products/data/datasources/products_datasource.dart';
import 'package:freelance_task/features/products/domain/entities/product_entity.dart';
import 'package:freelance_task/features/products/domain/repositories/product_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductsDatasource datasource;
  final InternetConnectionChecker _connectionChecker;

  ProductRepoImpl(this.datasource)
    : _connectionChecker = InternetConnectionChecker.instance;

  Future<bool> get _hasConnection => _connectionChecker.hasConnection;

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      if (!await _hasConnection) {
        return Left(NetworkFailure());
      }

      final categories = await datasource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    List<String> categories = const [],
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      List<ProductEntity> products = await datasource.getFilteredProducts(
        minPrice: minPrice,
        maxPrice: maxPrice,
        categories: categories,
      );

      return Right(products);
    } catch (e) {
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }
}
