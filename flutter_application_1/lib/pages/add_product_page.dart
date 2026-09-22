import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/edit_product_page.dart';
import 'package:go_router/go_router.dart';
import '../models/product.dart';
import '../store/app_store.dart';
import '../widgets/product_form.dart';

// ============================================================

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final title = TextEditingController();
  final price = TextEditingController(text: '0');
  final description = TextEditingController();
  String category = 'smartphones';

  final categories = const [
    'smartphones', 'headphones', 'computers', 'clothing',
    'cameras', 'bags', 'other'
  ];

  @override
  void dispose() {
    title.dispose();
    price.dispose();
    description.dispose();
    super.dispose();
  }

  void save() {
    final name = title.text.trim();
    final amount = double.tryParse(price.text.trim());
    final desc = description.text.trim();

    if (name.isEmpty || amount == null || amount < 0 || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields correctly.')),
      );
      return;
    }

    store.addProduct(makeProduct(name, amount, desc, category));
    context.go('/');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) => ProductForm(
        pageTitle: 'Add product',
        saveText: 'Save product',
        titleController: title,
        priceController: price,
        descriptionController: description,
        category: category,
        categories: categories,
        onCategoryChanged: (value) => setState(() => category = value),
        onSave: save,
      );
}

// ============================================================
