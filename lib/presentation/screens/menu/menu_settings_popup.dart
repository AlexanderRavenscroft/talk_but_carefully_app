import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/app_info.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/services/preference_service.dart';
import 'package:gadajaleostroznie/presentation/widgets/menu/menu_widgets.dart';
import 'package:provider/provider.dart';

//====================[SETTINGS POPUP]====================
class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => SettingsMenuState();
}

class SettingsMenuState extends State<SettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.neutralColor,

      // Title Row with settings icon and text
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            AppIcons.settings,
            color: AppColors.textColor,
            size: MediaQuery.of(context).size.height * 0.042,
          ),
          SizedBox(width: MediaQuery.of(context).size.height * 0.01),
          Text(
            "USTAWIENIA",
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
        ],
      ),

      // Content: Settings options
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sound section
            SettingsText(settingsTextString: "Dźwięk:"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            SettingsButton(
              settingsButtonPress: () {
                setState(() {
                  GameSounds.soundToggled = !GameSounds.soundToggled;
                  PreferenceService.savePreference('soundToggled', GameSounds.soundToggled);
                });
              },
              settingsButtonIcon: GameSounds.soundToggled ? AppIcons.soundON : AppIcons.soundOFF,
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            SettingsText(settingsTextString: "Lang"),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        SettingsButton(
                          settingsButtonPress: () {
                            if(Provider.of<LocaleProvider>(context, listen: false).locale == Locale('pl')) {
                              Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('en'));
                            } else {
                              Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale('pl'));
                            }
                            
                          },
                          settingsButtonIcon: Icons.flag,
                        ),


            // License & Agreement section
            SettingsText(settingsTextString: "Zgoda & Licencja:"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),


            SettingsButton(
              settingsButtonPress: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withValues(alpha: 0.3), // Remove double-dialog stacking background problem
                  builder: (BuildContext context) {
                    return RulesDialog(
                      headingIcon: AppIcons.docText,
                      headingText: "REGULAMIN",
                      buttonText: "ZGADZAM SIĘ",
                      contentText: 'texts/agreement.txt',
                    );
                  },
                );
              },
              settingsButtonIcon: AppIcons.docText,
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // Authors section
            SettingsText(settingsTextString: "Autorzy:"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SettingsButton(
              settingsButtonPress: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withValues(alpha: 0.3), // Remove double-dialog stacking background problem
                  builder: (BuildContext context) {
                    return RulesDialog(
                      headingIcon: AppIcons.authors,
                      headingText: "AUTORZY",
                      buttonText: "FAJNIE",
                      contentText: 'texts/authors.txt',
                    );
                  },
                );
              },
              settingsButtonIcon: AppIcons.authors,
            ),

         //   SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // App version and build number
            Text(
              "Wersja aplikacji: ${AppSetup.appVersion} \nKompilacja: ${AppSetup.buildNumber}",
              style: AppTypography.descBoldStyle.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ],
        ),
      ),

      // Actions: Button to settings menu
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
            "POWRÓT",
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
//====================[/SETTINGS POPUP]====================