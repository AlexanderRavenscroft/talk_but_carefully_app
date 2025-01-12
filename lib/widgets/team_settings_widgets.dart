// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/themes/globals.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/provider.dart';
import 'package:gadajaleostroznie/screens/game_screen.dart';

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


class ColorBG extends StatefulWidget {
  const ColorBG({super.key});

  @override
  ColorBGState createState() => ColorBGState();
}

class ColorBGState extends State<ColorBG> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RefreshProvider>(
      builder: (context, refreshProvider, child) {
        // The widget rebuilds when RefreshProvider notifies listeners
        bool isToggled = context.watch<ToggleProvider>().isToggled;

        return SvgPicture.asset(
          'assets/images/background-circles.svg', 
          fit: BoxFit.cover,  
          colorFilter: ColorFilter.mode(
            isToggled ? teamBColor : teamAColor,
            BlendMode.srcIn,
          ),
        );
      },
    );
  }
}

class TeamSwitch extends StatefulWidget {
  const TeamSwitch({super.key, required this.teamSelectedColor});
  final Color teamSelectedColor;
  @override
  State<TeamSwitch> createState() => TeamSwitchState();
}

class TeamSwitchState extends State<TeamSwitch> {

  @override
  Widget build(BuildContext context) {
    return Consumer<RefreshProvider>(
      builder: (context, refreshProvider, child) {
        // The widget rebuilds when RefreshProvider notifies listeners
        return Transform.scale(
          scale: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.0012,
          child: Switch(
            activeColor: widget.teamSelectedColor == TeamColors.teamYellowColor ? AppColors.textColor : AppColors.accentColor,
            inactiveThumbColor: widget.teamSelectedColor == TeamColors.teamYellowColor ? AppColors.textColor : AppColors.accentColor,
            inactiveTrackColor: teamAColor,
            activeTrackColor: teamBColor,
            value: context.watch<ToggleProvider>().isToggled,
            onChanged: (value) {
              setState(() {
                context.read<ToggleProvider>().toggle(); // Toggle the state
              });
              // Trigger the refresh from RefreshProvider when the switch changes
              refreshProvider.refreshPage(); // Call the refresh method
            },
          ),
        );
      },
    );
  }
}





class PlayerListScreen extends StatefulWidget {

  const PlayerListScreen({super.key, required this.players});
    final List<String> players;

  @override
  PlayerListScreenState createState() => PlayerListScreenState();
}

class PlayerListScreenState extends State<PlayerListScreen> {
  final TextEditingController _controller = TextEditingController();

  // Function to add a player
  void _addPlayer() {
    setState(() {
      // if (isToggled) {
        widget.players.add('Gracz ${widget.players.length + 1}');
      // } else {
      //   playersB.add('Gracz ${playersB.length + 1}');
      // }
    });
  }

  // Function to update the player's nickname
  void _editPlayer(int index) {
    _controller.text = widget.players[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wpisz imię gracza ${widget.players.length + 1}'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Nowe imię'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Anuluj'),
            ),

            TextButton(
              onPressed: () {
                setState(() {
                  widget.players[index] = _controller.text;
                });
                Navigator.pop(context);
              },
              child: Text('Zapisz'),
            ),
          ],
        );
      },
    );
  }

  // Function to remove a player
  void _removePlayer(int index) {
    setState(() {
      widget.players.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

  return Column(
    children: [
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align the list to the top
          children: [
            // Main content (List of players)
            Expanded(
              flex: 3, // Adjust this flex to control the width of the list
              child: ListView.builder(
                itemCount: widget.players.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: MediaQuery.of(context).size.height * 0.008,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: AppColors.neutralColor, // Background color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Player Name
                          GestureDetector(
                            onTap: () => _editPlayer(index),
                            child: Text(
                              widget.players[index],
                              style: TextStyle(color: AppColors.textColor, fontSize: 18.0),
                            ),
                          ),
                          // Remove Player Button (X)
                          IconButton(
                            icon: Icon(Icons.cancel, color: AppColors.textColor),
                            onPressed: () => _removePlayer(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Empty space on the right
            Spacer(flex: 1), // Adjust this flex to control the empty space
          ],
        ),
      ),
      // Button to add a new player, always at the bottom
      Padding(
        padding: EdgeInsets.all(
          (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.022,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _addPlayer,
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(10.0),
                shadowColor: WidgetStateProperty.all(Colors.black),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                minimumSize: WidgetStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width * 0.25,
                    MediaQuery.of(context).size.height * 0.08,
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              child: Icon(
                Icons.add,
                size: 40,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.08),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(10.0),
                shadowColor: WidgetStateProperty.all(Colors.black),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                minimumSize: WidgetStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width * 0.5,
                    MediaQuery.of(context).size.height * 0.08,
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 40,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    ],
  );
  }
}

class ColorPickerWidget extends StatefulWidget {
    ColorPickerWidget({super.key, required this.teamSelectedColor, required this.selectedIndex});
    Color teamSelectedColor; 
    int selectedIndex;

  @override
  State<ColorPickerWidget> createState() => ColorPickerWidgetState();
}

class ColorPickerWidgetState extends State<ColorPickerWidget> {
    final List<Color> colorSelectionList = [
      TeamColors.teamRedColor, 
      TeamColors.teamBlueColor, 
      TeamColors.teamGreenColor,
      TeamColors.teamPurpleColor,
      TeamColors.teamYellowColor,
    ];

  @override
  Widget build(BuildContext context) {
    bool isToggled = context.watch<ToggleProvider>().isToggled;
    return Container(
      width: 150, 
      height: 400, 
      color: AppColors.neutralColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: List.generate(colorSelectionList.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
if (isToggled) {
      // Update global values for Team B
      if (teamBselectedIndex != index) {
        teamBselectedIndex = index;
        teamBColor = colorSelectionList[index];
      }
    } else {
      // Update global values for Team A
      if (teamAselectedIndex != index) {
        teamAselectedIndex = index;
        teamAColor = colorSelectionList[index];
      }
    }
    widget.selectedIndex = index;
debugPrint(index.toString());
Provider.of<RefreshProvider>(context, listen: false).refreshPage();
//////////////////////


              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.015,
              ),
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: colorSelectionList[index],  
                  border: Border.all(color: widget.selectedIndex == index ? AppColors.primaryColor : AppColors.textColor,
                  width: 4,
                  ),
                ),        
                
              ),
            ),
          );
        }),
      ),
    );
  }
}
