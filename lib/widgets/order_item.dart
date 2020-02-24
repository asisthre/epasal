import 'dart:math';
import 'package:flutter/material.dart';
import 'package:epasal/provider/order_provider.dart'as oi;

class OrderItem extends StatefulWidget {
  final oi.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expended=false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text("\$ ${widget.order.amount}"),
            subtitle: Text(""),
            trailing: IconButton(
              icon: _expended? Icon(Icons.expand_less)
                  :Icon(Icons.expand_more),
              onPressed: (){
                setState(() {
                  _expended= !_expended;
                });
              },
            ),
          ),
          if (_expended)
            Container(
              height: min(widget.order.products.length *20.0 + 10.0, 180),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              child: ListView(
                children: widget.order.products.map((prod)=>Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      prod.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18,
                      ),
                    ),
                    Text(
                      '\$ ${prod.quantity}x \$ ${prod.price}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    )
                  ],
                )).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
