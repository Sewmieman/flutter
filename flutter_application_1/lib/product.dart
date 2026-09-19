import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================
// APP
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Mini Market'),
    );
  }
}

// ============================================================
// PRODUCT MODEL
// ============================================================

class Product {
  final String name;
  final double price;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String description;

  const Product({
    required this.name,
    required this.price,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.description,
  });
}

// ============================================================
// HOME PAGE
// ============================================================

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _cartCount = 0;

  // ----------------------------------------------------------
  // PRODUCTS
  // ----------------------------------------------------------

  final List<Product> _products = const [
    Product(
      name: 'Phone X',
      price: 549.0,
      icon: Icons.phone_android,
      backgroundColor: Color(0xFFE4ECFF),
      iconColor: Color(0xFF2864F0),
      description: 'Modern smartphone with a beautiful display.',
    ),

    Product(
      name: 'Headphones',
      price: 89.0,
      icon: Icons.headphones,
      backgroundColor: Color(0xFFE0F2EE),
      iconColor: Color(0xFF00A884),
      description:
          'Over-ear headphones with 30 hours of battery life.',
    ),

    Product(
      name: 'T-shirt',
      price: 15.0,
      icon: Icons.checkroom,
      backgroundColor: Color(0xFFF8E7E1),
      iconColor: Color(0xFFD84B14),
      description: 'Comfortable and stylish everyday T-shirt.',
    ),

    Product(
      name: 'Laptop',
      price: 899.0,
      icon: Icons.laptop,
      backgroundColor: Color(0xFFECE2FF),
      iconColor: Color(0xFF7B3FF2),
      description: 'Powerful laptop for work and entertainment.',
    ),

    Product(
      name: 'Camera',
      price: 320.0,
      icon: Icons.camera_alt,
      backgroundColor: Color(0xFFEAF0E1),
      iconColor: Color(0xFF568D16),
      description: 'Digital camera for high quality photography.',
    ),

    Product(
      name: 'Backpack',
      price: 42.0,
      icon: Icons.backpack,
      backgroundColor: Color(0xFFF6E2EC),
      iconColor: Color(0xFFC91664),
      description: 'Durable backpack for school and travel.',
    ),
  ];

  // ==========================================================
  // ADD TO CART
  // ==========================================================

  void _addToCart(Product product, int quantity) {
    setState(() {
      _cartCount += quantity;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${product.name} added to cart',
        ),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  // ==========================================================
  // PRODUCT DETAIL
  // ==========================================================

  void _openProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          product: product,
          onAddToCart: (quantity) {
            _addToCart(product, quantity);
          },
        ),
      ),
    );
  }

  // ==========================================================
  // BUILD HOME
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ------------------------------------------------------
      // APP BAR
      // ------------------------------------------------------

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,

        titleSpacing: 16,

        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 21,
                  color: Colors.black,
                ),
              ),

              if (_cartCount > 0)
                Positioned(
                  right: 5,
                  top: 4,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$_cartCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
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
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E5E5),
          ),
        ),
      ),

      // ------------------------------------------------------
      // PRODUCT GRID
      // ------------------------------------------------------

      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          12,
          10,
          12,
          60,
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildProductCard(
                      _products[0],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _buildProductCard(
                      _products[1],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildProductCard(
                      _products[2],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _buildProductCard(
                      _products[3],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildProductCard(
                      _products[4],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _buildProductCard(
                      _products[5],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ------------------------------------------------------
      // PLUS BUTTON
      // ------------------------------------------------------

      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 3,
        backgroundColor: const Color(0xFFDCE5FF),
        foregroundColor: const Color(0xFF304B9B),
        onPressed: () {
          _addToCart(_products[0], 1);
        },
        child: const Icon(Icons.add),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,

      // ------------------------------------------------------
      // BOTTOM BAR
      // ------------------------------------------------------

      bottomNavigationBar: Container(
        height: 12,
        color: const Color(0xFF4AB7AE),
      ),
    );
  }

  // ==========================================================
  // PRODUCT CARD
  // ==========================================================

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        _openProduct(product);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: const Color(0xFFE1E1E1),
          ),
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
                    size: 20,
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
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF222222),
              ),
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
  }
}

// ============================================================
// PRODUCT DETAIL PAGE
// ============================================================

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final Function(int) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailPage> createState() =>
      _ProductDetailPageState();
}

class _ProductDetailPageState
    extends State<ProductDetailPage> {
  int _quantity = 1;

  // ==========================================================
  // INCREASE QUANTITY
  // ==========================================================

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  // ==========================================================
  // DECREASE QUANTITY
  // ==========================================================

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  // ==========================================================
  // DELETE
  // ==========================================================

  void _deleteProduct() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product deleted'),
      ),
    );

    Navigator.pop(context);
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ======================================================
      // CUSTOM TOP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 21,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          widget.product.name,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        centerTitle: true,

        actions: [
          // Edit
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              size: 18,
              color: Colors.black,
            ),
          ),

          // Delete
          IconButton(
            onPressed: _deleteProduct,
            icon: const Icon(
              Icons.delete_outline,
              size: 19,
              color: Colors.red,
            ),
          ),

          const SizedBox(width: 3),
        ],

        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE5E5E5),
          ),
        ),
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          9,
          10,
          9,
          0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------------------------------
            // LARGE PRODUCT IMAGE
            // ------------------------------------------------

            Container(
              height: 138,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.product.backgroundColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  widget.product.icon,
                  size: 50,
                  color: widget.product.iconColor,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ------------------------------------------------
            // PRODUCT NAME
            // ------------------------------------------------

            Text(
              widget.product.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF202124),
              ),
            ),

            const SizedBox(height: 3),

            // ------------------------------------------------
            // PRICE
            // ------------------------------------------------

            Text(
              '\$${widget.product.price.toStringAsFixed(1)}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2864F0),
              ),
            ),

            const SizedBox(height: 10),

            // ------------------------------------------------
            // DESCRIPTION
            // ------------------------------------------------

            Text(
              widget.product.description,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF999999),
              ),
            ),

            const SizedBox(height: 17),

            // ------------------------------------------------
            // QUANTITY
            // ------------------------------------------------

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

                // Minus
                SizedBox(
                  width: 27,
                  height: 27,
                  child: OutlinedButton(
                    onPressed: _decreaseQuantity,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(
                        color: Color(0xFFE0E0E0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6),
                      ),
                    ),
                    child: const Icon(
                      Icons.remove,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(width: 11),

                // Quantity number
                Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(width: 11),

                // Plus
                SizedBox(
                  width: 27,
                  height: 27,
                  child: OutlinedButton(
                    onPressed: _increaseQuantity,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(
                        color: Color(0xFFE0E0E0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            // Push button to bottom
            const Spacer(),

            // ------------------------------------------------
            // ADD TO CART BUTTON
            // ------------------------------------------------

            SizedBox(
              width: double.infinity,
              height: 34,
              child: ElevatedButton(
                onPressed: () {
                  widget.onAddToCart(_quantity);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        '${widget.product.name} added to cart',
                      ),
                      duration:
                          const Duration(milliseconds: 900),
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2864E8),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(6),
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

      // ======================================================
      // BOTTOM GREEN BAR
      // ======================================================

      bottomNavigationBar: Container(
        height: 12,
        color: const Color(0xFF4AB7AE),
      ),
    );
  }
}