import 'package:freelance_task/core/routing/app_router.dart';
import 'package:freelance_task/core/routing/build_page_with_default_transition.dart';
import 'package:freelance_task/core/routing/routes_keys.dart';
import 'package:freelance_task/features/products/presentation/screens/all_products_screen.dart';
import 'package:freelance_task/features/products/presentation/screens/product_details_screen.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> appRoutes = [
  GoRoute(
    parentNavigatorKey: parentKey,
    path: RoutesKeys.kHome,
    pageBuilder:
        (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: ProductListScreen(),
        ),
  ),
  GoRoute(
    parentNavigatorKey: parentKey,
    path: RoutesKeys.kProductDetails,
    pageBuilder:
        (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: ProductDetailsScreen(product: (state.extra as Map)['product']),
        ),
  ),
];
