# dvt_weather

DVT weather app

## Conventions, architecture, and general considerations
This weather app is built using Flutter 3 with the cubit architecture to manage state for Weather Data, Preferences (like units of measurement/theme) and location (in case we want to add functionality for changing location and compare weather for different locations).

### The app uses the following conventions:

All files are named in PascalCase.
All constants are named in UPPERCASE.
All variables are named in lowercase with underscores separating words.
All functions are named in lowercase with underscores separating words.
All classes are named in PascalCase.

### The app is structured as follows:

lib directory: Contains the source code for the app.
assets directory: Contains the app's assets, such as images and fonts.
test directory: Contains the unit tests for the app.

### The app uses the following architecture:

Data layer: This layer is responsible for fetching data from the OpenWeatherMap API. It consists of the WeatherModel class, the API class, and the Repository class.
Cubit layer: This layer is responsible for managing the state of the app. It consists of the WeatherCubit class.
Presentation layer: This layer is responsible for displaying the data to the user. It consists of the HomePage widget.

## Third-party libraries
### The app uses the following third-party libraries:

shared_preferences: This library is used to store user preferences.
geolocator: This library is used to get the user's location.
nb_utils: This library provides a number of utilities, such as formatting dates and times.
flutter_spinkit: This library is used to display a loading indicator.
http: This library is used to make HTTP requests.
intl: This library is used to manage dates and times.
flutter_bloc: This library is used to implement the cubit architecture.
## How to build the project
To build the project, you need to have Flutter installed. Once you have Flutter installed, you can run the following command to build the project:

flutter run
Additional notes
The app uses the OpenWeatherMap API: https://openweathermap.org/api to fetch weather data.
The app is designed to be responsive, so it will look good on both mobile and desktop devices.
The app is fully unit tested.

