import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/splash_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
          value: Auth()),

      ChangeNotifierProxyProvider<Auth,Products>(
          update:(context,auth,previousProducts)=>Products(auth.token,auth.userId,previousProducts==null ? [] : previousProducts.items),
      ),

      ChangeNotifierProvider.value(
          value: Cart()),

      ChangeNotifierProxyProvider<Auth,Orders>(
       update:(context,auth,previousProducts)=>Orders(auth.token,auth.userId,previousProducts==null ? [] : previousProducts.orders)),
    ],
      //builder: (context)=>Products(),
      child: Consumer<Auth>(builder: (context,auth,_)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato' ,
        ),
        home: auth.isAuth? ProductsOverviewScreen() : FutureBuilder(
          future: auth.tryAutoLogin(),
          builder: (context,authResultSnapshot)=> authResultSnapshot.connectionState == ConnectionState.waiting ?  SplashScreen() : AuthScreen(),
        ),
        routes: {
          ProductDetailScreen.routeName: (context)=> ProductDetailScreen(),
          CartScreen.routName: (context)=> CartScreen(),
          OrdersScreen.routeName : (context)=> OrdersScreen(),
          UserProductScreen.routeName: (context)=> UserProductScreen(),
          EditProductScreen.routName : (context)=> EditProductScreen(),
          AuthScreen.routeName : (context)=> AuthScreen(),
        },
      ),)
    );
  }
}


