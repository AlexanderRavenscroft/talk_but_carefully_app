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
    bool isToggled = context.watch<ToggleProvider>().isToggled;
    return SvgPicture.asset(
      'assets/images/background-circles.svg', 
       fit: BoxFit.cover,  
       colorFilter:  ColorFilter.mode(
       isToggled ? TeamColors.teamBlueColor : TeamColors.teamRedColor,
       BlendMode.srcIn, 
      ),
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
      scale: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.0012,
      child: Switch(
        activeColor: AppColors.accentColor,  
        inactiveThumbColor: AppColors.accentColor, 
        inactiveTrackColor: teamAColor, 
        activeTrackColor: teamBColor,  
        value: context.watch<ToggleProvider>().isToggled,
        onChanged: (value) {
          setState(() {
             context.read<ToggleProvider>().toggle(); // Toggle the state
          });
        },
      ),
    );   
  }
}





class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({super.key});
  @override
  PlayerListScreenState createState() => PlayerListScreenState();
}

class PlayerListScreenState extends State<PlayerListScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> players = [];
  // Function to add a player
  void _addPlayer() {
    setState(() {
      players.add('Gracz ${players.length + 1}');
    });
  }

  // Function to update the player's nickname
  void _editPlayer(int index) {
    _controller.text = players[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wpisz imię gracza ${players.length + 1}'),
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
                  players[index] = _controller.text;
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
      players.removeAt(index);
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
                itemCount: players.length,
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
                              players[index],
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

