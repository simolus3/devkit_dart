// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'format.cobi.dart';

// **************************************************************************
// CobiGenerator
// **************************************************************************

int _$parseCobiInt(dynamic data) {
  return data as int;
}

dynamic _$writeCobiInt(dynamic data) {
  return data;
}

RgbColor _$parseRgbColor(dynamic data) {
  final a0 = _$parseCobiInt(data["red"]);
  final a1 = _$parseCobiInt(data["green"]);
  final a2 = _$parseCobiInt(data["blue"]);
  return RgbColor(a0, a1, a2);
}

dynamic _$writeRgbColor(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["red"] = _$writeCobiInt(data.red);
  obj["green"] = _$writeCobiInt(data.green);
  obj["blue"] = _$writeCobiInt(data.blue);
  return obj;
}

String _$parseCobiString(dynamic data) {
  return data as String;
}

dynamic _$writeCobiString(dynamic data) {
  return data;
}

Theme _$parseTheme(dynamic data) {
  final a0 = _$parseRgbColor(data["baseColor"]);
  final a1 = _$parseCobiString(data["identifier"]);
  final a2 = _$parseCobiString(data["bundleIdentifier"]);
  final a3 = _$parseCobiString(data["name"]);
  final a4 = _$parseRgbColor(data["accentColor"]);
  final a5 = _$parseRgbColor(data["backgroundColor"]);
  final a6 = _$parseCobiString(data["logoUrl"]);
  return Theme(a0, a1, a2, a3, a4, a5, a6);
}

dynamic _$writeTheme(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["baseColor"] = _$writeRgbColor(data.baseColor);
  obj["identifier"] = _$writeCobiString(data.identifier);
  obj["bundleIdentifier"] = _$writeCobiString(data.bundleIdentifier);
  obj["name"] = _$writeCobiString(data.name);
  obj["accentColor"] = _$writeRgbColor(data.accentColor);
  obj["backgroundColor"] = _$writeRgbColor(data.backgroundColor);
  obj["logoUrl"] = _$writeCobiString(data.logoUrl);
  return obj;
}

TextToSpeechContent _$parseTextToSpeechContent(dynamic data) {
  final a0 = _$parseCobiString(data["content"]);
  final a1 = _$parseCobiString(data["language"]);
  return TextToSpeechContent(a0, a1);
}

dynamic _$writeTextToSpeechContent(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["content"] = _$writeCobiString(data.content);
  obj["language"] = _$writeCobiString(data.language);
  return obj;
}

ReadLaterItem _$parseReadLaterItem(dynamic data) {
  final a0 = _$parseCobiString(data["title"]);
  final a1 = _$parseCobiString(data["url"]);
  return ReadLaterItem(a0, a1);
}

dynamic _$writeReadLaterItem(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["title"] = _$writeCobiString(data.title);
  obj["url"] = _$writeCobiString(data.url);
  return obj;
}

ContactData _$parseContactData(dynamic data) {
  final a0 = _$parseCobiString(data["phoneNumber"]);
  final a1 = _$parseCobiString(data["email"]);
  final a2 = _$parseCobiString(data["url"]);
  return ContactData(a0, a1, a2);
}

dynamic _$writeContactData(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["phoneNumber"] = _$writeCobiString(data.phoneNumber);
  obj["email"] = _$writeCobiString(data.email);
  obj["url"] = _$writeCobiString(data.url);
  return obj;
}

num _$parseCobiDouble(dynamic data) {
  return data as double;
}

dynamic _$writeCobiDouble(dynamic data) {
  return data;
}

Coordinate _$parseCoordinate(dynamic data) {
  final a0 = _$parseCobiDouble(data["latitude"]);
  final a1 = _$parseCobiDouble(data["longitude"]);
  return Coordinate(a0, a1);
}

dynamic _$writeCoordinate(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["latitude"] = _$writeCobiDouble(data.latitude);
  obj["longitude"] = _$writeCobiDouble(data.longitude);
  return obj;
}

