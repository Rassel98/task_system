import 'package:flutter/material.dart';
import 'package:get/get.dart';

showMessage({required String title, required String message, int duration = 2, Color bgColor = Colors.white30}) {
  Get.snackbar(title, message, snackPosition: SnackPosition.TOP, backgroundColor: title == "Error" ? Colors.red : bgColor, duration: Duration(seconds: duration));
}
