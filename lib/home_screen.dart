import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/cart_controller.dart';
import 'package:shopping_cart/cart_screen.dart';
import 'package:shopping_cart/main.dart';
import 'package:shopping_cart/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Shopping Cart'),
        actions: [
          Obx(() => Stack(
                
                children: [
                  IconButton(
                    iconSize: 26,
                    color: Colors.white,
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () => Get.to(() => CartScreen()),
                  ),
                  if (cartController.uniqueItemsCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(13),
                          // shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minHeight: 20,
                          minWidth: 20,
                        ),
                        child: Text(
                          '${cartController.uniqueItemsCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              )),
        ],
      ),
      body: Obx(
        () => GridView.builder(
            padding: EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 15,
            mainAxisExtent: 15,
            ),
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              // final product = productController.products[index];
              return ProductCard(
                product: productController.products[index],
                cartController:cartController,
              );
                
            },
          )
          ),
    );
  }
}

class ProductCard extends StatelessWidget{
  final Product product;
  final CartController cartController;
  const ProductCard ({super.key, required this.product, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),

          )
        ]
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
            aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[100]),
              child:Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder:(context, error, stackTrace){
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey,
                      size: 40, 
                    ),
                  ),
                );
              }
              // height: 150,
              // width: double.infinity,
            ),
            ),
            ),
            Expanded(
            child:  Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 5),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                     InkWell(
                      onTap: () => cartController.addToCart(product),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5368E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 8,
                        ),
                      ),
                     )
                   ],
                ),
              ],
            ),
          )
            )
          ],
        ),
      )
    );
  }
}
