# gadajaleostroznie

lib/
├── core/
│   ├── app_info.dart      // Fetches app version and metadata. Can be extended for additional app-related info.
│   ├── globals.dart       // Stores global instances of `Team` and `Game` classes. Imported across the app for shared state.
│   ├── game_logic.dart    // Handles game logic, including point calculation and win/loss conditions.
│   ├── text_and_encounter_manager.dart  // Imports text files and generates dynamic encounter messages.
│   ├── providers/
│   │   ├── ui_providers.dart       // Manages UI state and team-related providers.
│   │   ├── timer_provider.dart     // Controls the game timer and its state.
├── screens/
│   ├── game/
│   │   ├── game_screen.dart        // Main game screen where the gameplay happens.
│   │   ├── game_results_screen.dart  // Displays results after the game ends.
│   │   ├── pause_screen.dart       // Screen shown when the game is paused.
│   ├── menu/
│   │   ├── menu_screen.dart        // Main menu screen with navigation options.
│   │   ├── menu_settings_popup.dart  // Popup for menu-specific settings.
│   ├── settings/
│   │   ├── game_settings_screen.dart  // Screen for configuring game settings.
│   │   ├── team_settings_screen.dart  // Screen for managing team settings.
│   ├── splash/
│   │   ├── splash_screen.dart      // Initial splash screen shown on app launch.
├── widgets/
│   ├── game/
│   │   ├── game_screen_widgets.dart  // Reusable widgets for the game screen.
│   │   ├── game_results_screen_widgets.dart  // Widgets for the game results screen.
│   ├── menu/
│   │   ├── menu_widgets.dart       // Reusable widgets for the menu screen.
│   ├── settings/
│   │   ├── game_settings_widgets.dart  // Widgets for the game settings screen.
│   │   ├── team_settings_widgets.dart  // Widgets for the team settings screen.
├── services/
│   ├── audio_service.dart          // Manages audio playback across the app.
│   ├── preference_service.dart     // Handles persistent storage for user preferences (e.g., language, sound).
├── themes/
│   ├── themes.dart                 // Defines app-wide themes, including colors, icons, and typography.
main.dart                           // Entry point of the app.