import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../store/app_store.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back, size: 21),
          ),
          title: const Text(
            'Your cart',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, color: Color(0xFFE0E0E0)),
          ),
        ),
        body: store.cart.isEmpty
            ? const Center(
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(fontSize: 9, color: Color(0xFF999999)),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(9, 10, 9, 10),
                      itemCount: store.cart.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final item = store.cart[index];
                        return SizedBox(
                          height: 42,
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: item.product.backgroundColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  item.product.icon,
                                  size: 16,
                                  color: item.product.iconColor,
                                ),
                              ),
                              const SizedBox(width: 9),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Qty ${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF777777),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => store.removeCartItem(index),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 17,
                                  color: Color(0xFF999999),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFE5E5E5)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(9, 9, 9, 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF999999),
                              ),
                            ),
                            Text(
                              '\$${store.cartTotal.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 34,
                          child: OutlinedButton(
                            onPressed: () {
                              store.checkout();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Checkout completed successfully'),
                                ),
                              );
                            },
                            child: const Text(
                              'Checkout',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
