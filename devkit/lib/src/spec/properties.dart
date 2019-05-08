class App {

  static const String _name = "app";

  static const String theme = "$_name/theme";
  static const String textToSpeech = "$_name/textToSpeech";
  static const String readLater = "$_name/readLater";
  static const String language = "$_name/language";
  static const String contact = "$_name/contact";
  static const String touchInteractionEnabled = "$_name/touchInteractionEnabled";
  static const String hubLocation = "$_name/hubLocation";
  static const String clockVisible = "$_name/clockVisible";
  static const String isDark = "$_name/isDark";
  static const String isHubConnected = "$_name/isHubConnected";

}

class Hub {

  static const String _name = "hub";

  static const String motorInterfaceReady = "$_name/motorInterfaceReady";
  static const String bellRinging = "$_name/bellRinging";
  static const String externalInterfaceAction = "$_name/externalInterfaceAction";
  static const String ambientLightState = "$_name/ambientLightState";

}

class Mobile {

  static const String _name = "mobile";

  static const String location = "$_name/location";
  static const String heading = "$_name/heading";
  static const String locationAvailability = "$_name/locationAvailability";

}

class Battery {

  static const String state = "battery/state";

}

class NavigationService {

  static const String _name = "navigationService";

  static const String route = "$_name/route";
  static const String eta = "$_name/eta";
  static const String distanceToDestination = "$_name/distanceToDestination";
  static const String status = "$_name/status";
  static const String control = "$_name/control";

}

class BikeChannel {

  static const String type = "bike/type";

}

class RideService {

  static const String _name = "rideService";

  static const String speed = "$_name/speed";
  static const String userPower = "$_name/userPower";
  static const String userPowerAvailability = "$_name/userPowerAvailability";
  static const String heartRate = "$_name/heartRate";
  static const String heartRateAvailability = "$_name/heartRateAvailability";
  static const String cadence = "$_name/cadence";
  static const String cadenceAvailability = "$_name/cadenceAvailability";

}

class TourService {

  static const String _name = "tourService";

  static const String calories = "$_name/calories";
  static const String ascent = "$_name/ascent";
  static const String ridingDistance = "$_name/ridingDistance";
  static const String ridingDuration = "$_name/ridingDuration";
  static const String averageSpeed = "$_name/averageSpeed";

}

class Devkit {

  static const String _name = "devkit";

  static const String close = "$_name/close";
  static const String overrideThumbControllerMapping =
      "$_name/overrideThumbControllerMapping";

}

class User {

  static const String _name = "user";

  static const String temperatureUnit = "$_name/temperatureUnit";
  static const String lengthUnit = "$_name/lengthUnit";

}

final Set<String> noCache = Set.of([
  App.textToSpeech,
  App.readLater,
  App.contact,
  Hub.externalInterfaceAction,
  NavigationService.control
]);