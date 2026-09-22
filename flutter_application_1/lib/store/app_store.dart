import 'package:flutter/material.dart';
import '../models/product.dart';

class AppStore extends ChangeNotifier {
  final List<Product> products = [
    const Product(
      name: 'Phone X',
      price: 549,
      category: 'smartphones',
      icon: Icons.phone_android,
      backgroundColor: Color(0xFFE4ECFF),
      iconColor: Color(0xFF2864F0),
      description: 'Modern smartphone with a beautiful display.',
    ),
    const Product(
      name: 'Headphones',
      price: 89,
      category: 'headphones',
      icon: Icons.headphones,
      backgroundColor: Color(0xFFE0F2EE),
      iconColor: Color(0xFF00A884),
      description: 'Over-ear headphones with 30 hours of battery life.',
    ),
    const Product(
      name: 'T-shirt',
      price: 15,
      category: 'clothing',
      icon: Icons.checkroom,
      backgroundColor: Color(0xFFF8E7E1),
      iconColor: Color(0xFFD84B14),
      description: 'Comfortable and stylish everyday T-shirt.',
    ),
    const Product(
      name: 'Laptop',
      price: 899,
      category: 'computers',
      icon: Icons.laptop,
      backgroundColor: Color(0xFFECE2FF),
      iconColor: Color(0xFF7B3FF2),
      description: 'Powerful laptop for work and entertainment.',
    ),
    const Product(
      name: 'Camera',
      price: 320,
      category: 'cameras',
      icon: Icons.camera_alt,
      backgroundColor: Color(0xFFEAF0E1),
      iconColor: Color(0xFF568D16),
      description: 'Digital camera for high quality photography.',
    ),
    const Product(
      name: 'Backpack',
      price: 42,
      category: 'bags',
      icon: Icons.backpack,
      backgroundColor: Color(0xFFF6E2EC),
      iconColor: Color(0xFFC91664),
      description: 'Durable backpack for school and travel.',
    ),
  ];

  final List<CartItem> cart = [];

  int get cartCount => cart.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotal => cart.fold(0, (sum, item) => sum + item.subtotal);

  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  void updateProduct(int index, Product product) {
    if (index >= 0 && index < products.length) {
      products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(int index) {
    if (index >= 0 && index < products.length) {
      final product = products.removeAt(index);
      cart.removeWhere((item) => item.product == product);
      notifyListeners();
    }
  }

  void addToCart(Product product, int quantity) {
    final index = cart.indexWhere((item) => item.product == product);
    if (index == -1) {
      cart.add(CartItem(product: product, quantity: quantity));
    } else {
      cart[index].quantity += quantity;
    }
    notifyListeners();
  }

  void removeCartItem(int index) {
    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      notifyListeners();
    }
  }

  void checkout() {
    cart.clear();
    notifyListeners();
  }
}

final store = AppStore();
