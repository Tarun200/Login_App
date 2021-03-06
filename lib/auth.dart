import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'http_exception.dart';
class Authentication with ChangeNotifier
{
  Future<void> signUp(String email, String password) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key= AIzaSyAlpN2E68rkalztAmPG3NQZ4cbwhmVhC4g';
    try{
      final response = await http.post(Uri.parse(url), body: json.encode(
          {
            'email' : email,
            'password' : password,
            'returnSecureToken' : true,

          }
      ));
      final responseData = json.decode(response.body);
      //print(responseData);
      if(responseData['error'] != null)
      {
        throw HttpException(responseData['error']['message']);
      }

    }
    catch(error)
    {
      throw error;
    }

  }
  Future<void> logIn(String email, String password) async
  {
    const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key= AIzaSyAlpN2E68rkalztAmPG3NQZ4cbwhmVhC4g';
    try {
      final response = await http.post(Uri.parse(url), body: json.encode(
          {
            'email' : email,
            'password' : password,
            'returnSecureToken' : true,

          }
      ));
      final responseData = json.decode(response.body);
      //print(responseData);
      if(responseData['error'] != null)
        {
          throw HttpException(responseData['error']['message']);
        }

    }
    catch(error)
    {
      throw error;
    }
    }

  }
