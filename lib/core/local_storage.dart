
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences _sharedPreferences;

  Future<void> setLogInStatus(bool status) async {
    _sharedPreferences = await SharedPreferences.getInstance();
 await _sharedPreferences.setBool('kisLoggedIn', status);
  }

  Future<void> setToken(String? token) async {
    _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('TOKEN', token??"");
  }

  Future<String> getToken() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final token =  _sharedPreferences.getString('TOKEN');
    return token ?? "";
  }

  Future<void> setOtp(String? otp) async {
    _sharedPreferences = await SharedPreferences.getInstance();
  await _sharedPreferences.setString('OTP', otp??"");
    
  }

  Future<String> getOtp() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? otp = _sharedPreferences.getString('OTP');

    return otp ?? "";
  }

  Future<bool> getLogInStatus() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    bool? loginStatus = _sharedPreferences.getBool('kisLoggedIn');
    return loginStatus ?? false;
  }

  Future<void> clearLogInStatus() async {
    _sharedPreferences = await SharedPreferences.getInstance();
   await LocalStorage().setUserName("");
   await LocalStorage().setLogInStatus(false);
   await LocalStorage().setToken("");
  }

  Future<void> setWalletNumber(String? walletNumber) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('WALLETNUMBER', walletNumber??"");
  }

  Future<String> getWalletNumber() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? walletnumber = _sharedPreferences.getString('WALLETNUMBER');
    return walletnumber ?? "";
  }
  Future<void>setUserName(String? userName)async{
   _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('USERNAME', userName??"");
  }
  Future<String> getUserName() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? userName = _sharedPreferences.getString('USERNAME');
    return userName ?? "";
  }
  Future<void>setUserID(String? userId)async{
   _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('USERID', userId??"");
  }
  Future<void>setReferalCode(String? referal)async{
   _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('REFERAL', referal??"");
  }
  Future<String> getReferalCode() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? userName = _sharedPreferences.getString('REFERAL');
    return userName ?? "";
  }
  Future<String> getUserID() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? userName = _sharedPreferences.getString('USERID');
    return userName ?? "";
  }
}
