import 'package:dartz/dartz.dart';
import 'package:freelance_task/constants/endpoints.dart';
import 'package:freelance_task/core/api/api_consumer.dart';
import 'package:freelance_task/core/errors/failure.dart';
import 'package:freelance_task/features/products/data/models/product_model.dart';
import 'package:freelance_task/features/products/data/repo/product_repo.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

List<String> _categoriesCache = [];
List<ProductModel> _productsCache = [];

class ProductRepoImpl implements ProductRepo {
  final ApiConsumer api;
  final InternetConnectionChecker _connectionChecker;

  ProductRepoImpl(this.api)
    : _connectionChecker = InternetConnectionChecker.instance;

  Future<bool> get _hasConnection => _connectionChecker.hasConnection;

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      if (_categoriesCache.isNotEmpty) return Right(_categoriesCache);
      if (!await _hasConnection) {
        return Left(NetworkFailure());
      }

      final response = await api.get(Endpoints.categories) as List;
      List<String> categories = response.map((e) => e.toString()).toList();
      _categoriesCache = categories;
      return Right(categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<List<ProductModel>> _getAllProducts() async {
    if (_productsCache.isNotEmpty) return _productsCache;
    if (!await _hasConnection) {
      return throw NetworkFailure();
    }
    final response = await api.get(Endpoints.products) as List;
    List<ProductModel> allProducts =
        response.map((json) => ProductModel.fromJson(json)).toList();
    _productsCache = allProducts;
    return allProducts;
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    List<String> categories = const [],
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      List<ProductModel> allProducts = await _getAllProducts();

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
      if (e is Failure) return Left(e);
      return Left(ServerFailure(e.toString()));
    }
  }
}
