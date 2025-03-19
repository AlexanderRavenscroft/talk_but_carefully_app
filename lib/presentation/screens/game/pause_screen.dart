import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/game_logic.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:gadajaleostroznie/l10n/lang_fix.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/services/preference_service.dart';
import 'package:gadajaleostroznie/presentation/widgets/menu/menu_widgets.dart';
import 'package:gadajaleostroznie/presentation/screens/game_settings/game_settings_screen.dart';
import 'package:gadajaleostroznie/core/providers/ui_providers.dart';
import 'package:provider/provider.dart';
import 'package:gadajaleostroznie/core/providers/timer_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//====================[PAUSE BUTTON]====================
class PauseButton extends StatefulWidget {
  const PauseButton({super.key});

  @override
  State<PauseButton> createState() => PauseButtonState();
}

class PauseButtonState extends State<PauseButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GamePauseProvider>(
      builder: (context, gamePauseProvider, child) {
        return Consumer<TimerProvider>(
          builder: (context, timerProvider, child) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.06,

              // Pause button
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.textColor),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  elevation: WidgetStateProperty.all(6),
                  shadowColor: WidgetStateProperty.all(Colors.black),
                ),
                onPressed: () {
                  context.read<GamePauseProvider>().pauseGame();
                  playAudio(GameSounds.tapSound);
                  if(gamePauseProvider.isPaused) {
                    timerProvider.stopTimer(reset: false);
                  } else {
                    timerProvider.startTimer();
                  }
                },

                // Pause Icon
                child: Center(
                  child: Icon(
                    gamePauseProvider.isPaused ? AppIcons.play :  AppIcons.pause,
                    size: MediaQuery.of(context).size.height * 0.05,
                    color: AppColors.neutralColor,
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }
}
//====================[/PAUSE BUTTON]====================

//====================[PAUSE SCREEN]====================
class PauseScreen extends StatefulWidget {
  const PauseScreen({super.key});

  @override
  State<PauseScreen> createState() => PauseScreenState();
}

class PauseScreenState extends State<PauseScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pause Header
        Text(
          AppLocalizations.of(context)!.pause.toUpper(),
          style: AppTypography.descBoldStyle.copyWith(
            fontSize: MediaQuery.of(context).size.height * 0.08,
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        // Sound Toggle Button
        PauseSettingsButton(
          settingsButtonText: AppLocalizations.of(context)!.sound.toUpper(),
          settingsButtonIcon: GameSounds.soundToggled ? AppIcons.soundON : AppIcons.soundOFF,
          settingsButtonPress: () {
            setState(() {
              GameSounds.soundToggled = !GameSounds.soundToggled;
              PreferenceService.savePreference('soundToggled', GameSounds.soundToggled);
            });
            playAudio(GameSounds.optionSwitchSound);
          },
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Game Guide Button
        PauseSettingsButton(
          settingsButtonText: AppLocalizations.of(context)!.howToPlay.toUpper(),
          settingsButtonIcon: AppIcons.guide,
          settingsButtonPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return GameGuideDialog(
                  headingIcon: AppIcons.guide,
                  headingText: AppLocalizations.of(context)!.legend.toUpper(),
                  buttonText: AppLocalizations.of(context)!.understand.toUpper(),
                );
              },
            );
            playAudio(GameSounds.optionSwitchSound);
          },
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Rules Button
        PauseSettingsButton(
          settingsButtonText: AppLocalizations.of(context)!.rules.toUpper(),
          settingsButtonIcon: AppIcons.docText,
          settingsButtonPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return RulesDialog(
                  headingIcon: AppIcons.docText,
                  headingText: AppLocalizations.of(context)!.rules.toUpper(),
                  buttonText: AppLocalizations.of(context)!.okay.toUpper(),
                  contentText: 'legal_and_info/${Provider.of<LocaleProvider>(context).locale.languageCode}/rules.txt',
                );
              },
            );
            playAudio(GameSounds.optionSwitchSound);
          },
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Exit Button
        PauseSettingsButton(
          settingsButtonText: AppLocalizations.of(context)!.exit.toUpper(),
          settingsButtonIcon: AppIcons.arrowBack,
          settingsButtonPress: () {
            resetGame();
            Navigator.pop(context, MaterialPageRoute(builder: (context) => GameSettingsScreen()));
            context.read<GamePauseProvider>().pauseGame();
            playAudio(GameSounds.tapSound);
          },
        ),
      ],
    );
  }
}
//====================[/PAUSE SCREEN]====================

