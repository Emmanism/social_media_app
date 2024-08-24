import 'package:flutter/material.dart';
import 'dart:math';


abstract class Helpers {
  static final random = Random();
 

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/500/500?random=$randomInt';


  }

  static DateTime randomDate() {
    final random = Random();
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }
}
