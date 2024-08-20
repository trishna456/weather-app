# Weather App

A Flutter-based Weather App that provides real-time weather information and a 5-day forecast based on the user's location or a specified city. This app is built using the Provider state management solution, ensuring smooth and efficient updates across the UI.

## Features

- **Real-Time Weather Data**: Displays current temperature, weather condition, and additional weather details like humidity, wind speed, and atmospheric pressure.
- **5-Day Forecast**: Detailed 5-day weather forecast, including min/max temperatures and weather conditions.
- **Dynamic Units Toggle**: Switch between metric and imperial units for temperature and wind speed.
- **Responsive Design**: Adapts seamlessly across various screen sizes, from mobile devices to large desktop screens, with dynamic margins and paddings.
- **Error Handling**: User-friendly error message with animation when weather data fails to load.
- **Loading State**: Loading indicator displayed while fetching weather data.

## Technologies Used

- **Flutter**: Framework for building the UI.
- **Provider**: State management for managing and updating the app's state.
- **Lottie**: For engaging animations in error and loading states.
- **REST API Integration**: Retrieves weather data from a third-party weather service API.

## Getting Started

### Prerequisites

- Flutter SDK installed on your local machine.

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/trishna456/weather-app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd weather-app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App

On Mobile:
```bash
flutter run
```

On Web
```bash
flutter run -d chrome
```
## Project Structure

```plaintext
lib/
├── models/       # Contains data models for the weather data
├── services/     # Contains services for fetching weather data from APIs
├── state/        # Contains the WeatherState class for managing app state with Provider
├── widgets/      # Contains reusable UI components like input fields, weather info displays, and forecast lists
└── pages/        # Contains the main page of the app
```

## Code References

This project draws on a select number of key resources, incorporating techniques and ideas from a few trusted sources, including contributions from the community on Stack Overflow, official Flutter documentation, official Flutter YouTube channel, and free resources from LottieFiles. Below are the primary references:

### 1.  Weather App Design

- **References:**
  - [Dribbble Weather App Designs](https://dribbble.com/tags/weather-app)
  - Inspiration from Apple's iOS inbuilt weather app
- **Usage:** The design ideas for the weather app were inspired by exploring multiple designs on Dribbble and drawing inspiration from Apple's iOS weather app.

### 2. Class Constructors

- **References:**
  - [Dart Constructors](https://dart.dev/language/constructors)
  - [Constructor vs Initializer List in Dart](https://stackoverflow.com/questions/52013357/what-is-the-difference-between-constructor-and-initializer-list-in-dart)
- **Usage:** These references were used to understand and implement class constructors in Dart.

### 3. State Management with Provider

- **Reference:** [Simple App State Management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple)
- **Usage:** Helpful in implementing state management using the Provider package.


### 4. Date Utility Functions

- **Reference:** [How do I format a date with Dart?](https://stackoverflow.com/questions/16126579/how-do-i-format-a-date-with-dart)
- **Usage:** This thread provided a clear and concise method for formatting dates in Dart using `DateFormat`.

### 5. Error Resolution

- **References:**
  - [Flutter Common Errors](https://docs.flutter.dev/testing/common-errors)
  - [Flutter Expanded vs. Flexible](https://stackoverflow.com/questions/52645944/flutter-expanded-vs-flexible)
  - [Flutter error with Expanded](https://stackoverflow.com/questions/63530292/flutter-error-with-expanded-although-already-wrapped-with-column)
  - [Flutter Column Doesn’t Expand](https://stackoverflow.com/questions/49310461/flutter-column-doesnt-expand)
- **Usage:** Helpful in addressing errors related to layout widgets like `Column`, `Expanded`, and `Flexible`.

### 6. Lottie Animations

- **Creators:**
  - jochang, Anahita Salimi on LottieFiles

- **Animations Used:**
  - [Weather Animation 1](https://app.lottiefiles.com/animation/85be550b-5fa8-4f3b-baf4-e83301b10081?channel=web&source=public-animation&panel=download)
  - [Weather Animation 2](https://app.lottiefiles.com/animation/e11b020c-21dd-433c-a1c3-0f9c4d947dc2?channel=web&source=public-animation&panel=download)
  - [Weather Animation 3](https://app.lottiefiles.com/animation/f6c326d4-df83-4a81-b4f9-601d43a6fb3a?channel=web&source=public-animation&panel=download)
  - [Weather Animation 4](https://app.lottiefiles.com/animation/45316ead-54e7-46e8-9459-ab4cc0e63aac?channel=web&source=public-animation&panel=download)
  - [Error Cat Animation](https://app.lottiefiles.com/animation/fcfb6aa6-aef7-4d34-9edd-3afb89301e78?channel=web&source=public-animation&panel=download) 
- **Usage:** Animations were used to enhance the user experience by adding dynamic visual feedback.

### 7. Flutter Tutorials

- **Flutter YouTube Channel:** [Flutter Dev on YouTube](https://www.youtube.com/@flutterdev)
- **Usage:** Guided the development process, particularly in understanding the Flutter's UI components and best practices.


## Contributions

Contributions are welcome! If you have ideas for improvements or bug fixes, feel free to submit a pull request or open an issue.


   
   
