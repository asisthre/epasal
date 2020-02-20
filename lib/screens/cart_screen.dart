import 'package:epasal/provider/cart_provider.dart';
import 'package:epasal/widgets/cart_item.dart'as ci;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeId="/cart_screen";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),),
                  Spacer(),
                  Chip(
                    label: Text("\$100",
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    child: Text("ORDER NOW",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                    ),),
                    onPressed: (){},
                  ),
                ],
              ),

            ),
          ),
          SizedBox(height: 10,),
          Expanded(
              child: ListView.builder(
                  itemCount:3, itemBuilder: (context, i)=> ci.CartItem(),
              ),
          ),
        ],
      ),
    );
  }
}
