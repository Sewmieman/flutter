import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/add_product_page.dart';
import 'pages/edit_product_page.dart';
import 'pages/cart_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/product/:index',
      builder: (context, state) {
        return ProductDetailPage(
          productIndex: state.pathParameters['index']! as int,
        );
      },
    ),
    GoRoute(
      path: '/add-product',
      builder: (context, state) => const AddProductPage(),
    ),
    GoRoute(
      path: '/edit-product/: index',
      builder: (context, state) {
        return EditProductPage(
          productIndex: state.pathParameters['index']! as int,
        );
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartPage(),
    ),
  ],
);
