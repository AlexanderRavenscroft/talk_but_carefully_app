// All colors and tyography is defined here
import 'package:flutter/material.dart';

//==================[COLORS]==================
class AppColors{
  static const Color primaryColor = Color(0xFFE64833);
  static const Color textColor = Color(0xFF0D1137);
  static const Color accentColor = Color(0xFFFFD700);
  static const Color neutralColor = Color(0xFFD9D9D9);
  static const Color notificationColor = Color(0xFF4CAF50);
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
