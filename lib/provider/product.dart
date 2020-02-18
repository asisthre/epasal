
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imgUrl;
  bool isFavourite;

  Product({this.id, this.title, this.price, this.description, this.imgUrl,
      this.isFavourite=false});

  void toggleIsFavourite(){
    isFavourite = !isFavourite;
    notifyListeners();
  }

}