import 'dart:developer';

import 'package:flutter/material.dart';

class Utile{
  static Map<String, dynamic> handleRegistrationErrorResponse(int? statusCode, dynamic data) {
    log("errrot statucode $statusCode");
    if (statusCode == 400) {
      return {"error": "invalid email format"};
    } else if (statusCode == 409) {
      return {"error": "User alredy exist"};
    } else {
      return {"error": "Unexpected error. Please try again."};
    }
  }
  static Map<String, dynamic> handleVerificatioErrorResponse(int? statusCode, dynamic data) {
    log("errrot statucode $statusCode");
    if (statusCode == 400) {
      return {"error": "invalid or expired otp"};
    } else if (statusCode == 404) {
      return {"error": "User not found"};
    } else {
      return {"error": "Unexpected error. Please try again."};
    }
  }
  static Map<String, dynamic> handleSignInErrorResponse(int? statusCode, dynamic data) {
    log("errrot statucode $statusCode");
    if (statusCode == 400) {
      return {"error": "Enter your email and password"};
    }else if(statusCode==401){
      return{"error":"Incorrect password"};
    } else if (statusCode == 404) {
      return {"error": "User not found"};
    }
    else if (statusCode == 403) {
      return {"error": "User blocked or unverified"};
    } else {
      return {"error": "Unexpected error. Please try again."};
    }
  }
  static Map<String, dynamic> handleSendOtpErrorResponse(int? statusCode, dynamic data) {
    log("errrot statucode $statusCode");
    if (statusCode == 400) {
      return {"error": "Enter your email and password"};
    }else if(statusCode==403){
      return{"error":"Unverified user"};
    } else if (statusCode == 404) {
      return {"error": "User not found"};
    }
    else {
      return {"error": "Unexpected error. Please try again."};
    }
  }
  static Map<String, dynamic> handleVerificationForgotPasswordErrorResponse(int? statusCode, dynamic data) {
    log("errrot statucode $statusCode");
     if(statusCode==403){
      return{"error":"Otp expired"};
    } 
    else {
      return {"error": "Unexpected error. Please try again."};
    }
  }
  static Map<String, dynamic> handleUpdatPasswordErrorResponse(int? statusCode, dynamic data) {
    log("errrot statucode $statusCode");
     if(statusCode==402){
      return{"error":"Error to change password"};
    } 
    else {
      return {"error": "Unexpected error. Please try again."};
    }
  }
 static Map<String, dynamic> handleErrorResponse(int? statusCode, dynamic data) {
    log("errrot statucode $statusCode");
    if (statusCode == 400) {
      return {"error": "Invalid credentials or data."};
    } else if (statusCode == 401) {
      return {"error": "Incorrect password"};
    } else if (statusCode == 404) {
      print("statusCode $statusCode");
      return {"error": "User does not exist"};
    } else if (statusCode == 500) {
      return {"error": "Server error. Please try again later."};
    } else {
      return {"error": "Unexpected error. Please try again."};
    }
  }
 static Future<void> showSnackBarI(BuildContext context, String title, bool isCheck,
      {int milliSeconds = 2000}) async {
    try {
       // Dismiss the keyboard first
  FocusScope.of(context).unfocus();

  // Show the SnackBar at the bottom of the screen
  final snackBar = SnackBar(
    content: Text(title),
    backgroundColor: Colors.red, // Customize color for error
    duration:const Duration(seconds: 3), // Customize the duration
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {}
  }
}