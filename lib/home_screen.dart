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
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Shopping Cart'),
        actions: [
          Obx(() => Stack(
                children: [
                  IconButton(
                    iconSize: 25, // Reduced icon size
                    color: Colors.white,
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () => Get.to(() => CartScreen()),
                  ),
                  if (cartController.uniqueItemsCount > 0)
                    Positioned(
                      right: 6, // Adjusted position
                      top: 6, // Adjusted position
                      child: Container(
                        padding: const EdgeInsets.all(2), // Reduced padding
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10), // Slightly smaller radius
                        ),
                        constraints: const BoxConstraints(
                          minHeight: 16,
                          minWidth: 16,
                        ),
                        child: Text(
                          '${cartController.uniqueItemsCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10, // Reduced font size
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10), // Reduced padding
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search, size: 20), // Reduced icon size
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Slightly smaller radius
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                productController.searchProducts(value);
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10), // Reduced padding
            child: Row(
              children: [
                FilterChip(
                  label: Text('All products'),
                  selected: productController.selectedCategory == null,
                  onSelected: (_) => productController.filterByCategory(null),
                  selectedColor: Color(0xFF5368E9),
                  labelStyle: TextStyle(
                    color: productController.selectedCategory == null ? Colors.white : Colors.black,
                    fontSize: 12, // Reduced font size
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
                ),
                SizedBox(width: 8), // Reduced spacing
                FilterChip(
                  label: Text('Nike'),
                  selected: productController.selectedCategory == 'Nike',
                  onSelected: (_) => productController.filterByCategory('Nike'),
                  selectedColor: Color(0xFF5368E9),
                  labelStyle: TextStyle(
                    color: productController.selectedCategory == 'Nike' ? Colors.white : Colors.black,
                    fontSize: 12, // Reduced font size
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
                ),
                SizedBox(width: 8), // Reduced spacing
                FilterChip(
                  label: Text('Converse'),
                  selected: productController.selectedCategory == 'Converse',
                  onSelected: (_) => productController.filterByCategory('Converse'),
                  selectedColor: Color(0xFF5368E9),
                  labelStyle: TextStyle(
                    color: productController.selectedCategory == 'Converse' ? Colors.white : Colors.black,
                    fontSize: 12, // Reduced font size
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
                ),
                SizedBox(width: 8), // Reduced spacing
                FilterChip(
                  label: Text('Adidas'),
                  selected: productController.selectedCategory == 'Adidas',
                  onSelected: (_) => productController.filterByCategory('Adidas'),
                  selectedColor: Color(0xFF5368E9),
                  labelStyle: TextStyle(
                    color: productController.selectedCategory == 'Adidas' ? Colors.white : Colors.black,
                    fontSize: 12, // Reduced font size
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
                ),
                SizedBox(width: 8), // Reduced spacing
                FilterChip(
                  label: Text('Heels'),
                  selected: productController.selectedCategory == 'Heels',
                  onSelected: (_) => productController.filterByCategory('Heels'),
                  selectedColor: Color(0xFF5368E9),
                  labelStyle: TextStyle(
                    color: productController.selectedCategory == 'Heels' ? Colors.white : Colors.black,
                    fontSize: 12, // Reduced font size
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => GridView.builder(
                padding: EdgeInsets.all(10), // Reduced padding
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7, // Slightly adjusted for compactness
                  crossAxisSpacing: 10, // Reduced spacing
                  mainAxisSpacing: 10, // Reduced spacing
                ),
                itemCount: productController.filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: productController.filteredProducts[index],
                    cartController: cartController,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final CartController cartController;
  const ProductCard({super.key, required this.product, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Slightly smaller radius
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8, // Reduced blur
            spreadRadius: 1,
            offset: Offset(0, 4), // Slightly reduced offset
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Slightly smaller radius
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey[100]),
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
                            size: 30, // Reduced size
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8), // Reduced padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 14, // Reduced font size
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4), // Reduced spacing
                    Text(
                      product.description,
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]), // Reduced font size
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
                            fontSize: 16, // Reduced font size
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () => cartController.addToCart(product),
                          child: Container(
                            padding: const EdgeInsets.all(8), // Reduced padding
                            decoration: BoxDecoration(
                              color: const Color(0xFF5368E9),
                              borderRadius: BorderRadius.circular(8), // Slightly smaller radius
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16, // Reduced size
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}