import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoadingWidget extends StatelessWidget {
   LoadingWidget({super.key,required this.isLoading});
 bool? isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      
          Positioned.fill(
            child: AbsorbPointer(
              absorbing:isLoading! , 
              child: Stack(
                children: [
                  ModalBarrier(
                    color: Colors.black.withOpacity(0.3),
                    dismissible: false,
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}