import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/core/providers/locale_provider.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/core/app_info.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
import 'package:gadajaleostroznie/services/preference_service.dart';
import 'package:gadajaleostroznie/presentation/widgets/menu/menu_widgets.dart';
import 'package:gadajaleostroznie/l10n/lang_fix.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context)!.settings.toUpper(),
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.04,
            ),
          ),
        ],
      ),

      // Content: Settings options
      content:  SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // GAME SOUND
            _buildSettingsOption(
              title: AppLocalizations.of(context)!.sound.capitalize(),
              onPressed: () {
                setState(() {
                  GameSounds.soundToggled = !GameSounds.soundToggled;
                  PreferenceService.savePreference('soundToggled', GameSounds.soundToggled);
                });
              },
              icon: GameSounds.soundToggled ? AppIcons.soundON : AppIcons.soundOFF,
            ),

            // GAME LANGUAGE
            _buildSettingsOption(
              title: AppLocalizations.of(context)!.language.capitalize(),
              onPressed: () {
                final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
                localeProvider.setLocale(localeProvider.locale.languageCode == 'pl' ? Locale('en') : Locale('pl'));
              },
              icon: AppIcons.language,
            ),

            // LICENSE & AGREEMENT
            _buildSettingsOption(
              title: "${AppLocalizations.of(context)!.agreement.capitalize()} & ${AppLocalizations.of(context)!.license.capitalize()}",
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withValues(alpha: 0.3),
                  builder: (BuildContext context) {
                    return RulesDialog(
                      headingIcon: AppIcons.docText,
                      headingText: AppLocalizations.of(context)!.agreement.toUpper(),
                      buttonText: AppLocalizations.of(context)!.agree.toUpper(),
                      contentText: 'legal_and_info/${Provider.of<LocaleProvider>(context).locale.languageCode}/agreement.txt',
                    );
                  },
                );
              },
              icon: AppIcons.docText,
            ),

            // CREATOR
            _buildSettingsOption(
              title: AppLocalizations.of(context)!.creator.capitalize(),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierColor: Colors.black.withValues(alpha: 0.3),
                  builder: (BuildContext context) {
                    return RulesDialog(
                      headingIcon: AppIcons.creator,
                      headingText: AppLocalizations.of(context)!.creator.toUpper(),
                      buttonText: AppLocalizations.of(context)!.cool.toUpper(),
                      contentText: 'legal_and_info/${Provider.of<LocaleProvider>(context).locale.languageCode}/creator.txt',
                    );
                  },
                );
              },
              icon: AppIcons.creator,
            ),

            // APP VERSION & BUILD NUMBER
            Text(
              "${AppLocalizations.of(context)!.appVersion.capitalize()}: ${AppSetup.appVersion} \n${AppLocalizations.of(context)!.build.capitalize()}: ${AppSetup.buildNumber}",
              style: AppTypography.descBoldStyle.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.024,
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
            AppLocalizations.of(context)!.back.toUpper(),
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.042,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildSettingsOption({
    required String title,
    required VoidCallback onPressed,
    required IconData icon,
    }) {
    return Column(
      children: [
        SettingsText(settingsTextString: title),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        SettingsButton(
          settingsButtonPress: onPressed,
          settingsButtonIcon: icon,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
      ],
    );
  }
}
//====================[/SETTINGS POPUP]====================