import '../utilities/api_keys.dart';
import '../utilities/constants.dart';
import 'location.dart';
import 'networking.dart';

// Ties Location + NetworkHelper together, and turns raw numbers into
// a weather emoji and a friendly message.
class WeatherModel {
  // Weather for the device's current GPS location.
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
      '$kApiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric',
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // Weather for a city the user typed in.
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      '$kApiUrl?q=$cityName&appid=$kApiKey&units=metric',
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // Map an OpenWeatherMap condition code to an emoji.
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  // A cheeky message based on the temperature.
  String getMessage(int temp) {
    if (temp > 25) {
      return "It's 🍦 time";
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return "You'll need 🧣 and 🧤";
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
