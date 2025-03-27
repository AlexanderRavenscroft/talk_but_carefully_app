# Talk, but Carefully!
<img src="/assets/images/icon/app_icon.png" alt="App Icon" title="App Icon" height="100"/> 

## **Overview**
This Flutter-based mobile game was developed as part of my portfolio to showcase my expertise in mobile app development. The game allows users to configure various settings, such as round duration and the points required to win, before starting. Players can create team names, add members, choose nicknames, and customize team colors.

The objective of the game is for players to describe a given word to their teammates without using the forbidden words listed below it. Points are awarded for correctly guessing the title word without using restricted terms. Conversely, teams lose points if a forbidden word is spoken. Players also have the option to skip words, but each team has a limited number of skips.

The app retrieves game cards (questions) from taboocardsapi.com. Throughout development, I focused on enhancing my understanding of REST APIs, implementing game logic (including team structures, configurable settings, and score management), and designing dynamic, multi-screen navigation. Additionally, I integrated SharedPreferences to store user settings, such as game audio preferences and language selection.

---

## **Skills Showcase**
- **Flutter & Dart**: Built a responsive and performant mobile app using Flutter widgets and Dart programming.
- **State Management**: Implemented Provider for efficient state management.
- **Multi Language Support**: `Used l10n package` to support both English and Polish Language
- **User settings save**: Used a `shared prefrences package` to save user's sound and language settings.
- **API Integration**: Integrated **[Taboo Cards API](https://taboocardsapi.com/en/)** to get question cards real-time.
- **Navigation**: Used `Flutter PopScope Widget` to prevent users from accidental screen leaving and reseting game.
- **Sound effects**: Added a varity of sound effects using `audioplayers package`.
- **UI/UX Design**: Designed a clean and intuitive user interface with customizable colors
- **Debugging & Testing**: Tested the app on both Android and iOS devices. Used Device Manager to test different screen sizes and Dart DevTools for performance analysis.
  
---

## **Features**
- Customizable Gameplay: Change games rules like difficulty and round time.
- Customizable Teams: Change team color, name and players.
- Sound effects: For each correct or wrong answer, after the menu select and when game ends.
- Multi language support: Full translation and support for Polish and English language.
- Game Logic: Players can see game summery with graphs, that represent thier scored points.
- Game questions: Questions are fetched quickly from external API, which is still contunnied and supported.
- Responsive Design: Optimized for multiple screen sizes and devices.
  
---

## **Technologies Used**
- **Frontend**: Flutter, Dart
- **State Management**: Provider
- **Backend**: Dart
- **APIs**: [Taboo Cards API](https://taboocardsapi.com/en/)
- **Packages**: `http`, `Provider`, `Device Preview`, `collection`, `audioplayers`, `shared_prefrences`, `flutter_svg`, `package_info_plus`
- **Development Tools**: Git, Android Studio, VS Code, XCode

---

## **Challenges & Learnings**
Throughout this project, I encountered several challenges that helped me grow as a developer. Here are some key takeaways:  

### **Technical Challenges**  

- **Ensuring smooth and quick retrieval of game questions from an external API without delays.**
  - **Solution:** Optimized API calls with caching mechanisms and error handling to maintain a seamless gameplay experience.

- **Keeping game progress, scores, and settings intact when navigating between screens.**
  - **Solution:** Used the Provider package for efficient state management, ensuring data persistence throughout the game.

- **Avoiding unintended game resets when players navigate back or accidentally leave the screen.**
  - **Solution:** Implemented Flutter PopScope Widget to prompt users before exiting a game session.


### **Key Learnings & Improvements**  
- **Strengthened my understanding** of REST API handling and efficient data retrieval in Flutter.

- **Enhanced my skills** in using Provider for better state management across dynamic, multi-screen applications.

- **Learned how to implement** intuitive UI/UX features, such as customizable team settings and game configurations.

- **Gained experience** in integrating sound effects to enhance user engagement and create an immersive gaming experience.

---

## **Installation**
1. Clone the repository:

   ```bash
   git clone https://github.com/AlexanderRavenscroft/talk_but_carefully_app
   ```
   
2. Navigate to the project directory:

   ```bash
   cd talk_but_carefully_app
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```
   
4. Run the app:

   ```bash
   flutter run
   ```
   
---

## **LICENSE**
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## **GitHub Disclaimer**
I’m still learning Git and improving my workflow. As a result:
- Some repositories might be messy due to experimentation.
- The commit dates may appear non-chronological as I often work on multiple projects simultaneously.
- I work on multiple devices, which sometimes leads to inconsistencies in commit authorship.
- I recently changed my GitHub username, so older commits may still show my previous name (ShenAbuser).

Thanks for understanding as I continue to grow as a developer!

---

## **My other projects**
**Message Chat App** – A real-time chat application with messaging features: [GitHub Repo](https://github.com/AlexanderRavenscroft/chat_app)

**Halo App** – A real-time location based wethear application with animations: [GitHub Repo](https://github.com/AlexanderRavenscroft/halo_app)

**AI Chatbot App** - An AI-powered chatbot using custom user training instructions (developer): [GitHub Repo](https://github.com/AlexanderRavenscroft/ai_chatbot_app)

**Wordle** - A minimal wordle game with API word fetching: [GitHub Repo](https://github.com/AlexanderRavenscroft/wordle_app)

---

## **Connect with Me**
Email: alex.ravenscroft.dev@gmail.com

Fiver: https://www.fiverr.com/alexander_raven




