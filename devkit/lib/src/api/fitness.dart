import 'package:optional/optional_internal.dart';

/// A snapshot of current fitness data, collected from a variety of different
/// sensors.
class CurrentFitness {

  /// Current speed of the user, in meters per second.
  final num speed;

  /// An estimation of the physical power applied from the user. Measured in
  /// watts. If no estimation is available, the optional value won't contain a
  /// value.
  final Optional<num> power;

  /// The current heart rate from the user, in bpm. If no sensor is available,
  /// this value will be estimated based on the current speed or ascent.
  final Optional<num> heartRate;

  /// Radence of the wheels, in rpm. If no sensor is available, the app will
  /// attempt to estimate this value based on the current speed.
  final Optional<num> cadence;

  CurrentFitness(this.speed, this.power, this.heartRate, this.cadence);

}

/// The current average fitness data on the entire tour
class AveragedFitness {

  /// The total amount of calories burned in this route.
  final num caloriesBurned;

  /// The total ascent in this route. This is not just the height difference
  /// between the current location and the start point: Descends aren't
  /// considered here and won't decrease the number. The ascent is measured in
  /// meters.
  final num ascent;

  /// The distance covered during this route in meters.
  final num distance;

  /// The time since which this route has been active. The duration timer will
  /// not include pauses made by the user, only the time actively spent riding.
  final Duration duration;

  /// The average speed during this route, in meters per second
  final num averageSpeed;

  AveragedFitness(this.caloriesBurned, this.ascent, this.distance,
      this.duration, this.averageSpeed);

}