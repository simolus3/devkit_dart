import 'package:devkit/src/spec/properties.dart';

import 'annotations.dart';
import 'dart:js';

part 'format.cobi.g.dart';

const String specVersion = "0.44.0";

// compiler expects the field to be named exactly like this
const channels = {
  App.theme: Theme,
  App.textToSpeech: TextToSpeechContent,
  App.readLater: ReadLaterItem,
  App.language: String,
  App.contact: ContactData,
  App.touchInteractionEnabled: bool,
  App.hubLocation: Placemark,
  App.clockVisible: bool,
  App.isDark: bool,
  App.isHubConnected: bool,

  Hub.motorInterfaceReady: bool,
  Hub.bellRinging: bool,
  Hub.externalInterfaceAction: ThumbControllerAction,
  Hub.ambientLightState: AmbientLightState,

  Mobile.location: Location,
  Mobile.heading: num,
  Mobile.locationAvailability: bool,

  NavigationService.route: Route,
  NavigationService.eta: int,
  NavigationService.distanceToDestination: int,
  NavigationService.status: NavigationStatus,
  NavigationService.control: NavigationCommand,

  RideService.speed: num,
  RideService.userPower: num,
  RideService.userPowerAvailability: bool,
  RideService.heartRate: num,
  RideService.heartRateAvailability: bool,
  RideService.cadence: num,
  RideService.cadenceAvailability: bool,

  BikeChannel.type: BikeType,

  User.temperatureUnit: TemperatureUnit,
  User.lengthUnit: LengthUnit,

  Battery.state: BatteryCondition,

  Devkit.close: bool,
  Devkit.overrideThumbControllerMapping: bool
};

/// The generator only generates types that are referenced in a struct. Bool
/// isn't referenced in any entity, so we create a fake entity because I'm too
/// lazy to fix the generator.
@cobiEntity
class _HackThatReferencesBool {
  final bool wow;

  _HackThatReferencesBool(this.wow);
}

/// A color
@cobiEntity
class RgbColor {
  /// The red component of this color. Between 0 and 255 (inclusive).
  final int red;

  /// The green component of this color. Between 0 and 255 (inclusive).
  final int green;

  /// The blue component of this color. Between 0 and 255 (inclusive).
  final int blue;

  RgbColor(this.red, this.green, this.blue);
}

/// {@template devkit_dart/themes}
/// The COBI.Bike app comes in different colors. Also, some bike manufactures
/// have added their own colors to the app which the user can choose if they're
/// riding a bike from the specific OEM. You can use this theme class to be
/// consistent with the rest of the COBI.Bike app.
/// {@endtemplate}
@cobiEntity
class Theme {
  /// ???
  final RgbColor baseColor;

  /// An identifier for this theme.
  final String identifier;

  /// Not relevant to DevKit modules.
  final String bundleIdentifier;

  /// The name of this theme, as shown to the user.
  final String name;

  /// An accent color to use for buttons or other prominent input.
  final RgbColor accentColor;

  /// The background color to use with this theme.
  final RgbColor backgroundColor;

  /// The url from which a logo of this theme can be fetched. Often, the logo
  /// just shows the brand name / icon of the OEM responsible for this theme.
  final String logoUrl;

  Theme(this.baseColor, this.identifier, this.bundleIdentifier, this.name,
      this.accentColor, this.backgroundColor, this.logoUrl);
}


@cobiEntity
class TextToSpeechContent {
  String content;
  String language;

  TextToSpeechContent(this.content, [this.language = "en-US"]);
}

@cobiEntity
class ReadLaterItem {
  final String title;
  final String url;

  ReadLaterItem(this.title, this.url);
}

/// Represents a contact chosen by the user after being prompted to select one.
/// All fields in this class can be empty.
@cobiEntity
class ContactData {
  /// The primary phone number of the contact selected
  final String phoneNumber;

  /// The email address of this contact
  final String email;

  /// An URL of this contact, if it exists.
  final String url;

  ContactData(this.phoneNumber, this.email, this.url);
}

/// A location as received from GPS.
@cobiEntity
class Location {

  final Coordinate coordinate;
  final num altitude;
  final num bearing;
  final num speed;
  final num horizontalAccuracy;
  final num verticalAccuracy;

  Location(this.coordinate, this.altitude, this.bearing, this.speed,
      this.horizontalAccuracy, this.verticalAccuracy);

}

/// A coordinate represented with with latitude and longitude.
@cobiEntity
class Coordinate {
  final num latitude;
  final num longitude;

  Coordinate(this.latitude, this.longitude);
}

