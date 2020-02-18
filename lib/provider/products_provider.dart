import 'package:epasal/provider/product.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier{
  List<Product> _items=[
    Product(id: "first",title: "Watch",price: 2000, description: "The best watch you will ever find",
        imgUrl: "https://watchgecko.sirv.com/magento/catalog/category/G-01-WBG-Deployment-black_1.jpg",
        isFavourite: false),
    Product(id: "second",title: "Jacket",price: 1500, description: "The best jacket to keep you warm in winter",
        imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTILGJRZWvszL4aBZqmb1gARnRpNrNWQRmWGZwCn70wZtWHtWp9",
        isFavourite: false),
    Product(id: "third",title: "Laptop",price: 70000, description: "The best and affordable laptop you will ever find",
        imgUrl: "https://cdn2.centrecom.com.au/images/upload/0070218_thumb.jpeg",
        isFavourite: false),
    Product(id: "fourth",title: "Shoes",price: 4000, description: "Let your legs be comfortable",
        imgUrl: "https://image.cnbcfm.com/api/v1/image/105680013-1547583426762nike1.jpg?v=1547583682&w=678&h=381",
        isFavourite: false),
    Product(id: "fifth",title: "T-shirt",price: 2000, description: "Ebrace the world with your Tee",
        imgUrl: "https://scene7.zumiez.com/is/image/zumiez/pdp_hero/Illegal-Civilization-Script-Light-Blue-T-Shirt-_328090.jpg",
        isFavourite: false),
  ];
  List<Product> get items {
    return [..._items];
  }
  Product findById(String id){
    return items.firstWhere((prod){
      return prod.id == id;
    });
  }
  void addProduct() {
    _items.add(
        Product(id: "fifth",
        title: "T-shirt",
        price: 2000,
        description: "Ebrace the world with your Tee",
        imgUrl: "https://scene7.zumiez.com/is/image/zumiez/pdp_hero/Illegal-Civilization-Script-Light-Blue-T-Shirt-_328090.jpg",
        isFavourite: false));
    notifyListeners();
  }
}