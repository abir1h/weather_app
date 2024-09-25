import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../models/current_data_model.dart';
import '../../models/forcast_data_model.dart';
import '../../models/location_data_model.dart';
import '../../models/weather_data_model.dart';

class WeatherDatabaseHelper {
  static final WeatherDatabaseHelper _instance = WeatherDatabaseHelper._internal();
  static Database? _database;

  factory WeatherDatabaseHelper() {
    return _instance;
  }

  WeatherDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'weather.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create the weather data table
    await db.execute('''
      CREATE TABLE weather (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        location TEXT,
        current TEXT,
        forecast TEXT,
        position TEXT UNIQUE
      )
    ''');
  }

  // Insert weather data into the database
  Future<void> insertWeatherData(WeatherDataModel weatherData, String positionKey) async {
    final db = await database;

    await db.insert(
      'weather',
      {
        'location': weatherData.location?.toJson().toString(),
        'current': weatherData.current?.toJson().toString(),
        'forecast': weatherData.forecast?.toJson().toString(),
        'position': positionKey,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get weather data from the database
  Future<WeatherDataModel?> getWeatherData(String positionKey) async {
    final db = await database;
    final result = await db.query(
      'weather',
      where: 'position = ?',
      whereArgs: [positionKey],
    );

    if (result.isNotEmpty) {
      // Decode each field from a JSON-encoded string to Map<String, dynamic>
      final locationJson = result.first['location'] != null
          ? jsonDecode(result.first['location'] as String) as Map<String, dynamic>
          : null;

      final currentJson = result.first['current'] != null
          ? jsonDecode(result.first['current'] as String) as Map<String, dynamic>
          : null;

      final forecastJson = result.first['forecast'] != null
          ? jsonDecode(result.first['forecast'] as String) as Map<String, dynamic>
          : null;

      return WeatherDataModel(
        location: locationJson != null ? LocationDataModel.fromJson(locationJson) : null,
        current: currentJson != null ? CurrentDataModel.fromJson(currentJson) : null,
        forecast: forecastJson != null ? ForecastDataModel.fromJson(forecastJson) : null,
      );
    }

    return null; // Return null if no data is found
  }}
