import 'package:flutter/material.dart';

class CartItem{
  final String id, title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity});
}

class Cart with ChangeNotifier{
  Map<String, CartItem> _items= {};

  Map<String, CartItem> get items {
    return _items;
  }

  //-----------this gives us total items in the cart------
  int get itemCount{
    return _items == null ? 0 : _items.length;
  }

//-------------this add items to the cart------------
  void addToCart(String productId, String title, double price){
    if(_items.containsKey(productId)){
      _items.update(productId, (existingcartItem) => CartItem(
        id: existingcartItem.id,
        title: existingcartItem.title,
        price: existingcartItem.price,
        quantity: existingcartItem.quantity +1,
      ));
    }else{
      _items.putIfAbsent(productId, ()=>CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity:1,
      ));
    }
    notifyListeners();
  }
}