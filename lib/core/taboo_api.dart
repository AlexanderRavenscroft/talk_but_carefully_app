// Fetches game questions from API. All API logic is here.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gadajaleostroznie/core/globals.dart';
import 'dart:math';
import 'package:collection/collection.dart'; 

//====================[API FETCHING]====================
Random random = Random();
bool isLoading = false; // If loading, return a Progress Indicator in game_screen

String title = "Loading title...";
List forbiddenWords = ["loading word", "loading word"];
String difficulty = "Loading difficulty...";


Future<void> fetchData(String languageCode) async {
  isLoading = true; 
  // All needed URLs
  Uri url = Uri.parse('https://taboocardsapi.com/api/cards/random?language=$languageCode'); //Default API URL
  Uri allDiffsUrl = Uri.parse('https://taboocardsapi.com/api/cards/random?language=$languageCode'); 
  Uri easyDiffsUrl = Uri.parse('https://taboocardsapi.com/api/cards/random?language=$languageCode&difficulty=easy'); 
  Uri mediumDiffsUrl = Uri.parse('https://taboocardsapi.com/api/cards/random?language=$languageCode&difficulty=medium'); 
  Uri hardDiffsUrl = Uri.parse('https://taboocardsapi.com/api/cards/random?language=$languageCode&difficulty=hard'); 

  // All possible diff combinations
  Map<Set<int>, Uri> urlsMap = {
    {0, 1, 2}: allDiffsUrl,
    {0}: easyDiffsUrl,
    {1}: mediumDiffsUrl,
    {2}: hardDiffsUrl,
    {0, 1}: random.nextBool() ? easyDiffsUrl : mediumDiffsUrl,
    {0, 2}: random.nextBool() ? easyDiffsUrl : hardDiffsUrl,
    {1, 2}: random.nextBool() ? mediumDiffsUrl : hardDiffsUrl,
  };

  // Use Equality to map specif URL based on diff.
  final setEquality = SetEquality<int>();
  for (Set<int> key in urlsMap.keys) {
    if (setEquality.equals(key, GameSettings.aviableDifs)) {
      url = urlsMap[key] ?? allDiffsUrl;
      break;
    }
  }

  // Begin fetching
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body); // Parse JSON
      final data = json['data']; // Access the 'data' object
      title = data['title']; // Access properties inside 'data'
      forbiddenWords = data['forbiddenWords'];
      difficulty = data['difficulty'];

    } else {
      title = 'Failed to load data';
      }
  } catch (e) {
    title = 'Error: $e';
  } finally {
   isLoading = false; // Stop loading, return data instead of progress indicator
  }
}
//====================[/API FETCHING]====================
