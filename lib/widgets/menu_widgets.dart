import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/logic/globals.dart';
import 'package:gadajaleostroznie/themes/themes.dart';
import 'package:gadajaleostroznie/services/audio_service.dart';
//====================[MENU BUTTON]====================
class MenuButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
  return ElevatedButton(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(EdgeInsets.zero), 
      minimumSize: WidgetStateProperty.all(Size(
        MediaQuery.of(context).size.width * 0.54,
        MediaQuery.of(context).size.height * 0.1,
      )),
      maximumSize: WidgetStateProperty.all(Size(
        MediaQuery.of(context).size.width * 0.56,
        MediaQuery.of(context).size.height * 0.12,
      )),
      backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      elevation: WidgetStateProperty.all(10.0), 
      shadowColor: WidgetStateProperty.all(Colors.black), 
    ),
    onPressed: onPressed,
    
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02, right: 0), 
          child: Icon(
            buttonIcon,
            color: AppColors.textColor,
            size: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.028,
          ),
        ),
        Expanded(
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                buttonText,
                style: AppTypography.buttonStyle.copyWith(
                  fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.028,
                ),
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

//====================[RULES POPUP]====================
class RulesDialog extends StatelessWidget {
  const RulesDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.neutralColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Icon(
             Icons.rule_sharp, 
             color: AppColors.textColor,
             size: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03),

           Text(
             "ZASADY",
             textAlign: TextAlign.center,
             style: AppTypography.descBoldStyle.copyWith(
             fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03,
             ),
           ),
         ]
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Text(
            """
            Gra toczy się w dwóch drużynach, które rywalizują ze sobą o punkty. Drużyna, która pierwsza zdobędzie limit punktów wygrywa!
            Jedna osoba z drużyny odgadujących staje się opisywaczem. Jej zadaniem jest naprowadzenie reszty swojej drużyny na konkretne hasło widoczne na ekranie.
            Podczas opisywania nie można używać zkazanych słów. Słowa te są wymienione pod głównym hasłem i trzeba ich unikać za wszelką cenę! Każda drużyna ma ograniczony czas na odgadnięcie jak największej liczby haseł.
            Drużyna zdobywa punkt za każde odgadnięte hasło. Uwaga – jeśli opisujący użyje zakazanego słowa, traci punkt!
            Wybrany gracz drużyny przeciwnej kontroluje, czy zakazane słowa nie są wypowiedziane.
            """,
          textAlign: TextAlign.justify,
          style: AppTypography.descStyle.copyWith(
          fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.015,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
          minimumSize: Size(
             double.maxFinite,
             MediaQuery.of(context).size.height * 0.075,
          ),
          backgroundColor: AppColors.accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            playTapAudio();
          },
          child: Text(
            "DOBRA!",
          textAlign: TextAlign.center,
          style: AppTypography.descBoldStyle.copyWith(
          fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.025,
            ),
          ),
        ),
      ],
    );
  }
}



class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.neutralColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.settings, 
            color: AppColors.textColor,
            size: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03),

          Text(
            "USTAWIENIA",
            textAlign: TextAlign.center,
            style: AppTypography.descBoldStyle.copyWith(
            fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03,
            ),
          ),
        ]
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(
                "Dźwięk:",
                textAlign: TextAlign.justify,
                style: AppTypography.descBoldStyle.copyWith(
                fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.02,)
                ),

                TextButton(
                  onPressed: () {
                    setState(() {
                      soundToggled = !soundToggled; 
                    });
                  },
                  style: ButtonStyle(
                    fixedSize: WidgetStateProperty.all(Size(
                      MediaQuery.of(context).size.width * 0.04,
                      MediaQuery.of(context).size.height * 0.07,
                    )),
                    backgroundColor: WidgetStateProperty.all(AppColors.accentColor),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: AppColors.textColor,
                          width: 2,
                        )
                        ),
                    ),
                  ),

                  child: Icon(
                    soundToggled ? Icons.volume_up_rounded : Icons.volume_off,
                    color: AppColors.textColor,
                    size: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          style: TextButton.styleFrom(
          minimumSize: Size(
             double.maxFinite,
             MediaQuery.of(context).size.height * 0.075,
          ),
          backgroundColor: AppColors.accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            playTapAudio();
          },
          child: Text(
            "POWRÓT",
          textAlign: TextAlign.center,
          style: AppTypography.descBoldStyle.copyWith(
          fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.025,
            ),
          ),
        ),
      ],
    );
  }
}