Location _$parseLocation(dynamic data) {
  final a0 = _$parseCoordinate(data["coordinate"]);
  final a1 = _$parseCobiDouble(data["altitude"]);
  final a2 = _$parseCobiDouble(data["bearing"]);
  final a3 = _$parseCobiDouble(data["speed"]);
  final a4 = _$parseCobiDouble(data["horizontalAccuracy"]);
  final a5 = _$parseCobiDouble(data["verticalAccuracy"]);
  return Location(a0, a1, a2, a3, a4, a5);
}

dynamic _$writeLocation(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["coordinate"] = _$writeCoordinate(data.coordinate);
  obj["altitude"] = _$writeCobiDouble(data.altitude);
  obj["bearing"] = _$writeCobiDouble(data.bearing);
  obj["speed"] = _$writeCobiDouble(data.speed);
  obj["horizontalAccuracy"] = _$writeCobiDouble(data.horizontalAccuracy);
  obj["verticalAccuracy"] = _$writeCobiDouble(data.verticalAccuracy);
  return obj;
}

PlacemarkCategory _$parsePlacemarkCategory(dynamic data) {
  if (data == "NONE") {
    return PlacemarkCategory.none;
  }
  if (data == "FOOD") {
    return PlacemarkCategory.food;
  }
  if (data == "HEALTH") {
    return PlacemarkCategory.health;
  }
  if (data == "LEISURE") {
    return PlacemarkCategory.leisure;
  }
  if (data == "NIGHTLIFE") {
    return PlacemarkCategory.nightlife;
  }
  if (data == "PUBLIC") {
    return PlacemarkCategory.public;
  }
  if (data == "SERVICE") {
    return PlacemarkCategory.service;
  }
  if (data == "SHOPPING") {
    return PlacemarkCategory.shopping;
  }
  if (data == "ACCOMODATION") {
    return PlacemarkCategory.acoomodation;
  }
  if (data == "TRANSPORT") {
    return PlacemarkCategory.transport;
  }
  if (data == "BICYCLE_RELEVANT") {
    return PlacemarkCategory.bicycle;
  }
  throw Exception("Unknown value for PlacemarkCategory: $data");
}

dynamic _$writePlacemarkCategory(dynamic data) {
  if (data == PlacemarkCategory.none) {
    return "NONE";
  }
  if (data == PlacemarkCategory.food) {
    return "FOOD";
  }
  if (data == PlacemarkCategory.health) {
    return "HEALTH";
  }
  if (data == PlacemarkCategory.leisure) {
    return "LEISURE";
  }
  if (data == PlacemarkCategory.nightlife) {
    return "NIGHTLIFE";
  }
  if (data == PlacemarkCategory.public) {
    return "PUBLIC";
  }
  if (data == PlacemarkCategory.service) {
    return "SERVICE";
  }
  if (data == PlacemarkCategory.shopping) {
    return "SHOPPING";
  }
  if (data == PlacemarkCategory.acoomodation) {
    return "ACCOMODATION";
  }
  if (data == PlacemarkCategory.transport) {
    return "TRANSPORT";
  }
  if (data == PlacemarkCategory.bicycle) {
    return "BICYCLE_RELEVANT";
  }
}

Placemark _$parsePlacemark(dynamic data) {
  final a0 = _$parseCobiString(data["name"]);
  final a1 = _$parseCobiString(data["address"]);
  final a2 = _$parsePlacemarkCategory(data["category"]);
  final a3 = _$parseCoordinate(data["coordinate"]);
  return Placemark(a0, a1, a2, a3);
}

dynamic _$writePlacemark(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["name"] = _$writeCobiString(data.name);
  obj["address"] = _$writeCobiString(data.address);
  obj["category"] = _$writePlacemarkCategory(data.category);
  obj["coordinate"] = _$writeCoordinate(data.coordinate);
  return obj;
}

