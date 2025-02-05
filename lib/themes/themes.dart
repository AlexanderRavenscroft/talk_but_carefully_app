//This file uses icons from multiple sources, licensed under the following:
// - Font Awesome 4: SIL Open Font License (http://scripts.sil.org/OFL)
// - Iconic: SIL Open Font License (http://scripts.sil.org/OFL)
// - Material Design Icons: Apache 2.0 (https://www.apache.org/licenses/LICENSE-2.0)
// - Entypo: SIL Open Font License (http://scripts.sil.org/OFL)
// - Typicons: SIL Open Font License (http://scripts.sil.org/OFL)
// - RPG Awesome: SIL Open Font License (http://scripts.sil.org/OFL)
// - Font Awesome 5: SIL Open Font License (https://github.com/FortAwesome/Font-Awesome/blob/master/LICENSE.txt)

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
  static const String secondaryFont = 'SF Pro Display';

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

  static const IconData ok = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData cancel = IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowCurved = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData settings = IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowsCcw = IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData docText = IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData pause = IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData tagFaces = IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData sentimentNeutral = IconData(0xe808, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowForward = IconData(0xe809, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowBack = IconData(0xe80a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData personAdd = IconData(0xe80b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData hood = IconData(0xea03, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData hornCall = IconData(0xea04, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData gamepad = IconData(0xf11b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData skull = IconData(0xf54c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData soundON = Icons.volume_up;
  static const IconData soundOFF = Icons.volume_off;
  static const IconData play = Icons.play_arrow;
  static const IconData alreadyTaken = Icons.do_disturb;
  static const IconData remove = Icons.cancel;
}

