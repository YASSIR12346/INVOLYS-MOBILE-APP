import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const white = Colors.white;
  static const secondary = Color(0xffa6a6a6);
  static const iconGray = Color(0xff767676);
  static const black = Colors.black;
  static const primary = Color(0xff262626);
  static const primaryBg = Color(0xfff5f5fd);
  static const secondaryBg = Color(0xffececf6);
  static const barBg = Color(0xffe3e3ee);
  static const them = Color(0xff00816D);
  static const btn = Color(0xffBCF0AC);


  static const icon = Color(0xff004899);
  static const txtBtn = Color(0xffDDDDDD);
  static const grayT = Color(0xffD9D9D9);


  static const Map<int, Color> color =
  {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };


  static  List<List<Color>> colorsPaletteData=[
    [Color(0xff0293ee),Color(0x7f0293ee)],
    [Color(0xfff8b250),Color(0xfff8b250)],
    [Color(0xff004899),Color(0x7f004899)],
    [Color(0xfff46a9b),Color(0x7ff46a9b)],

    [Color(0xff13d38e),Color(0x7F13d38e)],
    [Color(0xff9E0E9E),Color(0x7F9E0E9E)],
    [Color(0xffffee65),Color(0x7fffee65)],
    [Color(0xffC70039),Color(0x7FC70039)],

    [Colors.black,Colors.black45],
    [Color(0xff414CAA),Color(0x7F414CAA)],
    [Color(0xff33FFDA),Color(0x7F33FFDA)],
    [Color(0xffCEFF33),Color(0x7FCEFF33)],

    [Color(0xffFF0000),Color(0x7fFF0000)],
    [Color(0xff3DD34C),Color(0x7F3DD34C)],
    [Color(0xff581845),Color(0x7f581845)],
    [Color(0xff8BA7BB),Color(0x7f8BA7BB)],




  ];



  static void generateRandomColorPair() {
    final Color color1 = _generateUniqueColor();
    final Color color2 = _generateContrastingColor(color1);

    colorsPaletteData.add([color1, color2]);
  }



  static bool _isColorUnique(Color color) {
    for (final colorPair in colorsPaletteData) {
      if (colorPair[0] == color) {
        return false;
      }
    }
    return true;
  }

  static Color _generateContrastingColor(Color baseColor) {
    final double luminance = (baseColor.red * 0.299 +
        baseColor.green * 0.587 +
        baseColor.blue * 0.114) /
        255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }




  static Color _generateUniqueColor() {
    final Random random = Random();
    Color color;
    bool isUnique;

    do {
      color = Color.fromARGB(
        0xFF,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );

      isUnique = _isColorUnique(color) && _isDifferentFromSpecificColors(color);
    } while (!isUnique);

    return color;
  }

  static bool _isDifferentFromSpecificColors(Color color) {
    final Color specificColor1 = Color(0x7fD3D3D3);
    final Color specificColor2 = Color(0xff182F4F);

    return color != specificColor1 && color != specificColor2;
  }



}
