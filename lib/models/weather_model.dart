class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    /*
    The factory keyword in Dart is used to define a factory constructor.
    A factory constructor is a special type of constructor that is used to create an instance of a class,
    but unlike regular constructors, it can return an existing instance or a different instance based on some logic.

    In this case, Weather.fromJson is a factory constructor that creates a Weather instance from a JSON map.
    It is not an inbuilt function; rather, it is a custom constructor that we have defined for our Weather class.
    */

    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
