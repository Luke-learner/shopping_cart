import 'package:get/get.dart';
import 'package:shopping_cart/main.dart';

class ProductController extends GetxController{
  final RxList<Product> _products =<Product>[].obs;

  List<Product> get products => _products;

  @override
  void onInit(){
    super.onInit();
    _fetchProducts();
  }

  void _fetchProducts(){
    List<Product> productData = [
      Product(id: 1, 
      name: 'Nike', 
      description: 'High-performance athletic shoes designed for speed, comfort, and style. Perfect for both sports and casual wear.', 
      imageUrl: '../images/Nike.jpg', 
      price: 129.99),

      Product(id: 2, 
      name: 'Adidas', 
      description: 'Innovative and breathable shoes with modern design. Ideal for running, training, and everyday use.', 
      imageUrl: '../images/Adidas.jpg', 
      price: 149.99),

      Product(id: 3, 
      name: 'Convers', 
      description: 'Classic canvas sneakers with timeless street style. A go-to choice for casual fashion lovers. ', 
      imageUrl: '../images/Convers.jpg', 
      price: 89.99),


      Product(id: 4, 
      name: 'Heels', 
      description: 'Signature Nike shoes offering premium cushioning and iconic design. Trusted by athletes worldwide.', 
      imageUrl: '../images/Alexandra.jpg', 
      price: 149.99),
      
    ];
    _products.assignAll(productData);
  }
}