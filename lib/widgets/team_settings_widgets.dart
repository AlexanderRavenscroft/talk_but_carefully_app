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
       color: teamAColor,
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
  int selectedIndex = 1; // No selection initially

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
              horizontal: MediaQuery.of(context).size.width * 0.01,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.075,
              decoration: BoxDecoration(
                color: Color(colorSelectionList[index]),
                border: Border.all(
                  color: selectedIndex == index
                      ? AppColors.textColor
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(14), 
              ),
            ),
          ),
        );
      }),
    );
  }
}