BatteryState _$parseBatteryState(dynamic data) {
  if (data == "UNKNOWN") {
    return BatteryState.unknown;
  }
  if (data == "CHARGING") {
    return BatteryState.charging;
  }
  if (data == "LOW_CHARGE") {
    return BatteryState.lowCharge;
  }
  if (data == "INTERMEDIATE_CHARGE") {
    return BatteryState.intermediateCharge;
  }
  if (data == "FULL_CHARGE") {
    return BatteryState.fullyCharged;
  }
  throw Exception("Unknown value for BatteryState: $data");
}

dynamic _$writeBatteryState(dynamic data) {
  if (data == BatteryState.unknown) {
    return "UNKNOWN";
  }
  if (data == BatteryState.charging) {
    return "CHARGING";
  }
  if (data == BatteryState.lowCharge) {
    return "LOW_CHARGE";
  }
  if (data == BatteryState.intermediateCharge) {
    return "INTERMEDIATE_CHARGE";
  }
  if (data == BatteryState.fullyCharged) {
    return "FULL_CHARGE";
  }
}

BatteryCondition _$parseBatteryCondition(dynamic data) {
  final a0 = _$parseCobiInt(data["batteryLevel"]);
  final a1 = _$parseBatteryState(data["state"]);
  return BatteryCondition(a0, a1);
}

dynamic _$writeBatteryCondition(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["batteryLevel"] = _$writeCobiInt(data.level);
  obj["state"] = _$writeBatteryState(data.state);
  return obj;
}

Route _$parseRoute(dynamic data) {
  final a0 = _$parsePlacemark(data["origin"]);
  final a1 = _$parsePlacemark(data["destination"]);
  final a2 = _$parseCobiString(data["name"]);
  final a3 = _$parseCobiDouble(data["distance"]);
  final a4 = _$parseCobiDouble(data["elevationGain"]);
  final a5 = _$parseCobiDouble(data["duration"]);
  return Route(a0, a1, a2, a3, a4, a5);
}

dynamic _$writeRoute(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["origin"] = _$writePlacemark(data.origin);
  obj["destination"] = _$writePlacemark(data.destination);
  obj["name"] = _$writeCobiString(data.name);
  obj["distance"] = _$writeCobiDouble(data.distance);
  obj["elevationGain"] = _$writeCobiDouble(data.elevationGain);
  obj["duration"] = _$writeCobiDouble(data.duration);
  return obj;
}

NavigationAction _$parseNavigationAction(dynamic data) {
  if (data == "STOP") {
    return NavigationAction.stop;
  }
  if (data == "PLAN") {
    return NavigationAction.plan;
  }
  if (data == "START") {
    return NavigationAction.start;
  }
  throw Exception("Unknown value for NavigationAction: $data");
}

dynamic _$writeNavigationAction(dynamic data) {
  if (data == NavigationAction.stop) {
    return "STOP";
  }
  if (data == NavigationAction.plan) {
    return "PLAN";
  }
  if (data == NavigationAction.start) {
    return "START";
  }
}

NavigationCommand _$parseNavigationCommand(dynamic data) {
  final a0 = _$parseNavigationAction(data["action"]);
  final a1 = _$parseCoordinate(data["destination"]);
  return NavigationCommand(a0, a1);
}

dynamic _$writeNavigationCommand(dynamic data) {
  final obj = new JsObject(context["Object"]);
  obj["action"] = _$writeNavigationAction(data.action);
  obj["destination"] = _$writeCoordinate(data.destination);
  return obj;
}

ThumbControllerAction _$parseThumbControllerAction(dynamic data) {
  if (data == "UP") {
    return ThumbControllerAction.up;
  }
  if (data == "DOWN") {
    return ThumbControllerAction.down;
  }
  if (data == "LEFT") {
    return ThumbControllerAction.left;
  }
  if (data == "RIGHT") {
    return ThumbControllerAction.right;
  }
  if (data == "SELECT") {
    return ThumbControllerAction.select;
  }
  throw Exception("Unknown value for ThumbControllerAction: $data");
}

