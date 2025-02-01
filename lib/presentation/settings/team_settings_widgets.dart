import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/core/provider.dart';
import 'package:gadajaleostroznie/presentation/game/game_screen.dart';
import '../../services/audio_service.dart';

// Widget for the team name text input
class TeamNameTextArea extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const TeamNameTextArea({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 12,
      cursorColor: AppColors.textColor,
      textAlign: TextAlign.center,
      style: AppTypography.descBoldStyle.copyWith(
        fontSize:  MediaQuery.of(context).size.height * 0.03,
      ),
      decoration: InputDecoration(
        counterText: "",
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
          color: isToggled ? teamB.color : teamA.color,
        );
      },
    );
  }
}

// Widget to toggle between teams
class TeamSwitch extends StatefulWidget {
  const TeamSwitch({super.key});

  @override
  State<TeamSwitch> createState() => TeamSwitchState();
}

class TeamSwitchState extends State<TeamSwitch> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<RefreshProvider>(
      builder: (context, refreshProvider, child) {
        return Transform.scale(
          scale: MediaQuery.of(context).size.height * 0.0018,
          child: Switch(
            activeColor: teamB.color == TeamColors.teamYellowColor ? AppColors.textColor : AppColors.accentColor,
            inactiveThumbColor: teamA.color == TeamColors.teamYellowColor ? AppColors.textColor : AppColors.accentColor,
            inactiveTrackColor: teamA.color,
            activeTrackColor: teamB.color,
            value: context.watch<ToggleProvider>().isToggled,
            onChanged: (value) {
              setState(() {
                context.read<ToggleProvider>().toggle();
              });
              refreshProvider.refreshPage();
              playAudio(GameSounds.optionSwitchSound);
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
  final List<Player> players;

  @override
  PlayerListScreenState createState() => PlayerListScreenState();
}

class PlayerListScreenState extends State<PlayerListScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addPlayer() {
    setState(() {
      widget.players.add(Player('Gracz ${widget.players.length + 1}', 0));
    });
  }

  void _editPlayer(int index) {
    _controller.text = widget.players[index].username;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isToggled = context.watch<ToggleProvider>().isToggled;
        return AlertDialog(
          title: Text('Wpisz nazwę gracza ${index + 1}',
          style: AppTypography.descStyle),
          content: TextField(
            maxLength: 12,
            controller: _controller,
            decoration: InputDecoration(hintText: 'Nowe imię'),
          ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end, 
            spacing: 16,
            children: [
              ElevatedButton(
                onPressed: () {Navigator.pop(context); playAudio(GameSounds.tapSound);},
                style: ElevatedButton.styleFrom(
                  backgroundColor:isToggled ? teamB.color : teamA.color,
                  elevation: 6,
                  padding: EdgeInsets.symmetric(vertical: (MediaQuery.of(context).size.height * 0.02), horizontal: (MediaQuery.of(context).size.width * 0.05)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))), 
                ),
                child: Text(
                  'Anuluj',
                  style: AppTypography.descBoldStyle.copyWith(fontSize: MediaQuery.of(context).size.height * 0.02),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.players[index] = Player(_controller.text, 0);
                  });
                  Navigator.pop(context);
                  playAudio(GameSounds.optionSwitchSound);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:isToggled ? teamB.color : teamA.color,
                  elevation: 6,
                  padding: EdgeInsets.symmetric(vertical: (MediaQuery.of(context).size.height * 0.02), horizontal: (MediaQuery.of(context).size.width * 0.05)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                ),
                child: Text(
                  'Zapisz',
                  style: AppTypography.descBoldStyle.copyWith(fontSize: MediaQuery.of(context).size.height * 0.02),
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
                                widget.players[index].username,
                                style: TextStyle(color: AppColors.textColor, fontSize: MediaQuery.of(context).size.height * 0.03),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel, color: AppColors.textColor, size: MediaQuery.of(context).size.height * 0.036),
                              onPressed: () {_removePlayer(index); playAudio(GameSounds.tapSound);},
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
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.015,
            horizontal: MediaQuery.of(context).size.width * 0.025,
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {_addPlayer(); playAudio(GameSounds.tapSound);},
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
                child: Icon(Icons.add, size: MediaQuery.of(context).size.height*0.06, color: AppColors.textColor),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                  playAudio(GameSounds.tapSound);
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
                child: Icon(Icons.arrow_forward, size: MediaQuery.of(context).size.height*0.06, color: AppColors.textColor),
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
  const ColorPickerWidget({super.key});

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
  // Default colorPikcer option choice for each team
  int teamAselectedIndex = 0; 
  int teamBselectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    bool isToggled = context.watch<ToggleProvider>().isToggled;
    return Container(
      width: (MediaQuery.of(context).size.width) * 0.25,
      height: (MediaQuery.of(context).size.height) * 0.5,
      decoration: BoxDecoration(
        color: AppColors.neutralColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24)), 
        boxShadow: [BoxShadow(color: Colors.black, offset: Offset(-1, 2), blurRadius: 6)]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(colorSelectionList.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isToggled) {
                  if (teamBselectedIndex != index && teamAselectedIndex != index) {
                    teamBselectedIndex = index;
                    teamB.color = colorSelectionList[index];
                    playAudio(GameSounds.optionChoiceSound);
                  }
                } else {
                  if (teamAselectedIndex != index && teamBselectedIndex != index) {
                    teamAselectedIndex = index;
                    teamA.color = colorSelectionList[index];
                    playAudio(GameSounds.optionChoiceSound);
                  }
                }
                Provider.of<RefreshProvider>(context, listen: false).refreshPage();
              });  
            },
            child: Container(
                width: (MediaQuery.of(context).size.height) * 0.08,
                height: (MediaQuery.of(context).size.height) * 0.08,
                decoration: BoxDecoration( 
                  color: colorSelectionList[index],
                  boxShadow: [BoxShadow(color: Colors.black,  blurRadius: 2)],
                  borderRadius: BorderRadius.all(Radius.circular(10)),               
                  border: Border.all(
                    color: (isToggled
                        ? (teamBselectedIndex == index 
                            ? AppColors.textColor
                            : Colors.transparent)
                        : (teamAselectedIndex == index 
                            ? AppColors.textColor
                            : Colors.transparent)),
                    width: 2,
                  ),
                ),
                child: Icon(
                  size: MediaQuery.of(context).size.height * 0.05,
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
