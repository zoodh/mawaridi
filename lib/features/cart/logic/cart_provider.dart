import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../products/models/product.dart';
import '../models/cart_item.dart';

final cartProvider =
NotifierProvider<CartNotifier, List<CartItem>>(CartNotifier.new);

class CartNotifier extends Notifier<List<CartItem>> {

  @override
  List<CartItem> build() {
    return [];
  }


  void addToCart(Product product, int quantity) {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index)
            CartItem(product: product, quantity: state[i].quantity + 1)
          else
            state[i],
      ];
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(String productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void changeQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }

    state = [
      for (final item in state)
        if (item.product.id == productId)
          CartItem(product: item.product, quantity: newQuantity)
        else
          item,
    ];
  }

  void clearCart() {
    state = [];
  }



}