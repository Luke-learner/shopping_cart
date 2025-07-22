import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_cart/cart_controller.dart';
import 'package:shopping_cart/main.dart';

class CartScreen extends StatelessWidget{
  const CartScreen ({super.key});


@override
Widget build (BuildContext context){
  final CartController cartController = Get.find<CartController>();
  return Scaffold(
    appBar: AppBar(
      title: const Text('Shooping Cart',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),),

      leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: Colors.white),
         onPressed: (){
          Get.back();
         },
         ),

      actions: [
        IconButton( 
        icon: const Icon(Icons.delete_outline, color: Colors.white,),
        onPressed: (){
          if(cartController.itemCount > 0){
            Get.defaultDialog(
              title: 'Clear Cart',
              titleStyle: TextStyle(fontWeight: FontWeight.bold),
              content: Text(
                'Are you sure you want to clear the cart? This action can not be undone!',
                textAlign: TextAlign.center,

              ),
              contentPadding: EdgeInsets.all(20),
              radius: 10,
              confirm: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5368E9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed:() {
                  cartController.clearCart();
                  Get.back();
                },
                child:  const Text('Yes'),
              ),

              cancel: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFF5368E9)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  foregroundColor: Colors.black,
                ),
                  onPressed:(){
                    Get.back();
                  }, 
                child: Text('No!'),
              ),

            );
          }else{
             Get.snackbar(
              'Cart Cleaned',
              'Your cart is already empty!.',
               snackPosition: SnackPosition.BOTTOM,
               duration: const Duration(seconds: 2),
               backgroundColor: const Color(0xFF5368E9),
               colorText: Colors.white,
               borderRadius: 8,
               margin: const EdgeInsets.all(10),
               );
          }
           
        },
        )
      ],
    ),
    body: Obx(()=> cartController.cartItems.isEmpty? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: Color.fromARGB(255, 229, 230, 234),
          ),
          const SizedBox(height: 20),
          const Text(
            'Your Cart is empty!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5368E9),
            ),
          ),
          const SizedBox(height: 10),
          Text("Add some to your cart!",
          style: TextStyle(fontSize: 14,
          color: Colors.grey[700]
          ),
          ),

        ],
      ),

    )
    :ListView.builder(
      padding: EdgeInsets.all(15),
      itemCount: cartController.cartItems.length,
      itemBuilder: (context, index) {
        final product = 
        cartController.cartItems.keys.toList()[index];
        final quantity = cartController.cartItems[product]!;
        return CartItemCard(
          product:product,
          quantity: quantity,
          cartController: cartController,
        );


      },
    ),

    ),
    bottomNavigationBar: Obx(()=> cartController.cartItems.isEmpty ? SizedBox.shrink():
    Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                '\$${cartController.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5368E9),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF5368E9),
              foregroundColor: Colors.white,
              elevation: 0,
              maximumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed:(){
              Get.snackbar('Order Plcaed', 
              'Your order has been plcaed successfully',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2,),
              backgroundColor: Colors.green,
              colorText: Colors.white,
              borderRadius: 8,
              margin: const EdgeInsets.all(10),
              );
              cartController.clearCart();
            },
            child: Text(
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
    )

    ),
  );
}
}

class CartItemCard extends StatelessWidget{
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
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
    child: Padding(padding: EdgeInsets.all(12),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[100],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace){
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey,
                      size: 400,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(width: 15),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  GestureDetector(
                    onTap: 
                    () => cartController.removeProductCompletely(product),

                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color:  Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, color: Colors.red, size: 16,),
                    ), 
                  )
                ],
              ),
              SizedBox(height: 5),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5368E9),
                ),
              ),
               SizedBox(height: 10,),
               Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: 
                          () => cartController.removeFromCart(product),
                          child: Container(
                            padding:  EdgeInsets.all(8),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5368E9),
                              ),
                            ),
                        ),
                        InkWell(
                          onTap: () => cartController.addToCart(product,
                          showSnackbar: false),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5368E9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ) 
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$${(product.price*quantity).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
               ),

            ],
          ),
        )
      ],
    )
    ),
     
    );
  }
}