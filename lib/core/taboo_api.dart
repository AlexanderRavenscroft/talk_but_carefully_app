import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gadajaleostroznie/core/globals.dart';
import 'dart:math';
import 'package:collection/collection.dart'; 
Random random = Random();

String title = "Ładowanie tytułu...";
List forbiddenWords = ["Ładowanie słowa...", "Ładowanie słowa..."];
String difficulty = "Ładowanie trudności...";

Future<void> fetchData() async {
  Uri url = Uri.parse('https://taboocardsapi.com/api/cards/random?language=pl'); //Default API URL
  Uri allDiffsUrl = Uri.parse('https://taboocardsapi.com/api/cards/random?language=pl'); 
  Uri easyDiffsUrl = Uri.parse('https://taboocardsapi.com/api/cards/random?language=pl&difficulty=easy'); 
  Uri mediumDiffsUrl = Uri.parse('https://taboocardsapi.com/api/cards/random?language=pl&difficulty=medium'); 
  Uri hardDiffsUrl = Uri.parse('https://taboocardsapi.com/api/cards/random?language=pl&difficulty=hard'); 

  Map<Set<int>, Uri> urlsMap = {
    {0, 1, 2}: allDiffsUrl,
    {0}: easyDiffsUrl,
    {1}: mediumDiffsUrl,
    {2}: hardDiffsUrl,
    {0, 1}: random.nextBool() ? easyDiffsUrl : mediumDiffsUrl,
    {0, 2}: random.nextBool() ? easyDiffsUrl : hardDiffsUrl,
    {1, 2}: random.nextBool() ? mediumDiffsUrl : hardDiffsUrl,
  };

  final setEquality = SetEquality<int>();

  for (Set<int> key in urlsMap.keys) {
    if (setEquality.equals(key, GameSettings.aviableDifs)) {
      url = urlsMap[key] ?? allDiffsUrl;
      break;
    }
  }

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body); // Parse JSON
      final data = json['data']; // Access the 'data' object
      title = data['title']; // Access properties inside 'data'
      forbiddenWords = data['forbiddenWords'];
      difficulty = data['difficulty'];
      switch (difficulty) {   //Translate difficulty to polish
        case('easy'):
          difficulty = 'łatwe';
          break;

        case('medium'):
          difficulty = 'średnie';
          break;

        case('hard'):
          difficulty = 'trudne';
          break;
      }
    } else {
      title = 'Failed to load data';
      }
  } catch (e) {
    title = 'Error: $e';
  }

}

