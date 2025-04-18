import 'package:dio/dio.dart';
import 'package:freelance_task/core/api/dio_consumer.dart';
import 'package:freelance_task/features/products/data/datasources/products_datasource.dart';
import 'package:freelance_task/features/products/data/repositories/product_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  //? APIs
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<DioConsumer>(DioConsumer(dio: getIt<Dio>()));

  //? Datasources
  getIt.registerSingleton<ProductsDatasource>(
    ProductsDatasource(getIt<DioConsumer>()),
  );

  //? Repositories
  getIt.registerSingleton<ProductRepoImpl>(
    ProductRepoImpl(getIt.get<ProductsDatasource>()),
  );
}
