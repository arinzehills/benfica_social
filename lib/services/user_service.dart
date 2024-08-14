  import 'dart:convert';

import 'package:benfica_social/models/user.dart';
import 'package:benfica_social/services/base_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService extends BaseService {
  // UserService({String? authToken}) : super();


  Future<User?> fetchUser(id) async {
    try {
    var user=await getuserFromStorage();
    var res=await get('user/${user!.id}');
    User newUser = User.fromJson(res['data']);
    return newUser;
    } catch (e) {
        print("ERROR");
        print(e);
    }
  }

  Future followUser() async {
    var user=await getuserFromStorage();
    var res=await post('user/${user!.id}/follow', {});
  }
  
}