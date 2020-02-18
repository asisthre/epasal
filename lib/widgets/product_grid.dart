import 'package:epasal/provider/products_provider.dart';
import 'package:epasal/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Products>(context).items;
    return GridView.builder(
      itemCount: loadedProduct.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3/2
      ),
      itemBuilder: (ctx,i){
        return Consumer<Products>(
          builder: (key, builder,_){
            return ChangeNotifierProvider.value(
              value: loadedProduct[i],
              child: ProductItem(),
            );
          }
        );
      },
    );
  }
}
