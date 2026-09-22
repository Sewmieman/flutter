import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String category;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const Product({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double get subtotal => product.price * quantity;
}
