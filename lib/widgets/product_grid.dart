import 'package:epasal/provider/products_provider.dart';
import 'package:epasal/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool isShowFavourite;

  ProductGrid({this.isShowFavourite});

  @override
  Widget build(BuildContext context) {
    final productProvider= Provider.of<Products>(context);
    final loadedProduct =
        isShowFavourite ? productProvider.favourites : productProvider.items;
    return GridView.builder(
      itemCount: loadedProduct.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3/2
      ),
      itemBuilder: (ctx,i){
        return ChangeNotifierProvider.value(
          value: loadedProduct[i],
          child: ProductItem(),
        );
      },
    );
  }
}
