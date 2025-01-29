import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';

//====================[DIF SELECTION]====================
class DifSelection extends StatefulWidget {
  const DifSelection({super.key});

  @override
  State<DifSelection> createState() => DifSelectionState();
}

class DifSelectionState extends State<DifSelection> {
  final List<String> difSelectionList = ["łatwe", "średnie", "trudne"];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(difSelectionList.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (GameSettings.aviableDifs.contains(index)) {
                if (GameSettings.aviableDifs.length > 1) {
                  GameSettings.aviableDifs.remove(index);
                }
              } else {
                GameSettings.aviableDifs.add(index);
              }
            });
            playAudio(GameSounds.optionChoiceSound);
          },
          child: Text(
            difSelectionList[index],
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.036,
              color: GameSettings.aviableDifs.contains(index) ? AppColors.primaryColor : AppColors.textColor,
            ),
          ),
        );
      }),
    );
  }
}

//====================[SKIP SELECTION]====================
class SkipSelection extends StatefulWidget {
  const SkipSelection({super.key});

  @override
  State<SkipSelection> createState() => SkipSelectionState();
}

class SkipSelectionState extends State<SkipSelection> {
  final List<String> skipSelectionList = ["0", "5", "10", "15", "∞"];
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(skipSelectionList.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIndex != index) {
                selectedIndex = index;
                GameSettings.aviableSkips = _getSelectionValue(skipSelectionList[index]);
              }
            });
           playAudio(GameSounds.optionChoiceSound);
          },
          child: Text(
            skipSelectionList[index],
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.036,
              color: selectedIndex == index ? AppColors.primaryColor : AppColors.textColor,
            ),
          ),
        );
      }),
    );
  }

  // Exception for infinity:
  int _getSelectionValue(String selection) {
    if (selection == "∞") {
      return 255;
    }
    return int.parse(selection);
  }
}

//====================[TIME SELECTION]====================
class TimeSelection extends StatefulWidget {
  const TimeSelection({super.key});

  @override
  State<TimeSelection> createState() => TimeSelectionState();
}

class TimeSelectionState extends State<TimeSelection> {
  final List<String> timeSelectionList = ["00:10", "1:00", "2:00", "3:00"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(timeSelectionList.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIndex != index) {
                selectedIndex = index;
                GameSettings.aviableTime = _getTimeInSeconds(timeSelectionList[index]);
              }
            });
            playAudio(GameSounds.optionChoiceSound);
          },
          child: Text(
            timeSelectionList[index],
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.036,
              color: selectedIndex == index ? AppColors.primaryColor : AppColors.textColor,
            ),
          ),
        );
      }),
    );
  }

  // Change time to seconds format:
  int _getTimeInSeconds(String time) {
    final parts = time.split(':');
    final minutes = int.parse(parts[0]);
    final seconds = int.parse(parts[1]);
    return (minutes * 60) + seconds;
  }
}

//====================[POINTS SELECTION]====================
class PointsSelection extends StatefulWidget {
  const PointsSelection({super.key});

  @override
  State<PointsSelection> createState() => PointsSelectionState();
}

class PointsSelectionState extends State<PointsSelection> {
  final List<int> pointsSelectionList = [10, 20, 30, 40, 50];
  int selectedIndex = 1;
 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(pointsSelectionList.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIndex != index) {
                selectedIndex = index;
                GameSettings.aviablePoints = pointsSelectionList[index];
              }
            });
          playAudio(GameSounds.optionChoiceSound);
          },
          child: Text(
            pointsSelectionList[index].toString(),
             style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.036,
              color: selectedIndex == index ? AppColors.primaryColor : AppColors.textColor,
            ),
          ),
        );
      }),
    );
  }
}

//====================[OPTIONS CONTAINER]====================
class OptionsSelectionContainer extends StatelessWidget {
  final String optionsText;
  final Widget selectionWidget;
  const OptionsSelectionContainer({super.key, required this.optionsText, required this.selectionWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: BoxDecoration(
            color: AppColors.accentColor,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              optionsText,
              style: AppTypography.descBoldStyle.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.032,
              ),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width) * 0.9,
          height: (MediaQuery.of(context).size.height) * 0.06,
          decoration: BoxDecoration(
            color: AppColors.neutralColor,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: selectionWidget,
        ),
      ],
    );
  }
}

//====================[NEXT BUTTON]====================
class NextSettingsButton extends StatelessWidget {
  final Widget nextScreenWidget;
  const NextSettingsButton({super.key, required this.nextScreenWidget });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  nextScreenWidget));
        playAudio(GameSounds.tapSound);
      },
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(10.0), 
        shadowColor: WidgetStateProperty.all(Colors.black), 
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        fixedSize: WidgetStateProperty.all(Size(
          MediaQuery.of(context).size.width * 0.9,
          MediaQuery.of(context).size.height * 0.08,
        )),

        backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      child: Icon(Icons.arrow_forward, size: MediaQuery.of(context).size.height * 0.05, color: AppColors.textColor),
    );
  }
}
