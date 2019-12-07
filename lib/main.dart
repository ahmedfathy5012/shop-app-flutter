import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Shop',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato' ,
      ),
      home: ProductsOverviewScreen(),
      routes: {
          ProductDetailScreen.routeName: (context)=> ProductDetailScreen(),
      },
    );
  }
}


