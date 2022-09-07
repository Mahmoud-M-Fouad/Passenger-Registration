import 'dart:ui';

import 'package:flutter/material.dart';

TextStyle get headingStyle{
  return  const TextStyle(

    fontSize: 20,
    //fontWeight: FontWeight.bold,
    overflow:TextOverflow.fade ,
    color:Colors.white,
  );
}

TextStyle get subHeadingStyle{
  return  const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color:Colors.white,
  );
}

TextStyle get subHeadingStyleUseTextField{
  return  const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color:Colors.black,
  );
}

TextStyle get subHeadingStyle2{
  return  const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color:Colors.black,
  );
}