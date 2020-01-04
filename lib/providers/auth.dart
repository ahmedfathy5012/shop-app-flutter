import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signUp(String email, String password) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDEJIOAN3rAxSY_hI-UiH1OxhfzWAGDZgE';
    final response = await http.post(url,
        body: json.encode(
            {
              'email': email,
              'password': password,
              'returnSecureToken': true
            }
            ),
    );
    print(json.decode(response.body));
  }
}
