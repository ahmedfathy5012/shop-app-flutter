import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
   // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
        builder: (context , dataSnapShot){
          if(dataSnapShot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            if(dataSnapShot.error != null){
              // Do error handle staff
              return Center(child: Text('An Error Occured!'),);
            }else{
              return Consumer<Orders>(
                builder: (context,orderData,child)=>ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx,i)=>OrderItem(orderData.orders[i]),
                ),
              );
            }
          }
        }
      ),
    );
  }
}






