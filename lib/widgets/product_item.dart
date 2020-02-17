
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epasal/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String id;

  ProductItem(this.title,this.imgUrl, this.id);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: GridTile(
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, ProductDetails.routeId, arguments: id );
          },
          child:   CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            placeholder: (context, url)=> CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(icon:Icon(Icons.favorite),
          onPressed: (){},
          color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(icon: Icon(Icons.shopping_cart),
          onPressed: (){},
            color: Theme.of(context).accentColor,),
        ),

      ),
    );
  }
}
