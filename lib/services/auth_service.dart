import 'package:benfica_social/providers/auth_provider.dart';
import 'package:benfica_social/services/base_service.dart';
import 'package:benfica_social/utils/consts.dart';
import 'package:get/get.dart';

class AuthService extends BaseService{


  Future login(String email, String password,) async {
    try {
      var res = await post(
          'auth/login', {"email": email, "password": password});
          
      return res;
    } catch (e) { 
     throw e;
    }
  }
  Future register(String username,String email, String password,) async {
    try {
      var res = await post(
          'auth/register', {"username":username,"email": email, "password": password});
      return res;
    } catch (e) { 
     throw e;
    }
  }
  updateUser({ dataToupdate}) async {
    try {
    var user=await getuserFromStorage();
    var res=await post('auth/updateUser', dataToupdate);

      Constants.showTaost(msg:  res['message']);
      await AuthProvider().setUserToStorage(res);
      Get.back();

    } catch (e) {
      Constants.showTaost(msg: resolveException(e));
    }
  }
}