dynamic _$writeThumbControllerAction(dynamic data) {
  if (data == ThumbControllerAction.up) {
    return "UP";
  }
  if (data == ThumbControllerAction.down) {
    return "DOWN";
  }
  if (data == ThumbControllerAction.left) {
    return "LEFT";
  }
  if (data == ThumbControllerAction.right) {
    return "RIGHT";
  }
  if (data == ThumbControllerAction.select) {
    return "SELECT";
  }
}

AmbientLightState _$parseAmbientLightState(dynamic data) {
  if (data == "DARK") {
    return AmbientLightState.dark;
  }
  if (data == "TWILIGHT") {
    return AmbientLightState.twighlight;
  }
  if (data == "BRIGHT") {
    return AmbientLightState.bright;
  }
  throw Exception("Unknown value for AmbientLightState: $data");
}

dynamic _$writeAmbientLightState(dynamic data) {
  if (data == AmbientLightState.dark) {
    return "DARK";
  }
  if (data == AmbientLightState.twighlight) {
    return "TWILIGHT";
  }
  if (data == AmbientLightState.bright) {
    return "BRIGHT";
  }
}

NavigationStatus _$parseNavigationStatus(dynamic data) {
  if (data == "NONE") {
    return NavigationStatus.none;
  }
  if (data == "CALCULATING") {
    return NavigationStatus.calculating;
  }
  if (data == "NAVIGATING") {
    return NavigationStatus.navigating;
  }
  throw Exception("Unknown value for NavigationStatus: $data");
}

dynamic _$writeNavigationStatus(dynamic data) {
  if (data == NavigationStatus.none) {
    return "NONE";
  }
  if (data == NavigationStatus.calculating) {
    return "CALCULATING";
  }
  if (data == NavigationStatus.navigating) {
    return "NAVIGATING";
  }
}

TemperatureUnit _$parseTemperatureUnit(dynamic data) {
  if (data == "CELSIUS") {
    return TemperatureUnit.celsius;
  }
  if (data == "FAHRENHEIT") {
    return TemperatureUnit.fahrenheit;
  }
  throw Exception("Unknown value for TemperatureUnit: $data");
}

dynamic _$writeTemperatureUnit(dynamic data) {
  if (data == TemperatureUnit.celsius) {
    return "CELSIUS";
  }
  if (data == TemperatureUnit.fahrenheit) {
    return "FAHRENHEIT";
  }
}

LengthUnit _$parseLengthUnit(dynamic data) {
  if (data == "METRIC") {
    return LengthUnit.metric;
  }
  if (data == "IMPERIAL") {
    return LengthUnit.imperial;
  }
  throw Exception("Unknown value for LengthUnit: $data");
}

dynamic _$writeLengthUnit(dynamic data) {
  if (data == LengthUnit.metric) {
    return "METRIC";
  }
  if (data == LengthUnit.imperial) {
    return "IMPERIAL";
  }
}

BikeType _$parseBikeType(dynamic data) {
  if (data == "CITY") {
    return BikeType.city;
  }
  if (data == "MTB") {
    return BikeType.mountainBike;
  }
  if (data == "ROAD") {
    return BikeType.road;
  }
  if (data == "URBAN") {
    return BikeType.urban;
  }
  if (data == "TREKKING") {
    return BikeType.trekking;
  }
  throw Exception("Unknown value for BikeType: $data");
}

dynamic _$writeBikeType(dynamic data) {
  if (data == BikeType.city) {
    return "CITY";
  }
  if (data == BikeType.mountainBike) {
    return "MTB";
  }
  if (data == BikeType.road) {
    return "ROAD";
  }
  if (data == BikeType.urban) {
    return "URBAN";
  }
  if (data == BikeType.trekking) {
    return "TREKKING";
  }
}

