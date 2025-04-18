import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_task/core/services.dart';
import 'package:freelance_task/features/products/data/repositories/product_repo_impl.dart';
import 'package:freelance_task/features/products/manager/products_cubit/products_cubit.dart';
import 'package:freelance_task/features/products/presentation/screens/all_products_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(getIt<ProductRepoImpl>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Freelance Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: ProductListScreen(),
      ),
    );
  }
}

// dart run build_runner build --delete-conflicting-outputs
// dart run build_runner watch --delete-conflicting-outputs
