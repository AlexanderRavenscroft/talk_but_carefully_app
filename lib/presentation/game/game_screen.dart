import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/provider.dart';
import 'package:gadajaleostroznie/core/taboo_api.dart';
import 'package:gadajaleostroznie/presentation/game/game_screen_widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true, 
      child: Scaffold(
        // APPBAR
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
          child: GameAppBar(),
        ),
      
        // BODY
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Background
            Consumer<GameToggleProvider>(
              builder: (context, gameToggleProvider, child) {
                return TeamBackground();
              },
            ),
            Positioned(
              child: SizedBox(
                       width:                   MediaQuery.of(context).size.width * 0.3,
                 height: MediaQuery.of(context).size.height * 0.06,
                child: ElevatedButton(
                  style: ButtonStyle(

                    backgroundColor: WidgetStateProperty.all(AppColors.textColor), 
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                      ),
                    ),
                    elevation: WidgetStateProperty.all(6),
                    shadowColor: WidgetStateProperty.all(Colors.black),
                  ),
                  onPressed: null,
                  child: Center(
                    child: Icon(
                      Icons.pause,
                      size: MediaQuery.of(context).size.height * 0.05,
                      color: AppColors.neutralColor,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                
                  // Player Encounter or Question Screen
                  Consumer<GameToggleProvider>(
                    builder: (context, gameToggleProvider, child) {
                      return (currentScreen == Screen.encounter)
                          ? PlayerEncounterText() : isLoading   
                          ? SizedBox(
                                                          height: MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 0.75,
                              child:
                              Center(
                                child: FractionallySizedBox(
                                   // widthFactor: 0.75, // 50% of the parent's width
                                     heightFactor: 0.25,
      
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: SizedBox(
                                      child: CircularProgressIndicator(
                                        color: AppColors.neutralColor,
                                        strokeWidth: MediaQuery.of(context).size.height * 0.02,
                                                           
                                      ),
                                    ),
                                  ),
                                ),
                              ) ,
                          )
                          : QuestionScreen();
                    },
                  ),
      
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
      
                  // Round Start Button
                  Consumer<GameToggleProvider>(
                    builder: (context, gameToggleProvider, child) {
                      return (currentScreen == Screen.encounter)
                        ? RoundStartButton()
                        : SizedBox.shrink();
                    },
                  ),
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Remove Points Button
                      Consumer<GameToggleProvider>(
                        builder: (context, gameToggleProvider, child) {
                          return (currentScreen == Screen.question)
                           ? PointsButton(
                              onPressed: () async {
                                if(!isLoading) {
                                  await fetchData();
                                  removePoints();
                                  if (context.mounted) {
                                    Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                                  }
                                }
                              },
                            buttonIcon: Icons.remove, iconColor: AppColors.primaryColor,
                            )
                          : SizedBox.shrink();
                        },
                      ),
                      
                      // Add Skips Button
                      Consumer<GameToggleProvider>(
                        builder: (context, gameToggleProvider, child) {
                          return (currentScreen == Screen.question)
                           ? PointsButton(
                              onPressed: () async {
                                if(!isLoading) {
                                  await fetchData();
                                  addSkips();
                                  if (context.mounted) {
                                    Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                                  }
                                }
                              },
                            buttonIcon: AppIcons.arrowsCcw, iconColor: AppColors.textColor,
                            )
                          : SizedBox.shrink();
                        },
                      ),
                      
                      // Add Points Button
                      Consumer<GameToggleProvider>(
                        builder: (context, gameToggleProvider, child) {
                          return (currentScreen == Screen.question)
                           ? PointsButton(
                              onPressed: () async {
                                if(!isLoading) {
                                  await fetchData();
                                  addPoints();
                                  if (context.mounted) {
                                    Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                                  }
                                }
                              },
                            buttonIcon: Icons.add, iconColor: AppColors.notificationColor,
                            )
                          : SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
               
                ],
              ),
            ),
      
            // TYMCZASOWY KEBAB
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.02,
              left:  MediaQuery.of(context).size.width * 0.35,
              child: Consumer<GameToggleProvider>(
                builder: (context, gameToggleProvider, child) {
                   return (currentScreen == Screen.question)
                      ? ElevatedButton(
                          onPressed: () async {
                            await fetchData();
                            nextScreen();
                            if (context.mounted) {
                              Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                            }
                          },
                           child: Icon(Icons.kebab_dining, size: 60),
                         )
                       : SizedBox.shrink();
                 },
              ),
            ),
          ],
        ),
      ),
    );
    
  }
  
}
