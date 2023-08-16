import 'package:flutter/material.dart';

abstract class Engine {
  
  static void showSnackbar(BuildContext context,
      {String title = 'Aviso!',
      String message = 'Erro ao realizar operação. Tente mais tarde!',
      Color? backgroundColor,
      Icon? icon,
      Color colorText = Colors.white,
      Color iconColor = Colors.white}) {
    Icon _icon = Icon(Icons.warning, color: iconColor);

    if (icon != null) {
      _icon = Icon(
        icon.icon,
        color: iconColor,
      );
    }
      final snackBar = SnackBar(content: Text(message));
               
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    /*Get.snackbar(
      title,
      message,
      icon: _icon,
      snackPosition: SnackPosition.BOTTOM,
      //backgroundColor:
      //    backgroundColor ?? CustomColors.appPrimaryColor.withOpacity(.9),
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: colorText,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.down,
      forwardAnimationCurve: Curves.easeOutBack,
    );*/
  }
}
