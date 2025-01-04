import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/themes/globals.dart';
class TeamBSettingsScreen extends StatelessWidget {
  const TeamBSettingsScreen({super.key});

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
      body: Center(child: Text("${selectedDifs.toString()} ${aviableSelections.toString()} ${selectedTime.toString()} ${aviablePoints.toString()} "))
    );
  }
}