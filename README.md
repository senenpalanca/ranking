# AI Ranking App

This project is a demonstration of an AI-powered ranking application built using Flutter **3.29**. The app integrates with the OpenAI API to generate rankings based on user prompts. It is designed following a feature-based architecture divided into three layers: **Data**, **Domain**, and **UI**, and is fully prepared for both iOS and Android platforms.

## Features

- **Feature-based Architecture:**
  The project is organized into three layers:
  - **Data:** Contains repositories, models, and the `ApiClient` responsible for HTTP requests.
  - **Domain:** Houses the use cases and business logic. Use cases are separated from the repository layer, and the prompt is constructed directly in the repository.
  - **UI:** Contains all presentation components (widgets, pages) with state management using BLoC.

- **Cross-Platform Support:**
  The app is configured to run on both iOS and Android.

- **Dependency Injection:**
  An intermediate widget, `AppDependencies`, injects all required dependencies into the widget tree. Although currently centralized, this approach can be refactored per feature to further separate dependencies.

- **State Management:**
  The UI state is managed using the BLoC pattern. The `RankingBloc` manages search events and data states (initial, loading, loaded, error, clear) within a single bloc.

- **Modern UI Design:**
  - A **minimalistic** and clean design with a focus on simplicity.
  - **Slivers** are used in the `RankingPage` for better integration of components.
  - Custom widgets (such as the search header, ranking item cards, and popups) provide a modern look.
  - A custom shimmer effect is implemented for loading states, avoiding unnecessary external libraries.
  - Ranking items are displayed as cards with an outlined chip. The chip shows "1st", "2nd", and "3rd" in highlighted colors (gold, silver, bronze) and a neutral tone for other positions.
  - When a ranking item card is tapped, a popup modal appears with extended details including a multi-line title, a scrollable full description,
  rating display, and etc..

- **OpenAI API Integration:**
  - The OpenAI API key is configured in `core/constants/constants.dart`.
  - An `ApiClient` with a single POST function handles API calls, as only a POST request is needed.

## Getting Started

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd <repository-folder>
    ```

2. **Install dependencies:**

   ```bash
   flutter pub get
    ```

3. **Configure OpenAI API Key:**

    Open core/constants/constants.dart and set your OpenAI API key.

4. **Run the project::**

   ```bash
   flutter run --dart-define=OPENAI_API_KEY=<your-api-key>
    ```

## Future Enhancements

 **Routing:**
 Although the app currently operates within a single window, integrating GoRouter would be beneficial for future expansion, allowing for defined and scalable routes.

 **Shimmer Library:**
 A custom shimmer effect is currently implemented to keep the project lightweight. However, a dedicated shimmer library could be integrated in the future if more complex effects are needed.

 **Enhanced Ranking Details:**
 Future improvements might include providing more detailed information for each ranking item and extended prompt editing capabilities.

## Conclusion

 This project demonstrates a robust and maintainable Flutter app featuring:

 - A clear three-layer architecture (Data, Domain, UI).
 - Dependency injection via an intermediate widget (AppDependencies), with the possibility of per-feature injection.
 - Unified state management using a single RankingBloc that handles both search and ranking data.
 - A minimalistic UI design using Slivers for elegant component integration.
 - Custom-designed widgets for search headers, ranking item cards, and popup modals.
 - OpenAI API integration with a dedicated ApiClient.
 - Cross-platform support for both iOS and Android.

 While the current implementation is designed for a single-window experience, future enhancements such as GoRouter integration, a dedicated shimmer library, and more detailed ranking item information are planned.

 Feel free to contribute or suggest improvements!
