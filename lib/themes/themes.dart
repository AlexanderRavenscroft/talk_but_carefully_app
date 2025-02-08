// Icons used in this project are derived from the following sources:
// - Font Awesome 4 (http://fortawesome.github.com/Font-Awesome/)
// - Iconic (http://somerandomdude.com/work/iconic/)
// - Material Design Icons (https://design.google.com/icons/)
// - Entypo (http://www.entypo.com)
// - Typicons (http://typicons.com/)
// - RPG Awesome (http://nagoshiashumari.github.io/Rpg-Awesome/)

import 'package:flutter/material.dart';
//==================[COLORS]==================
class AppColors{
  static const Color primaryColor = Color(0xFFE64833);
  static const Color textColor = Color(0xFF0D1137);
  static const Color accentColor = Color(0xFFFFD700);
  static const Color neutralColor = Color(0xFFD9D9D9);
  static const Color notificationColor = Color(0xFF4CAF50);
  static const Color shadowColor = Color(0xFFA0A0A0);
  static const Color secondTextColor = Color(0xFF555555);
}

class TeamColors{
  static const Color teamRedColor = Color(0xFFEB545D);
  static const Color teamBlueColor= Color(0xFF62BAF3);
  static const Color teamGreenColor = Color(0xFF6DE5B5);
  static const Color teamPurpleColor = Color(0xFFAA54EA);
  static const Color teamYellowColor = Color(0xFFF3D677);
}

//==================[TYPOGRAPHY]==================
class AppTypography {
  static const String primaryFont = 'Bangers';
  static const String secondaryFont = 'Poppins Bold';

  static const TextStyle headingStyle = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.normal, 
    fontStyle: FontStyle.normal,   
    color: AppColors.textColor,
    letterSpacing: 3,
  );

  static const TextStyle buttonStyle = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.normal, 
    fontStyle: FontStyle.normal,   
    color: AppColors.textColor,
  );

  static const TextStyle descStyle = TextStyle(
    fontFamily: secondaryFont,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,   
    color: AppColors.textColor,
  );

  static const TextStyle descBoldStyle= TextStyle(
    fontFamily: secondaryFont,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,   
    color: AppColors.textColor,
  );
}

//==================[Icons]==================
class AppIcons {
  AppIcons._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  // Game Icons
  static const IconData ok = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData cancel = IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowCurved = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowsCcw = IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData pause = IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData play = IconData(0xe811, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  // Main Menu Icons
  static const IconData gamepad = IconData(0xf11b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData docText = IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData settings = IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData soundON = IconData(0xe80f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData soundOFF = IconData(0xe80e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData authors = IconData(0xea03, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData guide = IconData(0xe80d, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData github = IconData(0xf09b, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  // Other screens Icons
  static const IconData arrowForward = IconData(0xe809, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowBack = IconData(0xe80a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData personAdd = IconData(0xe80b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData alreadyTaken = IconData(0xe812, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData remove = IconData(0xe810, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData hornCall = IconData(0xea04, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  
  // Difficulty Icons
  static const IconData easyDiff = IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData mediumDiff = IconData(0xe808, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData hardDiff = IconData(0xe80c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

