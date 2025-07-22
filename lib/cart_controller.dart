
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_cart/main.dart';
// import 'package:shopping_cart/product_model.dart';

class CartController extends GetxController{
  final _cartItems = <Product, int>{}.obs;

  Map<Product, int> get cartItems => _cartItems;

  void addToCart(Product product,{bool showSnackbar = true} ){
    if(_cartItems.containsKey(product)){
      _cartItems[product] = _cartItems[product]! + 1;

    }else{
      _cartItems[product] = 1;
    }

    if (showSnackbar){
      Get.snackbar(
      'Add to the Cart',
      '${product.name} has been added to the cart!',
       snackPosition: SnackPosition.BOTTOM,
       duration: const Duration(seconds: 2),
       backgroundColor: Color(0xFF5368E9),
       colorText: Colors.white,
       borderRadius: 8,
       margin: const EdgeInsets.all(10),
      );
    }
  }

  void removeFromCart(Product product){
    if(_cartItems.containsKey(product)&& _cartItems[product]! > 1){
      _cartItems[product] = _cartItems[product]!-1;
    }else{
      _cartItems.remove(product);
    }
  }

  void removeProductCompletely (Product product){
    if (_cartItems.containsKey(product)){
      _cartItems.remove(product);
    }
  }

  void clearCart(){
    _cartItems.clear();
  }

  double get totalAmount{
    double total = 0.0;
    _cartItems.forEach((product, quantity){
      total += product.price * quantity;
    });
    return total;
    }

    int get itemCount{
      return _cartItems.entries.fold(0,(sum, item)=> sum + item.value);
    }

    int get uniqueItemsCount{
      return _cartItems.length;
    }
}