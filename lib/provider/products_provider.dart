import 'dart:convert';

import 'package:epasal/provider/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  List<Product> get favourites{
    return _items.where((prodItem){
      return prodItem.isFavourite;
    }).toList();
  }

  Product findById(String id){
    return items.firstWhere((prod){
      return prod.id == id;
    });
  }

  //---- this functions adds new product-----
  Future<void> addProduct(Product product){
    const url = "https://epasal-bf0f2.firebaseio.com/products.json";
  //  const test = "http://ip.jsontest.com/";
  //  http.Response response= await http.get(test);
  //  print(response.body);

    return http.post(url,
    body: json.encode({
      'title': product.title,
      'price': product.price,
      'description': product.description,
      'imgUrl': product.imgUrl,
      'isFavourite': product.isFavourite,
    }))
        //-----then uses future so that it represent that the system is adding data
      .then((response){
      print(json.decode(response.body));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          description: product.description,
          imgUrl: product.imgUrl);
      _items.add(newProduct);

      //  _items.insert(0, newProduct); to add new product at particular index
      notifyListeners();
    })
    // -----if we get an error while posting data---
        .catchError((error){
          print(error);
          throw error;
        });

  }

  //------this functions update the current product-----
  void updateProduct(String id, Product updatedProduct){
    final prodIndex = _items.indexWhere((prod)=>prod.id == id);
    if (prodIndex>=0){
      _items[prodIndex]= updatedProduct;
      notifyListeners();
    }
  }

  //----- this function delets the product-----
  void deleteProduct(String id){
    _items.removeWhere((prod)=> prod.id == id);
    notifyListeners();
  }
}
