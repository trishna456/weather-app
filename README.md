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
   git clone https://github.com/your-username/weather-app.git
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

lib/
├── models/ # Contains data models for the weather data
├── services/ # Contains services for fetching weather data from APIs
├── state/ # Contains the WeatherState class for managing app state with Provider
├── widgets/ # Contains reusable UI components like input fields, weather info displays, and forecast lists
└── pages/ # Contains the main page of the app

## Contributions

Contributions are welcome! If you have ideas for improvements or bug fixes, feel free to submit a pull request or open an issue.


   
   
