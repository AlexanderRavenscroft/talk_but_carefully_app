import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/globals.dart';
import 'package:gadajaleostroznie/core/providers/ui_providers.dart';
import 'package:gadajaleostroznie/core/taboo_api.dart';
import 'package:gadajaleostroznie/presentation/widgets/game/game_screen_widgets.dart';
import 'package:gadajaleostroznie/presentation/screens/game/pause_screen.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';

//====================[GAME SCREEN]====================
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<GameToggleProvider>(
        builder: (context, gameToggleProvider, child) {
          return Scaffold(
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
                TeamBackground(),

                // Pause Button
                if (currentScreen == Screen.question)
                  Positioned(
                    child: PauseButton(),
                  ),

                // Main Content or Pause Screen
                Consumer<GamePauseProvider>(
                  builder: (context, gamePauseProvider, child) {
                    return gamePauseProvider.isPaused
                      ?PauseScreen()
                      :Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Player Encounter or Question Screen
                            if (currentScreen == Screen.encounter)
                              PlayerEncounterText()
                            else if (isLoading)
                              DataLoadingIndicator()
                            else
                              QuestionScreen(),

                            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                            // Round Start Button
                            if (currentScreen == Screen.encounter)
                              RoundStartButton(),

                            // Points and Skips Buttons
                            if (currentScreen == Screen.question)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Remove Points Button
                                  PointsButton(
                                    onPressed: () async {
                                      playAudio(GameSounds.wrongAnswerSound);
                                      if (!isLoading) {
                                        removePoints();
                                        await fetchData(Provider.of<LocaleProvider>(context, listen: false).locale.languageCode);
                                        if (context.mounted) {
                                          Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                                        }
                                      }
                                    },
                                    buttonIcon: AppIcons.cancel,
                                    iconColor: AppColors.primaryColor,
                                  ),

                                  // Add Skips Button
                                  PointsButton(
                                    onPressed: () async {
                                      if (!isLoading) {
                                        if (currentTeam.skips < GameSettings.aviableSkips) {
                                          addSkips();
                                          playAudio(GameSounds.skipAnswerSound);
                                          await fetchData(Provider.of<LocaleProvider>(context, listen: false).locale.languageCode);
                                        }
                                        if (context.mounted) {
                                          Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                                        }
                                      }
                                    },
                                    buttonIcon: AppIcons.arrowsCcw,
                                    iconColor: AppColors.textColor,
                                  ),

                                  // Add Points Button
                                  PointsButton(
                                    onPressed: () async {
                                      if (!isLoading) {
                                        playAudio(GameSounds.correctAnswerSound);
                                        addPoints();
                                        await fetchData(Provider.of<LocaleProvider>(context, listen: false).locale.languageCode);
                                        if (context.mounted) {
                                          Provider.of<GameToggleProvider>(context, listen: false).toggleTurns();
                                        }
                                      }
                                    },
                                    buttonIcon: AppIcons.ok,
                                    iconColor: AppColors.notificationColor,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
//====================[/GAME SCREEN]====================
