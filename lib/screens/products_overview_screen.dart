import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOptions{
 Favorites,
 All,
}

class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
//
//  @override
//  void initState() {
//  // Future.delayed(Duration.zero).then((_){Provider.of<Products>(context).fetchAndSetProducts();});
//    super.initState();
//  }

  @override
  void didChangeDependencies() {
    if(_isInit == true) {
      setState(() {
        _isLoading = true ;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_){setState(() {
         _isLoading = false;
        print('done');
      });});
   }
      _isInit = false;


    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    Future<void> _refreshProducts(BuildContext context)async{
      await Provider.of<Products>(context).fetchAndSetProducts();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if(selectedValue == FilterOptions.Favorites){
                  _showOnlyFavorites = true;
                }else{
                  _showOnlyFavorites = false;
                }
              });
            },
              icon: Icon(
                Icons.more_vert
              ),
              itemBuilder: (_)=>[
                PopupMenuItem(child: Text('Only Favorites'),value: FilterOptions.Favorites,),
                PopupMenuItem(child: Text('Show All'),value: FilterOptions.All,),
              ]
          ),
          
          Consumer<Cart>(
            builder: (_,cart,ch)=>Badge(
                child:ch,
                value: cart.itemsCount.toString(),
            ),
            child: IconButton(
                icon: Icon(
                    Icons.shopping_cart
                ),
                onPressed: (){
                  Navigator.of(context).pushNamed(CartScreen.routName);
                }
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body:RefreshIndicator(
          child: _isLoading ? Center(child: CircularProgressIndicator(),) : ProductsGrid(_showOnlyFavorites),
          onRefresh:()=> _refreshProducts(context))

     // _isLoading ? Center(child: CircularProgressIndicator(),) : ProductsGrid(_showOnlyFavorites),
    );
  }
}
