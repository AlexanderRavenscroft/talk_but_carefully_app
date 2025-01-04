import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/themes/themes.dart';

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
      title: Text(
        "ZASADY",
        textAlign: TextAlign.center,
        style: AppTypography.descBoldStyle.copyWith(
        fontSize: (MediaQuery.of(context).size.width + MediaQuery.of(context).size.height) * 0.03,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Text(
            """
            Pewnego dnia, na końcu labiryntu wykonanego w całości z galaretek o smaku cebuli, mieszkała kura. Ale nie była to zwykła kura, o nie! Była to kura, która nie znosiła jaj, lecz kapsle po napojach gazowanych z lat 80-tych, których nikt już nie produkuje. Każdego ranka kura zjadała podręcznik do matematyki w języku, którego nikt nigdy nie wynalazł, a potem wypluwała równania kwadratowe z zapachem kawy.
            Tymczasem w sąsiednim lesie, wszystkie drzewa postanowiły założyć drużynę koszykarską. Sosna, która była najstarsza, została trenerem, ale dąb nie chciał słuchać poleceń, bo uważał, że ma za grube gałęzie, żeby dryblować piłką. Każdy mecz zaczynał się od rytualnego odśpiewania hymnu w postaci odgłosów łamiących się patyków, co przyciągało widzów, głównie wiewiórki i zagubione kalosze.
            Tymczasem w piwnicy opuszczonego domu na przedmieściach świata, człowiek o imieniu Zygmunt postanowił wynaleźć nowy rodzaj herbaty. Herbata ta miała być wykonana z pokrzyw, ołówków i odrobinę rozpuszczonej plasteliny. Jednak, gdy tylko Zygmunt spróbował pierwszego łyka, cały świat zamarł na sekundę i w tym czasie wszystkie lodówki na Ziemi zaczęły grać walca Szopena w tonacji fis-moll.
            Na drugim końcu galaktyki grupa kosmitów imieniem Zenek, Bożena i Tadeusz próbowała ugotować rosół, ale nie mogli zrozumieć instrukcji znalezionej na opakowaniu makaronu. Problem polegał na tym, że w ich języku nie istniało słowo „gotować”, więc za każdym razem, gdy próbowali coś zrobić, ich zupa zamieniała się w parę wodną, która formowała chmury o kształcie trójkątów.
            Wracając do kury w labiryncie galaretek, pewnego dnia znalazła ona drzwi. Ale te drzwi prowadziły nie do wyjścia, lecz do wielkiego magazynu wypełnionego butami, w których były zegarki. Kura, jak to kura, zaczęła grzebać w butach i przypadkiem uruchomiła zegar apokalipsy, który liczył czas w odwrotnej skali: od -7 do -∞. Ostatecznie nikt nie dowiedział się, co się stało, bo zegar wybuchł konfetti i zniknął w kłębie zapachu truskawek.
            Wnioski z tej historii są żadne, ale za to zajęła kilka minut twojego życia. Dziękuję za uwagę. 
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

