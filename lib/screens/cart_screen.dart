import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart' ;

class CartScreen extends StatelessWidget {
  static const routName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0,),
          Expanded(child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context,i)=>CartItem(
                 id:cart.items.values.toList()[i].id,
                 productId: cart.items.keys.toList()[i],
                 price:cart.items.values.toList()[i].price,
                 quantity:cart.items.values.toList()[i].quantity,
                 title:cart.items.values.toList()[i].title,
              ),
           ),
          ),
        ],
      ),
    );
  }
}
