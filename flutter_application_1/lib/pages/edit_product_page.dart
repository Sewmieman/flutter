import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/product.dart';
import '../store/app_store.dart';
import '../widgets/product_form.dart';

// ============================================================

class EditProductPage extends StatefulWidget {
  final int productIndex;

  const EditProductPage({super.key, required this.productIndex});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final TextEditingController title;
  late final TextEditingController price;
  late final TextEditingController description;
  late String category;

  final categories = const [
    'smartphones', 'headphones', 'computers', 'clothing',
    'cameras', 'bags', 'other'
  ];

  @override
  void initState() {
    super.initState();
    final product = store.products[widget.productIndex];
    title = TextEditingController(text: product.name);
    price = TextEditingController(text: product.price.toStringAsFixed(1));
    description = TextEditingController(text: product.description);
    category = product.category;
  }

  @override
  void dispose() {
    title.dispose();
    price.dispose();
    description.dispose();
    super.dispose();
  }

  void update() {
    final name = title.text.trim();
    final amount = double.tryParse(price.text.trim());
    final desc = description.text.trim();

    if (name.isEmpty || amount == null || amount < 0 || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields correctly.')),
      );
      return;
    }

    store.updateProduct(
      widget.productIndex,
      makeProduct(name, amount, desc, category),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) => ProductForm(
        pageTitle: 'Edit product',
        saveText: 'Update product',
        titleController: title,
        priceController: price,
        descriptionController: description,
        category: category,
        categories: categories,
        onCategoryChanged: (value) => setState(() => category = value),
        onSave: update,
      );
}

Product makeProduct(String name, double price, String description,
    String category) {
  return Product(
    name: name,
    price: price,
    category: category,
    description: description,
    icon: categoryIcon(category),
    backgroundColor: categoryBackground(category),
    iconColor: categoryColor(category),
  );
}

IconData categoryIcon(String category) {
  switch (category) {
    case 'smartphones': return Icons.phone_android;
    case 'headphones': return Icons.headphones;
    case 'computers': return Icons.laptop;
    case 'clothing': return Icons.checkroom;
    case 'cameras': return Icons.camera_alt;
    case 'bags': return Icons.backpack;
    default: return Icons.shopping_bag;
  }
}

Color categoryBackground(String category) {
  switch (category) {
    case 'smartphones': return const Color(0xFFE4ECFF);
    case 'headphones': return const Color(0xFFE0F2EE);
    case 'computers': return const Color(0xFFECE2FF);
    case 'clothing': return const Color(0xFFF8E7E1);
    case 'cameras': return const Color(0xFFEAF0E1);
    case 'bags': return const Color(0xFFF6E2EC);
    default: return const Color(0xFFEDEDED);
  }
}

Color categoryColor(String category) {
  switch (category) {
    case 'smartphones': return const Color(0xFF2864F0);
    case 'headphones': return const Color(0xFF00A884);
    case 'computers': return const Color(0xFF7B3FF2);
    case 'clothing': return const Color(0xFFD84B14);
    case 'cameras': return const Color(0xFF568D16);
    case 'bags': return const Color(0xFFC91664);
    default: return const Color(0xFF666666);
  }
}
