import 'package:epasal/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final double price;
  final int quantity;

  CartItem({this.id, this.title, this.productId, this.price, this.quantity});

  @override
  Widget build(BuildContext context) {
    final cartItem= Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(DateTime.now()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        cartItem.removeFromCart(productId);
      },
      confirmDismiss: (direction){
       return showDialog(context: context, builder: (ctx){
          return AlertDialog(
            title: Text('Are you sure to delete'),
            content: Text('Do you want to remove from cart'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'
                ),
                onPressed: (){
                  Navigator.pop(context,false);
                },
              ),
              FlatButton(
                child: Text('Yes'
                ),
                onPressed: (){
                  Navigator.pop(context,true);
                },
              )
            ],
          );
        });
      },
      background: Container(
        color: Colors.red,
        child: Icon(Icons.delete,
        color: Colors.white,),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
        padding: EdgeInsets.all(20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(child: Text("\$ $price")),
              ),
            ) ,
            title: Text(title),
            subtitle: Text("Total Price:\$${ price* quantity}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
