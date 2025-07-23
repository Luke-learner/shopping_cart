import 'package:get/get.dart';
import 'package:shopping_cart/main.dart';

class ProductController extends GetxController {
  final RxList<Product> _products = <Product>[].obs;
  final RxList<Product> _filteredProducts = <Product>[].obs;
  final Rx<String?> _selectedCategory = Rx<String?>(null);

  List<Product> get products => _products.toList();
  List<Product> get filteredProducts => _filteredProducts.toList();
  String? get selectedCategory => _selectedCategory.value;

  @override
  void onInit() {
    super.onInit();
    _fetchProducts();
    _filteredProducts.assignAll(_products);
  }

  void _fetchProducts() {
    List<Product> productData = [
      Product(id: 1, name: 'Nike King', description: 'High-performance athletic shoes designed for speed, comfort, and style. Perfect for both sports and casual wear.', imageUrl: '../images/Nike.jpg', price: 129.99),
      Product(id: 2, name: 'Adidas', description: 'Innovative and breathable shoes with modern design. Ideal for running, training, and everyday use.', imageUrl: '../images/Adidas.jpg', price: 149.99),
      Product(id: 3, name: 'Converse 1970', description: 'Classic canvas sneakers with timeless street style. A go-to choice for casual fashion lovers.', imageUrl: '../images/Convers.jpg', price: 89.99),
      Product(id: 4, name: 'Heels', description: 'Signature Nike shoes offering premium cushioning and iconic design. Trusted by athletes worldwide.', imageUrl: '../images/Alexandra.jpg', price: 149.99),
      Product(id: 5, name: 'Nike G.T. Cut 3', description: 'A low-profile, ultra-responsive basketball shoe engineered for quick cuts and dynamic play using Nike’s ZoomX foam.', imageUrl: '../images/Nike G.T. Cut 3.jpg', price: 165.99),
      Product(id: 6, name: 'Nike Mercurial Vapor 16 Elite', description: 'A speed-optimized football boot featuring Zoom Air and a lightweight upper for explosive acceleration on the pitch.', imageUrl: '../images/Nike Mercurial Vapor 16 Elite.jpg', price: 232.99),
      Product(id: 7, name: 'Nike Air Force', description: 'A timeless classic with clean design and durable comfort, originally made for basketball but now a streetwear staple.', imageUrl: '../images/Nike Air Force.jpg', price: 654.99),
      Product(id: 8, name: 'Nike Air Jordan 3', description: 'A legendary basketball sneaker that introduced visible Air cushioning and iconic elephant print, blending performance with street style.', imageUrl: '../images/Nike Air Jordan 3.jpg', price: 432.99),
      Product(id: 9, name: 'Converse x ADERERROR Wave Trainer', description: 'A collection of mixed-material overlays, distressed finishes and their signature blue.', imageUrl: '../images/Converse x ADERERROR Wave Trainer.jpg', price: 299.99),
      Product(id: 10, name: 'Converse Chuck 70 Pride', description: 'The classic, with a bold twist. Now is the time to celebrate progress and be prouder than proud.', imageUrl: '../images/Converse Chuck 70 Pride.png', price: 221.99),
      Product(id: 11, name: 'Converse Essential Slide', description: 'Introducing ultra-comfy slides, Converse style.', imageUrl: '../images/Converse Essential Slide.png', price: 43.99),
      Product(id: 12, name: 'Converse Chuck Taylor All Star Pride', description: 'The classic, with flair. For those proud to be resiliently bright as they march toward the future.', imageUrl: '../images/Converse Chuck Taylor All Star Pride.png', price: 432.99),
      Product(id: 13, name: 'Adidas Y-3_Adios_Pro', description: 'A fashion-forward performance running shoe blending Yohji Yamamoto’s avant-garde design with cutting-edge Adizero racing technology.', imageUrl: '../images/Adidas Y-3_Adios_Pro.jpg', price: 543.99),
      Product(id: 14, name: 'Adidas Adizero-prime-x3', description: 'A highly stacked, carbon-infused super shoe built for speed and long-distance racing, pushing the limits of performance innovation.', imageUrl: '../images/Adidas Adizero-prime-x3.jpg', price: 232.99),
      Product(id: 15, name: 'Adidas Superstar', description: 'A timeless sneaker icon with a rubber shell toe, originally made for basketball but immortalized by hip-hop and street culture.', imageUrl: '../images/Adidas Superstar.jpg', price: 121.99),
      Product(id: 16, name: 'Adidas Adizero', description: 'A lightweight performance line designed for speed, often worn by elite runners and sprinters for maximum efficiency.', imageUrl: '../images/Adidas Adizero.jpg', price: 143.99),
    ];
    _products.assignAll(productData);
  }

  void searchProducts(String query) {
    if (query.isEmpty && _selectedCategory.value == null) {
      _filteredProducts.assignAll(_products);
    } else {
      _filteredProducts.assignAll(_products.where((product) => 
        (product.name.toLowerCase().contains(query.toLowerCase()) || query.isEmpty) &&
        (_selectedCategory.value == null || product.name.toLowerCase().startsWith(_selectedCategory.value!.toLowerCase()))).toList());
    }
  }

  void filterByCategory(String? category) {
    _selectedCategory.value = category;
    if (category == null) {
      _filteredProducts.assignAll(_products);
    } else {
      _filteredProducts.assignAll(_products.where((product) => product.name.toLowerCase().startsWith(category.toLowerCase())).toList());
    }
    searchProducts(''); // Reset search to apply category filter
  }
}