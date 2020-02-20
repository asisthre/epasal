import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(DateTime.now()),
      direction: DismissDirection.endToStart,
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
                child: FittedBox(child: Text("\$1000")),
              ),
            ) ,
            title: Text("Watch"),
            subtitle: Text("Total Price: \$100"),
            trailing: Text("2x"),
          ),
        ),
      ),
    );
  }
}
