import 'package:dio/dio.dart';
import 'package:freelance_task/core/api/dio_consumer.dart';
import 'package:freelance_task/features/products/data/impl/product_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<DioConsumer>(DioConsumer(dio: getIt<Dio>()));
  getIt.registerSingleton<ProductRepoImpl>(
    ProductRepoImpl(getIt.get<DioConsumer>()),
  );
}
