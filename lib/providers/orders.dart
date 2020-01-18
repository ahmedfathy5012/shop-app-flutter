import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  final timestamp = DateTime.now();
  List<OrderItem> _orders = [];
  final String authToken;

  Orders(this.authToken,this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://provider-test-4b458.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.get(url);
    print(json.decode(response.body));
    final List<OrderItem> loadedOrders = [];
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    if(extractData ==  null){
      return;
    }
    extractData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        products: (orderData['products'] as List<dynamic>).map((item) {
          CartItem(
              id: item['id'],
              title: item['title'],
              price: item['price'],
              quantity: item['quantity']);
        }).toList(),
        dateTime: DateTime.parse(orderData['dateTime']),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://provider-test-4b458.firebaseio.com/orders.json?auth=$authToken';
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['id'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
