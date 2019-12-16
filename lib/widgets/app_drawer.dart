import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
          title: Text('Shop'),
            leading: Icon(Icons.shop),
            onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
            },
          ),

          ListTile(
            title: Text('Orders'),
            leading: Icon(Icons.payment),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),

          ListTile(
            title: Text('Manage Products'),
            leading: Icon(Icons.edit),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            },
          ),



        ],
      ),
    );
  }
}
