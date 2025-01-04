import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/widgets/game_settings_widgets.dart';
import 'package:gadajaleostroznie/screens/teamb_settings_screen.dart';
import 'package:gadajaleostroznie/widgets/team_settings_widgets.dart';

class TeamASettingsScreen extends StatelessWidget {
  const TeamASettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      // APPBAR
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        toolbarHeight: (MediaQuery.of(context).size.height) * 0.08,
        title: Image.asset(
            'assets/images/logo.png', 
            height: (MediaQuery.of(context).size.height) * 0.07,
            width: (MediaQuery.of(context).size.width) * 0.4,
          ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textColor, size: (MediaQuery.of(context).size.height) * 0.04),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // BODY
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: ColorBG(),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: (MediaQuery.of(context).size.width) * 0.2,
              height: (MediaQuery.of(context).size.height) * 0.5,
              decoration: BoxDecoration(
                color: AppColors.neutralColor,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ColorSelection(),
                ],
              ),
            ),
          ),
          

          Positioned(
            top: (MediaQuery.of(context).size.height) * 0.76,
            child: NextSettingsButton(nextScreenWidget: TeamBSettingsScreen()),
          ),
        ],
      ),
    );
  }
}