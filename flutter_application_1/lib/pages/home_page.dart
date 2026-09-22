import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../store/app_store.dart';

// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          titleSpacing: 16,
          title: const Text(
            'Mini Market',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          actions: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () => context.push('/cart'),
                  icon: const Icon(Icons.shopping_cart, size: 21),
                ),
                if (store.cartCount > 0)
                  Positioned(
                    right: 5,
                    top: 4,
                    child: Container(
                      width: 15,
                      height: 15,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${store.cartCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 5),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, color: Color(0xFFE5E5E5)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 60),
          child: store.products.isEmpty
              ? const Center(child: Text('No products available'))
              : GridView.builder(
                  itemCount: store.products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1.35,
                  ),
                  itemBuilder: (context, index) {
                    final product = store.products[index];
                    return GestureDetector(
                      onTap: () => context.push('/product/$index'),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: const Color(0xFFE1E1E1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: product.backgroundColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Icon(
                                    product.icon,
                                    size: 28,
                                    color: product.iconColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 9),
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          backgroundColor: const Color(0xFFDCE5FF),
          foregroundColor: const Color(0xFF304B9B),
          onPressed: () => context.push('/add-product'),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: Container(
          height: 12,
          color: const Color(0xFF4AB7AE),
        ),
      ),
    );
  }
}

// ============================================================
