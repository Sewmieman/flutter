import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../store/app_store.dart';
import '../widgets/qty_button.dart';

// ============================================================

class ProductDetailPage extends StatefulWidget {
  final int productIndex;

  const ProductDetailPage({super.key, required this.productIndex});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  Future<void> deleteProduct() async {
    if (widget.productIndex >= store.products.length) return;
    final product = store.products[widget.productIndex];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete product?'),
        content: const Text(
          'This product will be removed from the market.',
        ),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => dialogContext.pop(true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    store.deleteProduct(widget.productIndex);
    context.go('/');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        if (widget.productIndex >= store.products.length) {
          return const Scaffold(
            body: Center(child: Text('Product not found')),
          );
        }
        final product = store.products[widget.productIndex];

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
              product.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => context.push(
                  '/edit-product',
                  extra: widget.productIndex,
                ),
                icon: const Icon(Icons.edit, size: 18),
              ),
              IconButton(
                onPressed: deleteProduct,
                icon: const Icon(
                  Icons.delete_outline,
                  size: 19,
                  color: Colors.red,
                ),
              ),
            ],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1, color: Color(0xFFE5E5E5)),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(9, 10, 9, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 138,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: product.backgroundColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Icon(
                      product.icon,
                      size: 50,
                      color: product.iconColor,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '\$${product.price.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2864F0),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF999999),
                  ),
                ),
                const SizedBox(height: 17),
                Row(
                  children: [
                    const Text(
                      'Qty',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF999999),
                      ),
                    ),
                    const SizedBox(width: 10),
                    QtyButton(
                      icon: Icons.remove,
                      onPressed: () {
                        if (quantity > 1) setState(() => quantity--);
                      },
                    ),
                    const SizedBox(width: 11),
                    Text('$quantity',
                        style: const TextStyle(fontSize: 11)),
                    const SizedBox(width: 11),
                    QtyButton(
                      icon: Icons.add,
                      onPressed: () => setState(() => quantity++),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () {
                      store.addToCart(product, quantity);
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2864E8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 9),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 12,
            color: const Color(0xFF4AB7AE),
          ),
        );
      },
    );
  }
}
