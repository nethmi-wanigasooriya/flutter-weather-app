# Flutter Weather App

A modern, responsive, and visually appealing Weather Application built using **Flutter** and **Dart**. The app fetches real-time weather data from the **OpenWeatherMap API** and features dynamic background theme changes based on live weather conditions.

This project was created as a hands-on Flutter learning project to master **API Integration**, **State Management**, and **UI/UX Design**.

---

## Key Features

* **Real-Time Weather Updates:** Fetches current temperature, humidity, and wind speed.
* **City Search:** Search weather details for any city globally.
* **Dynamic Background Gradient:** Automatically shifts background themes based on weather status (Clear, Cloudy, Rainy, etc.).
* **Modern Glassmorphism UI:** Styled with a clean dark theme, custom icons, and translucent card layouts.
* **Cross-Platform Support:** Runs smoothly on Android, iOS, Windows, and Web.

---

## 🛠️ Tech Stack & Dependencies

* **Framework:** [Flutter](https://flutter.dev/) (Dart)
* **IDE:** VS Code
* **API:** [OpenWeatherMap API](https://openweathermap.org/api)
* **Packages Used:**
  * [`http`](https://pub.dev/packages/http) - API integration & network requests

---

## Getting Started

Follow these steps to set up and run the project locally.

### Prerequisites
* [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
* [VS Code](https://code.visualstudio.com/) or Android Studio.
* A free [OpenWeatherMap API Key](https://home.openweathermap.org/api_keys).

### Installation & Setup

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/nethmi-wanigasooriya/flutter-weather-app.git](https://github.com/nethmi-wanigasooriya/flutter-weather-app.git)
   cd flutter-weather-app

   ---

Install Dependencies:

flutter pub get

   ---

 Configure API Key:
 
 Open lib/main.dart and replace YOUR_API_KEY_HERE with your actual OpenWeatherMap API key:

 final String apiKey = "YOUR_ACTUAL_API_KEY";

 ---

 Run the Application:

 flutter run

 ---

weather_app/
├── lib/
│   └── main.dart          # Main application logic & UI
├── pubspec.yaml           # Project dependencies & assets
└── README.md              # Project documentation

---

## License
This project is open-source and available under the MIT License.

Developed by Nethmi Wanigasooriya
