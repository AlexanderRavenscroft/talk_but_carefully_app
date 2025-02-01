// All colors and tyography is defined here
import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';
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

  static const IconData arrowCurved = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData ccw = IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData arrowsCcw = IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData brokenSkull = IconData(0xe94b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData skull = IconData(0xf54c, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  /// Flutter icons MyFlutterApp
  /// Copyright (C) 2025 by original authors @ fluttericon.com, fontello.com
  /// This font was generated by FlutterIcon.com, which is derived from Fontello.
  /// * Iconic, Copyright (C) 2012 by P.J. Onori
  ///         Author:    P.J. Onori
  ///         License:   SIL (http://scripts.sil.org/OFL)
  ///         Homepage:  http://somerandomdude.com/work/iconic/
  /// * Entypo, Copyright (C) 2012 by Daniel Bruce
  ///         Author:    Daniel Bruce
  ///         License:   SIL (http://scripts.sil.org/OFL)
  ///         Homepage:  http://www.entypo.com
  ///
  /// * RPG Awesome, Copyright (c) 2014, Daniela Howe
  ///         Author:    Daniela Howe & Ivan Montiel
  ///         License:   SIL (http://scripts.sil.org/OFL)
  ///         Homepage:  http://nagoshiashumari.github.io/Rpg-Awesome/
}