//====================[PAUSE REUSABLE BUTTON]====================
class PauseSettingsButton extends StatelessWidget {
  final VoidCallback settingsButtonPress;
  final IconData settingsButtonIcon;
  final String settingsButtonText;

  const PauseSettingsButton({
    super.key,
    required this.settingsButtonPress,
    required this.settingsButtonIcon,
    required this.settingsButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: settingsButtonPress,
      style: ButtonStyle(
        fixedSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width * 0.76,
            MediaQuery.of(context).size.height * 0.1,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(AppColors.neutralColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: AppColors.textColor,
              width: 2,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            settingsButtonText,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Icon(
            settingsButtonIcon,
            color: AppColors.textColor,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
        ],
      ),
    );
  }
}
//====================[/PAUSE SETTINGS BUTTON]====================

//====================[GAME GUIDE DIALOG]====================
class GameGuideDialog extends StatelessWidget {
  final IconData headingIcon;
  final String headingText;
  final String buttonText;

  const GameGuideDialog({
    super.key,
    required this.headingIcon,
    required this.headingText,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.neutralColor,

      // Title: Row with icon and text
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            headingIcon,
            color: AppColors.textColor,
            size: MediaQuery.of(context).size.height * 0.042,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            headingText,
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.042,
            ),
          ),
        ],
      ),

      // Content: Game Guide Image and Text
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView( 
          child: 
          (Provider.of<LocaleProvider>(context).locale.languageCode=='pl')
          ? Column(
            children: [
              Image.asset('assets/images/game/game_guide_pl.png'),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.questionTypes.toUpper(),
                  textAlign: TextAlign.justify,
                  style: AppTypography.descBoldStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.034,
                  ),
                ),
              ),
              GameGuideText(difIcon: AppIcons.easyDiff, difName: AppLocalizations.of(context)!.easy.toUpper()),
              GameGuideText(difIcon: AppIcons.mediumDiff, difName: AppLocalizations.of(context)!.medium.toUpper()),
              GameGuideText(difIcon: AppIcons.hardDiff, difName: AppLocalizations.of(context)!.hard.toUpper()),
            ],
          )
          : Center(
            child: Text(
              'No translation for game guide yet..',
              textAlign: TextAlign.center,
              style: AppTypography.descBoldStyle.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.034,
              ),
            ),
          ),
        ),
      ),

      // Actions: Single button to close the dialog
      actions: [
        TextButton(
          style: ButtonStyle(
            fixedSize: WidgetStateProperty.all(
              Size(
                double.maxFinite,
                MediaQuery.of(context).size.height * 0.078,
              ),
            ),
            backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: AppColors.textColor,
                  width: 2,
                ),
              ),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            playAudio(GameSounds.tapSound);
          },
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.042,
            ),
          ),
        ),
      ],
    );
  }
}
//====================[/GAME GUIDE DIALOG]====================

//====================[GAME GUIDE TEXT]====================
class GameGuideText extends StatelessWidget {
  final IconData difIcon;
  final String difName;

  const GameGuideText({
    super.key,
    required this.difIcon,
    required this.difName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          difIcon,
          size: MediaQuery.of(context).size.height * 0.046,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          ' - ',
          style: AppTypography.descBoldStyle.copyWith(
            fontSize: MediaQuery.of(context).size.height * 0.03,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Expanded(
          child: Text(
            difName,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
        ),
      ],
    );
  }
}
//====================[/GAME GUIDE TEXT]====================