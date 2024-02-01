import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_clean_architecture_tdd/data/models/weather_model.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'overcast clouds',
    iconCode: '04d',
    temperature: 279.5,
    pressure: 1015,
    humidity: 72,
  );

  test('should be a subclass of weather entity', () async {
    // assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    // act
    final result = WeatherModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    // act
    final result = testWeatherModel.toJson();

    // assert
    final expectedJsonMap = {
      'weather': [
        {'main': 'Clouds', 'description': 'overcast clouds', 'icon': '04d'}
      ],
      'main': {
        'temp': 279.5,
        'pressure': 1015,
        'humidity': 72,
      },
      'name': 'New York',
    };

    expect(result, expectedJsonMap);
  });
}
