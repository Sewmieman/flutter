import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductForm extends StatelessWidget {
  final String pageTitle;
  final String saveText;
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final String category;
  final List<String> categories;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback onSave;

  const ProductForm({
    super.key,
    required this.pageTitle,
    required this.saveText,
    required this.titleController,
    required this.priceController,
    required this.descriptionController,
    required this.category,
    required this.categories,
    required this.onCategoryChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, size: 21),
        ),
        title: Text(
          pageTitle,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Color(0xFFE5E5E5)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label('Title'),
            field(titleController, 'Desk lamp'),
            const SizedBox(height: 10),
            label('Price'),
            field(
              priceController,
              '0',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 10),
            label('Category'),
            DropdownButtonFormField<String>(
              value: category,
              decoration: inputDecoration(),
              items: categories
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) onCategoryChanged(value);
              },
            ),
            const SizedBox(height: 10),
            label('Description'),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              style: const TextStyle(fontSize: 11),
              decoration: inputDecoration('Short description'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 34,
              child: ElevatedButton(
                onPressed: onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2864E8),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  saveText,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 12,
        color: const Color(0xFF4AB7AE),
      ),
    );
  }

  static Widget label(String text) => Padding(
        padding: const EdgeInsets.only(left: 1, bottom: 4),
        child: Text(
          text,
          style: const TextStyle(fontSize: 9, color: Color(0xFF8A8A8A)),
        ),
      );

  static Widget field(
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
  }) => SizedBox(
        height: 32,
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 11),
          decoration: inputDecoration(hint),
        ),
      );

  static InputDecoration inputDecoration([String? hint]) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF555555)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: Color(0xFF9EA2A8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: Color(0xFF9EA2A8)),
        ),
      );
}
