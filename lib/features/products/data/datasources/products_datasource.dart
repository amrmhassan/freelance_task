import 'package:freelance_task/constants/endpoints.dart';
import 'package:freelance_task/core/api/dio_consumer.dart';
import 'package:freelance_task/features/products/domain/enities/product_model.dart';

class ProductsDatasource {
  final DioConsumer _api;
  // caching
  List<ProductModel>? _cachedProducts;
  List<String>? _cachedCategories;
  static const cacheDuration = Duration(minutes: 5);
  DateTime? _lastProductsFetch;
  DateTime? _lastCategoriesFetch;

  ProductsDatasource(this._api);

  Future<List<ProductModel>> getAllProducts() async {
    if (_cachedProducts != null && _lastProductsFetch != null) {
      final diff = DateTime.now().difference(_lastProductsFetch!);
      if (diff < cacheDuration) {
        return _cachedProducts!;
      }
    }
    final res = await _api.get(Endpoints.products) as List;
    var models = res.map((doc) => ProductModel.fromJson(doc)).toList();
    _cachedProducts = models;
    _lastProductsFetch = DateTime.now();
    return models;
  }

  Future<List<ProductModel>> getFilteredProducts({
    List<String> categories = const [],
    required double minPrice,
    required double maxPrice,
  }) async {
    var allProducts = await getAllProducts();
    List<ProductModel> filteredProducts =
        allProducts.where((product) {
          final matchesCategory =
              categories.isEmpty || categories.contains(product.category);
          final matchesPrice =
              product.price >= minPrice && product.price <= maxPrice;
          return matchesCategory && matchesPrice;
        }).toList();
    return filteredProducts;
  }

  Future<List<String>> getCategories() async {
    if (_cachedCategories != null && _lastCategoriesFetch != null) {
      final difference = DateTime.now().difference(_lastCategoriesFetch!);
      if (difference < cacheDuration) {
        return _cachedCategories!;
      }
    }
    final response = await _api.get(Endpoints.categories) as List;
    List<String> categories = response.map((e) => e.toString()).toList();
    _cachedCategories = categories;
    return categories;
  }
}