dynamic parseWithPath(dynamic payload, String path) {
  final type = channels[path];
  if (type == int) {
    return _$parseCobiInt(payload);
  }
  if (type == RgbColor) {
    return _$parseRgbColor(payload);
  }
  if (type == String) {
    return _$parseCobiString(payload);
  }
  if (type == Theme) {
    return _$parseTheme(payload);
  }
  if (type == TextToSpeechContent) {
    return _$parseTextToSpeechContent(payload);
  }
  if (type == ReadLaterItem) {
    return _$parseReadLaterItem(payload);
  }
  if (type == ContactData) {
    return _$parseContactData(payload);
  }
  if (type == num) {
    return _$parseCobiDouble(payload);
  }
  if (type == Coordinate) {
    return _$parseCoordinate(payload);
  }
  if (type == Location) {
    return _$parseLocation(payload);
  }
  if (type == PlacemarkCategory) {
    return _$parsePlacemarkCategory(payload);
  }
  if (type == Placemark) {
    return _$parsePlacemark(payload);
  }
  if (type == BatteryState) {
    return _$parseBatteryState(payload);
  }
  if (type == BatteryCondition) {
    return _$parseBatteryCondition(payload);
  }
  if (type == Route) {
    return _$parseRoute(payload);
  }
  if (type == NavigationAction) {
    return _$parseNavigationAction(payload);
  }
  if (type == NavigationCommand) {
    return _$parseNavigationCommand(payload);
  }
  if (type == ThumbControllerAction) {
    return _$parseThumbControllerAction(payload);
  }
  if (type == AmbientLightState) {
    return _$parseAmbientLightState(payload);
  }
  if (type == NavigationStatus) {
    return _$parseNavigationStatus(payload);
  }
  if (type == TemperatureUnit) {
    return _$parseTemperatureUnit(payload);
  }
  if (type == LengthUnit) {
    return _$parseLengthUnit(payload);
  }
  if (type == BikeType) {
    return _$parseBikeType(payload);
  }
}

dynamic writeWithPath(dynamic payload, String path) {
  final type = channels[path];
  if (type == int) {
    return _$writeCobiInt(payload);
  }
  if (type == RgbColor) {
    return _$writeRgbColor(payload);
  }
  if (type == String) {
    return _$writeCobiString(payload);
  }
  if (type == Theme) {
    return _$writeTheme(payload);
  }
  if (type == TextToSpeechContent) {
    return _$writeTextToSpeechContent(payload);
  }
  if (type == ReadLaterItem) {
    return _$writeReadLaterItem(payload);
  }
  if (type == ContactData) {
    return _$writeContactData(payload);
  }
  if (type == num) {
    return _$writeCobiDouble(payload);
  }
  if (type == Coordinate) {
    return _$writeCoordinate(payload);
  }
  if (type == Location) {
    return _$writeLocation(payload);
  }
  if (type == PlacemarkCategory) {
    return _$writePlacemarkCategory(payload);
  }
  if (type == Placemark) {
    return _$writePlacemark(payload);
  }
  if (type == BatteryState) {
    return _$writeBatteryState(payload);
  }
  if (type == BatteryCondition) {
    return _$writeBatteryCondition(payload);
  }
  if (type == Route) {
    return _$writeRoute(payload);
  }
  if (type == NavigationAction) {
    return _$writeNavigationAction(payload);
  }
  if (type == NavigationCommand) {
    return _$writeNavigationCommand(payload);
  }
  if (type == ThumbControllerAction) {
    return _$writeThumbControllerAction(payload);
  }
  if (type == AmbientLightState) {
    return _$writeAmbientLightState(payload);
  }
  if (type == NavigationStatus) {
    return _$writeNavigationStatus(payload);
  }
  if (type == TemperatureUnit) {
    return _$writeTemperatureUnit(payload);
  }
  if (type == LengthUnit) {
    return _$writeLengthUnit(payload);
  }
  if (type == BikeType) {
    return _$writeBikeType(payload);
  }
}
