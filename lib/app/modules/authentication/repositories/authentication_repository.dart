import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/native_imp.dart';
import 'package:noxi/app/constants.dart';
import 'package:noxi/app/models/user_model.dart';

class SignUpEvent {
  bool isLoading;
  bool hasSucceed;
  bool hasFailed;
  bool message;
  
  SignUpEvent({this.isLoading, this.hasFailed, this.hasSucceed, this.message});
}

class LoginEvent {
  bool isLoading;
  bool hasSucceed;
  bool message;

  LoginEvent({this.isLoading, this.hasSucceed, this.message});
}

class CurrentUserEvent {
  bool isLoading;
  bool hasSucceed;
  bool message;
  UserModel user;

  CurrentUserEvent({this.isLoading, this.user, this.hasSucceed, this.message});
}

class AuthenticationRepository extends Disposable {
  final DioForNative client;

  FirebaseAuth _auth = FirebaseAuth.instance;

  AuthenticationRepository(this.client) {
    client.options.baseUrl = API;
  }
  
  Future<SignUpEvent> signUp(Map<String, dynamic> data) async {
    try {
      Response response = await client.post("/api/user/create", data: jsonEncode(data));
      if(response.statusCode == 201) {
        print(response.data['data']);
        return SignUpEvent(isLoading: false, hasSucceed: true);
      } else {
        return SignUpEvent(isLoading: false, hasSucceed: true);
      }
    } catch(error) {
      return SignUpEvent(isLoading: false, hasSucceed: false);
    }
  }

  Future<CurrentUserEvent> getUser() async {
    FirebaseUser _user = await _auth.currentUser();
    IdTokenResult _IdToken = await _user.getIdToken();

    try {
      Response response = await client.get("/api/user", options: Options(
          headers: {
            "Authorization": "Bearer ${_IdToken.token}",
            "Content-Type": "application/json"
          }
      ));

      if(response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data['data']);
        return CurrentUserEvent(isLoading: false, user: user, hasSucceed: true);
      } else {
        return CurrentUserEvent(isLoading: false, hasSucceed: false);
      }
    } catch(error) {
      print(error);
      return CurrentUserEvent(isLoading: false, hasSucceed: false);
    }
  }

  Future<LoginEvent> login(String email, password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(result);
      return LoginEvent(isLoading: false, hasSucceed: true);
    } catch(error) {
      print(error);
      return LoginEvent(isLoading: false, hasSucceed: false);
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
