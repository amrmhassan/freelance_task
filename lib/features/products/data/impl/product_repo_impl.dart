import 'package:dartz/dartz.dart';
import 'package:freelance_task/constants/endpoints.dart';
import 'package:freelance_task/core/api/api_consumer.dart';
import 'package:freelance_task/core/errors/failure.dart';
import 'package:freelance_task/features/products/data/models/product_model.dart';
import 'package:freelance_task/features/products/data/repo/product_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProductRepoImpl implements ProductRepo {
  final ApiConsumer api;
  final InternetConnectionChecker _connectionChecker;

  ProductRepoImpl(this.api)
    : _connectionChecker = InternetConnectionChecker.createInstance();

  Future<bool> get _hasConnection => _connectionChecker.hasConnection;

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      if (!await _hasConnection) {
        return Left(NetworkFailure());
      }

      final response = await api.get(Endpoints.categories) as List;
      List<String> categories = response.map((e) => e.toString()).toList();
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    List<String> categories = const [],
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      if (!await _hasConnection) {
        return Left(NetworkFailure());
      }

      final response = await api.get(Endpoints.products) as List;
      List<ProductModel> allProducts =
          response.map((json) => ProductModel.fromJson(json)).toList();

      List<ProductModel> filteredProducts =
          allProducts.where((product) {
            final matchesCategory =
                categories.isEmpty || categories.contains(product.category);
            final matchesPrice =
                product.price >= minPrice && product.price <= maxPrice;
            return matchesCategory && matchesPrice;
          }).toList();

      return Right(filteredProducts);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
