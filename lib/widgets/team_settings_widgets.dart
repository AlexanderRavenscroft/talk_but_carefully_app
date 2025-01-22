import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/logic/globals.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/logic/provider.dart';
import 'package:gadajaleostroznie/screens/game_screen.dart';
import '../services/audio_service.dart';

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
              playAudio(optionSwitchSound);
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
        bool isToggled = context.watch<ToggleProvider>().isToggled;
        return AlertDialog(
          title: Text('Wpisz nazwę gracza ${widget.players.length + 1}',
          style: AppTypography.descStyle),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Nowe imię'),
          ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end, 
            spacing: 16,
            children: [
              ElevatedButton(
                onPressed: () {Navigator.pop(context); playAudio(tapSound);},
                style: ElevatedButton.styleFrom(
                  backgroundColor:isToggled ? teamBColor : teamAColor,
                  elevation: 6,
                  padding: EdgeInsets.symmetric(vertical: (MediaQuery.of(context).size.height * 0.02), horizontal: (MediaQuery.of(context).size.width * 0.05)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))), 
                ),
                child: Text(
                  'Anuluj',
                  style: AppTypography.descBoldStyle.copyWith(fontSize: MediaQuery.of(context).size.height * 0.01 + MediaQuery.of(context).size.height * 0.01),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.players[index] = _controller.text;
                  });
                  Navigator.pop(context);
                  playAudio(optionSwitchSound);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:isToggled ? teamBColor : teamAColor,
                  elevation: 6,
                  padding: EdgeInsets.symmetric(vertical: (MediaQuery.of(context).size.height * 0.02), horizontal: (MediaQuery.of(context).size.width * 0.05)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
                child: Text(
                  'Zapisz',
                  style: AppTypography.descBoldStyle.copyWith(fontSize: MediaQuery.of(context).size.height * 0.01 + MediaQuery.of(context).size.height * 0.01),
                ),
              ),
            ],
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
                        horizontal: MediaQuery.of(context).size.width * 0.08,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.04, 
                          top: MediaQuery.of(context).size.height * 0.014, 
                          bottom: MediaQuery.of(context).size.height* 0.014, 
                          ),
                        decoration: BoxDecoration(
                          color: AppColors.neutralColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                            onTap: () {_editPlayer(index);},
                              child: Text(
                                widget.players[index],
                                style: TextStyle(color: AppColors.textColor, fontSize: MediaQuery.of(context).size.height * 0.018 + MediaQuery.of(context).size.width * 0.018),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel, size: MediaQuery.of(context).size.height * 0.022 + MediaQuery.of(context).size.width * 0.022, color: AppColors.textColor),
                              onPressed: () {_removePlayer(index); playAudio(tapSound);},
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
                onPressed: () {_addPlayer(); playAudio(tapSound);},
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
                child: Icon(Icons.add, size: MediaQuery.of(context).size.height*0.04 + MediaQuery.of(context).size.width *0.04, color: AppColors.textColor),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.08),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                  playAudio(tapSound);
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
                child: Icon(Icons.arrow_forward, size: MediaQuery.of(context).size.height*0.04 + MediaQuery.of(context).size.width *0.04, color: AppColors.textColor),
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
      width: (MediaQuery.of(context).size.width) * 0.25,
      height: (MediaQuery.of(context).size.height) * 0.5,
      decoration: BoxDecoration(
        color: AppColors.neutralColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)), 
        boxShadow: [BoxShadow(color: Colors.black, offset: const Offset(-1, 2), blurRadius: 6)]
      ),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(colorSelectionList.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isToggled) {
                  if (teamBselectedIndex != index && teamAselectedIndex != index) {
                    teamBselectedIndex = index;
                    teamBColor = colorSelectionList[index];
                    widget.selectedIndex = index;
                    playAudio(optionChoiceSound);
                  }
                } else {
                  if (teamAselectedIndex != index && teamBselectedIndex != index) {
                    teamAselectedIndex = index;
                    teamAColor = colorSelectionList[index];
                    widget.selectedIndex = index;
                    playAudio(optionChoiceSound);
                  }
                }
                Provider.of<RefreshProvider>(context, listen: false).refreshPage();
              });  
            },
            child: Container(
                width: (MediaQuery.of(context).size.width) * 0.16,
                height: (MediaQuery.of(context).size.height) * 0.084,
                decoration: BoxDecoration( 
                  color: colorSelectionList[index],
                  boxShadow: [BoxShadow(color: Colors.black,  blurRadius: 2)],
                  borderRadius: BorderRadius.all(Radius.circular(10)),               
                  border: Border.all(
                    color: widget.selectedIndex == index
                        ? (isToggled
                            ? (teamAselectedIndex == index ? Colors.transparent : AppColors.textColor)
                            : (teamBselectedIndex == index ? Colors.transparent : AppColors.textColor))
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Icon(
                  size: (MediaQuery.of(context).size.height) * 0.01 + (MediaQuery.of(context).size.width) * 0.06,
                  color: AppColors.textColor,
                  isToggled
                      ? (teamAselectedIndex == index ? Icons.do_disturb : null)
                      : (teamBselectedIndex == index ? Icons.do_disturb : null),
                ),
              ),
          );
        }),
      ),
    );
  }
}
