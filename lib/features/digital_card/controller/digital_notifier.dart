
import 'package:blizerpay/core/utils.dart';
import 'package:blizerpay/features/digital_card/repository/ditgital_card_repository.dart';
import 'package:blizerpay/features/digital_card/screens/payment_success+screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DigitalPostNotifier extends StateNotifier<bool>{
  final DigitalCardRepository digitalCardRepository;
  DigitalPostNotifier(this.digitalCardRepository):super(false);
  Future postDigitalCardPurchase(int? quantity,int? token,BuildContext context)async{
    final response=await digitalCardRepository.postPayment(quantity!, token!,context);
    if(!response.containsKey("error")){
      // log("response===> payment$response");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const PaymentSucessScreenDigitalCard(),));
    }else if(response["error"]=="Insufficient balance"){
      Utile.showSnackBarI(context, "Insufficient balance", false);
    }else{
      Utile.showSnackBarI(context, "Something went wrong", false);
    }
  }
}