# dvt_weather

DVT weather app

## Conventions, architecture, and general considerations
This weather app is built using Flutter 3 with the cubit architecture to manage state for Weather Data, Preferences (like units of measurement/theme) and location (in case we want to add functionality for changing location and compare weather for different locations).

### The app uses the following conventions:

All files are named in snake_case.
All constants are named in UPPERCASE.
All variables are named in snake_case.
All functions are named in snake_case.
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
equatable: Gives us the ability to compare instances of the same class
bloc_test: To test the cubits
## How to build the project
To build the project, you need to have Flutter installed. Once you have Flutter installed, you can run the following command to build the project:

    flutter run

## Testing
To test the project, you can run the following command:

    flutter test

### Additional notes
The API Key is hard coded to allow for tests. It will soon be moved to a file which is not tracked by git
The app uses the OpenWeatherMap API: https://openweathermap.org/api to fetch weather data.
The app is fully unit tested.
Possible areas of improvement include:
 - Displaying the offline status if the user is not connected to the internet
 - Adding more icons to display the different weather states 