@cobiEntity
enum PlacemarkCategory {
  /// There is no category associated with this place. This is what you'll be
  /// getting most of the time.
  @FromValue("NONE")
  none,
  @FromValue("FOOD")
  food,
  @FromValue("HEALTH")
  health,
  @FromValue("LEISURE")
  leisure,
  @FromValue("NIGHTLIFE")
  nightlife,
  @FromValue("PUBLIC")
  public,
  @FromValue("SERVICE")
  service,
  @FromValue("SHOPPING")
  shopping,
  @FromValue("ACCOMODATION")
  acoomodation,
  @FromValue("TRANSPORT")
  transport,
  @FromValue("BICYCLE_RELEVANT")
  bicycle
}

/// A placemark on the map, represents something important like the location
/// of a hub or the destination of a route.
@cobiEntity
class Placemark {
  /// The name of the place which got the placemark
  final String name;
  /// The address of the location at this placemark
  final String address;
  /// The category that describes this placemark best
  final PlacemarkCategory category;
  /// The geographic coordinate of this placemark.
  final Coordinate coordinate;

  Placemark(this.name, this.address, this.category, this.coordinate);
}

/// Contains information about the current state of the battery.
@cobiEntity
class BatteryCondition {
  /// The charging level of this battery, in percent from 0 to 100.
  @FromValue("batteryLevel")
  final int level;
  /// A broader interpretation of the current charging level.
  final BatteryState state;

  BatteryCondition(this.level, this.state);
}

@cobiEntity
enum BatteryState {
  @FromValue("UNKNOWN")
  unknown,
  @FromValue("CHARGING")
  charging,
  @FromValue("LOW_CHARGE")
  lowCharge,
  @FromValue("INTERMEDIATE_CHARGE")
  intermediateCharge,
  @FromValue("FULL_CHARGE")
  fullyCharged
}

@cobiEntity
enum ThumbControllerAction {
  @FromValue("UP")
  up,
  @FromValue("DOWN")
  down,
  @FromValue("LEFT")
  left,
  @FromValue("RIGHT")
  right,
  @FromValue("SELECT")
  select
}

@cobiEntity
enum AmbientLightState {
  @FromValue("DARK")
  dark,
  @FromValue("TWILIGHT")
  twighlight,
  @FromValue("BRIGHT")
  bright
}

@cobiEntity
/// A route, as chosen by the user. This object will not be recalculated during
/// the ride and instead represents the route with start and end position as
/// one object.
class Route {

  /// The start position of this route
  final Placemark origin;
  /// The destination of this route
  final Placemark destination;

  /// An optional empty. Absent values marked with an empty string
  final String name;

  /// The total distance covered by this route
  final num distance;
  /// The elevation gain covered by this route. Note that this is not simply the
  /// height difference between [destination] and [origin]. Instead, for every
  /// "up and down" on the route, only the ups will be added.
  /// Check https://en.wikipedia.org/wiki/Cumulative_elevation_gain
  /// for details.
  final num elevationGain;
  /// An estimation on how long it's going to take to complete this route. A
  /// value that is continually updated can be obtained from the Cobi class.
  final num duration;

  // Should we include predefined? I never understood what that one was even
  // supposed to mean, probably not relevant
  // should probably include waypoints, but I'm to lazy to include arrays in the
  // generator.

  Route(this.origin, this.destination, this.name, this.distance,
      this.elevationGain, this.duration);

}

/// An enum to, broadly, describe what the navigation service is up to at the
/// moment.
@cobiEntity
enum NavigationStatus {

  /// Navigation service in idle.
  @FromValue("NONE")
  none,
  /// Navigation service is currently calculating a rout
  @FromValue("CALCULATING")
  calculating,
  /// Navigation is active
  @FromValue("NAVIGATING")
  navigating

}

@cobiEntity
enum NavigationAction {
  /// Stops the current route
  @FromValue("STOP")
  stop,
  /// Calculates and plans a route
  @FromValue("PLAN")
  plan,
  /// Currently, same as [NavigationAction.plan]
  @FromValue("START")
  start
}

@cobiEntity
class NavigationCommand {

  final NavigationAction action;
  final Coordinate destination;

  NavigationCommand(this.action, this.destination);

}

@cobiEntity
enum TemperatureUnit {

  /// A value to indicate that the user has set degrees celsius as their
  /// preferred measurement for temperature.
  @FromValue("CELSIUS")
  celsius,
  /// A value to indicate that the user has set degrees fahrenheit as their
  /// preferred measurement for temperature.
  @FromValue("FAHRENHEIT")
  fahrenheit

}

@cobiEntity
enum LengthUnit {

  /// Indicates that the user prefers the metric system to measure distance.
  @FromValue("METRIC")
  metric,
  /// Indicates that the user prefers to use the imperial system to measure
  /// distance.
  @FromValue("IMPERIAL")
  imperial

}

@cobiEntity
enum BikeType {

  @FromValue("CITY")
  city,
  @FromValue("MTB")
  mountainBike,
  @FromValue("ROAD")
  road,
  @FromValue("URBAN")
  urban,
  @FromValue("TREKKING")
  trekking

}
