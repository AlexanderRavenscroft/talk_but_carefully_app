import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/themes/globals.dart';

class ColorBG extends StatefulWidget {
  const ColorBG({super.key});
  @override
  ColorBGState createState() => ColorBGState();
}

class ColorBGState extends State<ColorBG> {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/background-circles.svg', 
       fit: BoxFit.cover,  
   //    color: teamAColor,
    );
  }
}

class TeamSwitch extends StatefulWidget {
  const TeamSwitch({super.key});
  @override
  State<TeamSwitch> createState() => TeamSwitchState();
}

class TeamSwitchState extends State<TeamSwitch> {

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Switch(
        activeColor: AppColors.accentColor,  
        inactiveThumbColor: AppColors.accentColor, 
        inactiveTrackColor: teamAColor, 
        activeTrackColor: teamBColor,  

        value: areTeamBSettings,
        onChanged: (value) {
          setState(() {
            areTeamBSettings = value;
          });
        },
      ),
    );   
  }
}

class TeamNameTextArea extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const TeamNameTextArea({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppColors.textColor,
      textAlign: TextAlign.center,
      style: AppTypography.descBoldStyle.copyWith(
        fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.018,
      ),
      decoration: InputDecoration(
        hintText: controller.text,
      ),
      onChanged: onChanged, // Directly update the values in the parent widget
    );
  }
}





class ColorSelection extends StatefulWidget {
  const ColorSelection({super.key});

  @override
  State<ColorSelection> createState() => _ColorSelectionState();
}

class _ColorSelectionState extends State<ColorSelection> {
  final List<int> colorSelectionList = [
    0xFFEB545D,
    0xFF62BAF3,
    0xFF6DE5B5,
    0xFFAA54EA,
    0xFFF3D677
  ];
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(colorSelectionList.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index; 
              teamAColor = Color(colorSelectionList[index]); // Update teamAColor
              print(teamAColor.value.toRadixString(16).toUpperCase());
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
              horizontal: MediaQuery.of(context).size.width * 0.02,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.075,
              decoration: BoxDecoration(
                color: Color(colorSelectionList[index]),
                border: Border.all(
                  color: selectedIndex == index
                      ? Colors.orange
                      : Colors.transparent,
                      width: 3,
                ),
                borderRadius: BorderRadius.circular(14), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}