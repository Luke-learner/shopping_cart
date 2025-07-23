import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/cart_controller.dart';
import 'package:shopping_cart/main.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white, size: 20),
            onPressed: () {
              if (cartController.itemCount > 0) {
                Get.defaultDialog(
                  title: 'Clear Cart',
                  titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  content: const Text(
                    'Are you sure you want to clear the cart? This action cannot be undone!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  radius: 8,
                  confirm: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5368E9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    onPressed: () {
                      cartController.clearCart();
                      Get.back();
                    },
                    child: const Text('Yes', style: TextStyle(fontSize: 14)),
                  ),
                  cancel: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF5368E9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('No!', style: TextStyle(fontSize: 14)),
                  ),
                );
              } else {
                Get.snackbar(
                  'Cart Cleaned',
                  'Your cart is already empty!.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  backgroundColor: const Color(0xFF5368E9),
                  colorText: Colors.white,
                  borderRadius: 6,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  messageText: Text(
                    'Your cart is already empty!.',
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Obx(() => cartController.cartItems.isEmpty ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 60,
              color: Color.fromARGB(255, 229, 230, 234),
            ),
            const SizedBox(height: 15),
            const Text(
              'Your Cart is empty!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5368E9),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Add some to your cart!",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ) : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: cartController.cartItems.length,
        itemBuilder: (context, index) {
          final product = cartController.cartItems.keys.toList()[index];
          final quantity = cartController.cartItems[product]!;
          return CartItemCard(
            product: product,
            quantity: quantity,
            cartController: cartController,
          );
        },
      )),
      bottomNavigationBar: Obx(() => cartController.cartItems.isEmpty ? SizedBox.shrink() : Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: SafeArea(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '\$${cartController.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5368E9),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5368E9),
                foregroundColor: Colors.white,
                elevation: 0,
                maximumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onPressed: () {
                Get.snackbar(
                  'Order Placed',
                  'Your order has been placed successfully',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  borderRadius: 6,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  messageText: Text(
                    'Your order has been placed successfully',
                    style: const TextStyle(fontSize: 12),
                  ),
                );
                cartController.clearCart();
              },
              child: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        )),
      )),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final Product product;
  final int quantity;
  final CartController cartController;

  const CartItemCard({
    super.key,
    required this.cartController,
    required this.quantity,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      GestureDetector(
                        onTap: () => cartController.removeProductCompletely(product),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, color: Colors.red, size: 16),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5368E9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => cartController.removeFromCart(product),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                  size: 14,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5368E9),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => cartController.addToCart(product, showSnackbar: false),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5368E9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${(product.price * quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}