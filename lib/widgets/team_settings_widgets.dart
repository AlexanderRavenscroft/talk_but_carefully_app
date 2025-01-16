import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/themes/globals.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/provider.dart';
import 'package:gadajaleostroznie/screens/game_screen.dart';

// Widget for the team name text input
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
      onChanged: onChanged,
    );
  }
}

// Widget to render the background color with an SVG image
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
        bool isToggled = context.watch<ToggleProvider>().isToggled;
        return Container(
          color: isToggled ? teamBColor : teamAColor,
        );
      },
    );
  }
}

// Widget to toggle between teams
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
                context.read<ToggleProvider>().toggle();
              });
              refreshProvider.refreshPage();
            },
          ),
        );
      },
    );
  }
}

// Screen to manage the list of players
class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({super.key, required this.players});
  final List<String> players;

  @override
  PlayerListScreenState createState() => PlayerListScreenState();
}

class PlayerListScreenState extends State<PlayerListScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addPlayer() {
    setState(() {
      widget.players.add('Gracz ${widget.players.length + 1}');
    });
  }

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
              onPressed: () => Navigator.pop(context),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
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
                          color: AppColors.neutralColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => _editPlayer(index),
                              child: Text(
                                widget.players[index],
                                style: TextStyle(color: AppColors.textColor, fontSize: 18.0),
                              ),
                            ),
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
              Spacer(flex: 1),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all((MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.022),
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
                child: Icon(Icons.add, size: 40, color: AppColors.textColor),
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
                child: Icon(Icons.arrow_forward, size: 40, color: AppColors.textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget for selecting team colors
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
                  if (teamBselectedIndex != index && teamAselectedIndex != index) {
                    teamBselectedIndex = index;
                    teamBColor = colorSelectionList[index];
                    widget.selectedIndex = index;
                  }
                } else {
                  if (teamAselectedIndex != index && teamBselectedIndex != index) {
                    teamAselectedIndex = index;
                    teamAColor = colorSelectionList[index];
                    widget.selectedIndex = index;
                  }
                }
                Provider.of<RefreshProvider>(context, listen: false).refreshPage();
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
                  border: Border.all(
                    color: widget.selectedIndex == index
                        ? (isToggled
                            ? (teamAselectedIndex == index ? AppColors.textColor : AppColors.primaryColor)
                            : (teamBselectedIndex == index ? AppColors.textColor : AppColors.primaryColor))
                        : AppColors.textColor,
                    width: 4,
                  ),
                ),
                child: Icon(
                  isToggled
                      ? (teamAselectedIndex == index ? Icons.do_disturb : null)
                      : (teamBselectedIndex == index ? Icons.do_disturb : null),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
