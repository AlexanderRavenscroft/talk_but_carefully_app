import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/provider.dart';
import 'package:gadajaleostroznie/core/taboo_api.dart';
import 'package:gadajaleostroznie/presentation/game/game_screen_widgets.dart';
import 'package:gadajaleostroznie/presentation/game/pause_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        // APPBAR
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
          child: Consumer<GameToggleProvider>(
            builder: (context, gameToggleProvider, child) {
              return GameAppBar();
            },
          ),
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

            // Pause Button
            Positioned(
              child: PauseButton(),
            ),

            // Main Content or Pause Screen
            Consumer<GamePauseProvider>(
              builder: (context, gamePauseProvider, child) {
                return gamePauseProvider.isPaused
                    ? PauseScreen()
                    : Consumer<GameToggleProvider>(
                        builder: (context, gameToggleProvider, child) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Player Encounter or Question Screen
                                (currentScreen == Screen.encounter)
                                    ? PlayerEncounterText()
                                    : isLoading
                                        ? DataLoadingIndicator()
                                        : QuestionScreen(),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                                // Round Start Button
                                (currentScreen == Screen.encounter)
                                    ? RoundStartButton()
                                    : SizedBox.shrink(),

                                // Points and Skips Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Remove Points Button
                                    (currentScreen == Screen.question)
                                        ? PointsButton(
                                            onPressed: () => removePoints(),
                                            buttonIcon: AppIcons.cancel,
                                            iconColor: AppColors.primaryColor,
                                          )
                                        : SizedBox.shrink(),

                                    // Add Skips Button
                                    (currentScreen == Screen.question)
                                        ? PointsButton(
                                            onPressed: () => addSkips(),
                                            buttonIcon: AppIcons.arrowsCcw,
                                            iconColor: AppColors.textColor,
                                          )
                                        : SizedBox.shrink(),

                                    // Add Points Button
                                    (currentScreen == Screen.question)
                                        ? PointsButton(
                                            onPressed: () => addPoints(),
                                            buttonIcon: AppIcons.ok,
                                            iconColor: AppColors.notificationColor,
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
              },
            ),

            // TYMCZASOWY KEBAB
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.width * 0.35,
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