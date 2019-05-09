import 'package:devkit/devkit.dart';
import 'package:devkit/src/api/contact_picker.dart';
import 'package:devkit/src/api/fitness.dart';
import 'package:devkit/src/interop/interop.dart';
import 'package:devkit/src/interop/messages.dart';
import 'package:devkit/src/spec/context.dart';
import 'package:devkit/src/spec/format.cobi.dart';
import 'package:devkit/src/spec/properties.dart';
import 'package:flutter_web/widgets.dart' show BuildContext;

import 'package:optional/optional.dart';
import 'package:rxdart/rxdart.dart';

/// The Cobi class is the central class of this library to use the devkit
/// features of the COBI.Bike system. It implements a high-level API to use
/// all the features available and avoid common pitfalls.
class Cobi {
  /// Singleton instance.
  static Cobi _instance;

  /// Sends a fake message of the hub being connected because the simulator
  /// doesn't.
  static bool simulatorCompatibility = false;

  final MessageStore _msgs;
  BehaviorSubject<Optional<ConnectedHub>> _connectedHub;

  Stream<CurrentFitness> _userFitness;
  Stream<AveragedFitness> _averagedUserFitness;

  ContactPicker _picker;

  bool _initialized = false;
  //// Whether [init] has been called and completed successfully.
  bool get initialized => _initialized;

  /// private constructor
  Cobi._(this._msgs);

  /// Creates the singleton Cobi instance by launching the messenger that will
  /// communicate with the native application.
  factory Cobi() {
    if (_instance != null) return _instance;

    var messenger = JavaScriptMessageSender();
    var store = MessageStore(messenger);

    return Cobi._(store);
  }

  /// Retrieves an appropiate instance for the widget with the given [context].
  /// For this to work, a [DevKitApp] must be present.
  static Cobi of(BuildContext context) {}

  /// The version of the protocol implemented by this library to talk to native
  /// COBI.Bike apps. The protocol is usually pretty tolerant to version
  /// changes, so talking to a slightly newer or older native app shouldn't be
  /// a problem
  String get version => specVersion;

  /// The version of the protocol implemented by the native app we're talking to
  /// at the moment, or null, if this webpage is not visited from a COBI.Bike
  /// app.
  String get appVersion => Uri.base.queryParameters["version"];

  /// The language (locale) of the COBI.Bike app used to access this DevKit
  /// module.
  String get appLanguage {
    final rawLang = Uri.base.queryParameters["language"];

    return rawLang.replaceAll("-", "_");
  }

  /// {@macro devkit_dart/context}
  Context get context {
    final rawCtx = Uri.base.queryParameters["context"];

    switch (rawCtx) {
      case "onRide":
        return Context.onRide;
      case "onRideSettings":
        return Context.onRideSettings;
      case "offRide":
        return Context.offRide;
      case "offRideSettings":
        return Context.offRideSettings;
    }

    throw Exception("Unknown context $rawCtx");
  }

  /// Starts communication with the native app and initializes this module. For
  /// initialization, the specified [token] will be sent to the native app. In
  /// the future, that token will be verified and used as an authentication
  /// method. For now, any token will be accepted. The future returned will
  /// resolve when the native app replied that the token looks ok. Only after
  /// that you're allowed to listen and send messages.
  Future<void> init(String token) async {
    await _msgs.init(token);
    _initialized = true;

    _connectedHub = BehaviorSubject.seeded(Optional.empty());
    _msgs.observeValuesOf<bool>(App.isHubConnected).listen((isConnected) {
      if (isConnected) {
        _connectedHub.add(Optional.of(ConnectedHub._(this)));
      } else {
        _connectedHub.add(Optional.empty());
      }
    });

    // listen and update fitness data by combining the individual properties
    _userFitness = Observable.combineLatest7<num, num, bool, num, bool, num,
            bool, CurrentFitness>(
        _msgs.observeValuesOf<num>(RideService.speed).startWith(0),
        _msgs.observeValuesOf<num>(RideService.userPower).startWith(0),
        _msgs
            .observeValuesOf<bool>(RideService.userPowerAvailability)
            .startWith(false),
        _msgs.observeValuesOf<num>(RideService.heartRate).startWith(0),
        _msgs
            .observeValuesOf<bool>(RideService.heartRateAvailability)
            .startWith(false),
        _msgs.observeValuesOf<num>(RideService.cadence).startWith(0),
        _msgs
            .observeValuesOf<bool>(RideService.cadenceAvailability)
            .startWith(false),
        (speed, power, powerAv, heartRate, hrAv, cadence, cAv) {
      final userPower = powerAv ? Optional.of(power) : Optional<num>.empty();
      final userHeartRate =
          hrAv ? Optional.of(heartRate) : Optional<num>.empty();
      final userCadence = cAv ? Optional.of(cadence) : Optional<num>.empty();

      return CurrentFitness(speed, userPower, userHeartRate, userCadence);
    });

    _averagedUserFitness =
        Observable.combineLatest5<num, num, num, num, num, AveragedFitness>(
            _msgs.observeValuesOf<num>(TourService.calories).startWith(0),
            _msgs.observeValuesOf<num>(TourService.ascent).startWith(0),
            _msgs.observeValuesOf<num>(TourService.ridingDistance).startWith(0),
            _msgs.observeValuesOf<num>(TourService.ridingDuration).startWith(0),
            _msgs.observeValuesOf<num>(TourService.averageSpeed).startWith(0),
            (calories, ascent, ridingDistance, ridingDuration, averageSpeed) {
      return AveragedFitness(
        calories,
        ascent,
        ridingDistance,
        Duration(seconds: ridingDuration.round()),
        averageSpeed,
      );
    });

    _picker = ContactPicker(_msgs);

    // TODO Might want to make this customizable, although there is no scenario
    // were you would not need this
    _msgs.write(Devkit.overrideThumbControllerMapping, true);

    if (simulatorCompatibility) {
      _msgs.fakeReceivedMessage(
          Message<bool>(App.isHubConnected, Action.notify, true));
    }
  }

  /// {@macro devkit_dart/themes}
  /// This method will load the current theme from the app. If the theme is
  /// already known, it will return immediately.
  Future<Theme> loadAppTheme() => _msgs.replyFromCacheOrRead(App.theme);

  /// Uses the built-in text to speech engine of the device to announce the
  /// given [text]. The [language] parameter will be ignored for now. Instead,
  /// the system language will be used. This will change in a future version of
  /// the COBI.Bike app.
  void say(String text, {String language = "en-US"}) {
    _msgs.write(App.textToSpeech, TextToSpeechContent(text, language));
  }

  /// The language of the user. This should be identical to [appLanguage],
  /// although [appLanguage] is faster and easier to fetch. Thus, it should
  /// always be preferred over this one.
  @deprecated
  Future<String> language() => _msgs.replyFromCacheOrRead(App.language);

  /// Users aren't supposed to touch their phone directly while riding their
  /// bike at speed, so the COBI.Bike app will disable touch interaction in that
  /// case. You can react to this by adjusting you UI accordingly and fade out
  /// elements that can't be pressed.
  /// Touch interaction will be turned off when going faster than walking speed
  /// and back on again when the bike comes to a rest. Note that the thumb
  /// controller will work in either case.
  Stream<bool> get touchInteractionEnabled =>
      _msgs.observeValuesOf(App.touchInteractionEnabled);

  /// Loads and reports the last known location of the hub. This value will be
  /// stored in a database on the phone, so that it can be available even when
  /// the hub is not connected.
  Stream<Placemark> get savedHubLocation =>
      _msgs.observeValuesOf(App.hubLocation, readFirst: true);

  /// In [Context.onRide], the app will show a clock in the top-right corner
  /// after a module is open for around 5 seconds. If you want to keep this
  /// behavior, you don't need to do anything. If you have hidden the clock
  /// previously with [hideClock], you can use this method to show it again.
  void showClock() => _msgs.write(App.clockVisible, true);

  /// In [Context.onRide], the app will show a clock in the top-right corner
  /// after a module is open for around 5 seconds. If you don't want the clock
  /// to show at all, you can use this method when starting your module (after
  /// [init]). You can also hide the clock at a later time after it has already
  /// been visible.
  void hideClock() => _msgs.write(App.clockVisible, false);

  /// Whether it's dark outside. This value will be calculated based on sunset
  /// and sunrise times at the current location. If the app is connected to a
  /// COBI.Bike hub at the moment, you can also query real-time data provided
  /// by a light sensor from [ConnectedHub.ambientLight].
  Future<bool> get isDark => _msgs.replyFromCacheOrRead(App.isDark);

  /// An updating stream reporting whether it's dark outside. The value will
  /// change to false after the sun has set and back to true once it has risen
  /// again. When calling this method, the current value will be reported as
  /// well.
  Stream<bool> observeDarkness() =>
      _msgs.observeValuesOf<bool>(App.isDark, readFirst: true).distinct();

  /// Returns a stream of an optional hub to represent whether the app is
  /// connected to a COBI.Bike hub. If so, the returned hub can be used to
  /// fetch additional data that is only available when a hub is connected.
  Stream<Optional<ConnectedHub>> get connectedHub => _connectedHub.distinct();

  /// Returns the raw location as measured by the app. If the location is not
  /// available, for instance due to missing permissions, an absent optional
  /// will be reported.
  Stream<Optional<Location>> get location => _ifLocationAvailable(() {
        return _msgs.observeValuesOf(Mobile.location);
      });

  /// Returns the current direction of the device in degrees, so that 0 degrees
  /// is true North. If the location cannot be obtained, for instance due to
  /// permission issues, an absent optional will be reported instead.
  Stream<Optional<num>> get direction => _ifLocationAvailable(() {
        return _msgs.observeValuesOf(Mobile.heading);
      });

  /// Emits items from [ifAvailable] if the location is available and emits an
  /// absent Optional if it isn't.
  Stream<Optional<T>> _ifLocationAvailable<T>(Stream<T> ifAvailable()) {
    return _msgs
        .observeValuesOf<bool>(Mobile.locationAvailability)
        .switchMap((available) {
      if (available) {
        return ifAvailable().map((data) => Optional.of(data));
      } else {
        return Observable.just(Optional.empty());
      }
    });
  }

  /// Returns the current route active by the navigation service or an empty
  /// optional if no route is active at the moment.
  Future<Optional<Route>> get route async {
    final status = await _msgs
        .replyFromCacheOrRead<NavigationStatus>(NavigationService.status);

    if (status == NavigationStatus.navigating)
      return Optional.of(
          await _msgs.replyFromCacheOrRead<Route>(NavigationService.route));

    return Optional.empty();
  }

  /// Shows a contact picker. The library will attempt to recognize when the
  /// contact picker has been dismissed and return a [ContactResult.dismissed]
  /// in that case. Note that this check is not perfect and might not recognize
  /// every dismissal. If a contact has been selected by the value, a
  /// [ContactResult.withResult] will be returned. It provides information about
  /// the contact selected.
  Future<ContactResult> showContactPicker() => _picker.showContactPrompt();

  /// If there's a route active at the moment, this stream will update with the
  /// estimated time of arrival. If there is no route active, this stream won't
  /// emit any items.
  Stream<DateTime> get eta => _msgs
      .observeValuesOf<int>(NavigationService.eta)
      .map((time) => DateTime.fromMillisecondsSinceEpoch(time * 1000));

  /// If there's a route active at the moment, this stream will update with the
  /// distance remaining to the destination. If there is no route active, this
  /// stream won't emit any items.
  Stream<int> get distanceToDestination =>
      _msgs.observeValuesOf(NavigationService.distanceToDestination);

  /// An continuously updated stream containing information about what the
  /// navigation service is doing at the moment.
  Stream<NavigationStatus> get navigationStatus =>
      _msgs.observeValuesOf(NavigationService.status);

  /// Plans, calculates and starts a route to the given coordinate. The future
  /// returned by calling this method will resolve when the route has been
  /// calculated and started, but not later than 5 seconds after calling.
  Future<void> startRouteTo(Coordinate coordinate) async {
    _msgs.write(NavigationService.control,
        NavigationCommand(NavigationAction.plan, coordinate));

    Future<void> calcComplete() async {
      bool wasCalculating = false;

      await for (final status in navigationStatus) {
        if (status == NavigationStatus.calculating) {
          wasCalculating = true;
        }
        if (status == NavigationStatus.navigating && wasCalculating) {
          // calculation seems to be done
          return;
        }
      }
    }

    await calcComplete().timeout(Duration(seconds: 5));
  }

  /// Stops the active route, it there is one.
  void stopRoute() {
    _msgs.write(NavigationService.control,
        NavigationCommand(NavigationAction.stop, Coordinate(0, 0)));
  }

  /// A future that resolves to the preferred unit of temperature, as chosen
  /// by the user.
  Future<TemperatureUnit> get temperatureUnit =>
      _msgs.replyFromCacheOrRead(User.temperatureUnit);

  /// Get the preferred length unit as chosen by the user.
  Future<LengthUnit> get lengthUnit =>
      _msgs.replyFromCacheOrRead(User.lengthUnit);

  /// Returns a snapshot of the current fitness activity of the user. Contains
  /// the current speed, power, heart rate and cadence, if these values are
  /// available.
  Stream<CurrentFitness> get userFitness => _userFitness;

  /// More general fitness values and statistics that don't include a current
  /// snapshot but instead a generalized overview over the entire route that is
  /// active right now.
  Stream<AveragedFitness> get averagedFitness => _averagedUserFitness;

  /// Returns what kind of bike the user is riding. The user can chose this
  /// value in the settings of the COBI.Bike app.
  Future<BikeType> get bikeType => _msgs.replyFromCacheOrRead(BikeChannel.type);

  /// Instructs the COBI.Bike app to close this module and return to the
  /// dashboard or the homescreen.
  void close() {
    _msgs.write(Devkit.close, true);
  }
}

/// Represents a COBI.Bike hub that is connected to the app at the moment. Can
/// be used to query additional data like the bell or the thumb controller.
class ConnectedHub {
  final Cobi _cobi;

  MessageStore get _msgs => _cobi._msgs;

  ConnectedHub._(this._cobi);

  /// A future that emits true if the app is currently connected to a hub and
  /// that hub is mounted on a supported e-bike. If true is returned, the
  /// properties that depend on a motor being present will work as expected.
  // TODO Add docs link to ebike API when it's done
  Future<bool> get isOnSupportedEBike =>
      _msgs.replyFromCacheOrRead(Hub.motorInterfaceReady);

  /// A stream that reports whether the bell built into the COBI.Bike hub is
  /// ringing at the moment or not.
  Stream<bool> get bellRinging => _msgs.observeValuesOf(Hub.bellRinging);

  /// Emits items when the user presses a button on the thumb controller on
  /// their handlebar. You should consider actions coming from this stream as
  /// first-class input and, for instance, allow the user to navigate in your
  /// module with these actions. For details, check the
  /// [guidelines](https://github.com/cobi-bike/DevKit/blob/master/interface-guidelines.md#the-screen-is-optional-remote-control-touch--voice-feedback).
  Stream<ThumbControllerAction> get buttonPresses =>
      _msgs.observeValuesOf(Hub.externalInterfaceAction);

  /// Queries the ambient light sensor to report on the brightness around the
  /// bike.
  Future<AmbientLightState> get ambientLight =>
      _msgs.readAndGetFirstReply(Hub.ambientLightState);

  /// Emits values as this hub reports different values from it's light sensor.
  Stream<AmbientLightState> observeAmbientLight() =>
      _msgs.observeValuesOf(Hub.ambientLightState);

  /// Information about the battery. Depending on whether the user is riding
  /// an Bosch e-bike or not, this value will report the state of the e-bike
  /// battery or the battery built into the hub. This will return a snapshot
  /// of the current battery condition.
  Future<BatteryCondition> get batteryCondition =>
      _msgs.replyFromCacheOrRead(Battery.state);

  /// Information about the battery. Depending on whether the user is riding
  /// an Bosch e-bike or not, this value will report the state of the e-bike
  /// battery or the battery built into the hub. This will return a stream that
  /// automatically updates whenever the charging level of the battery changes.
  Stream<BatteryCondition> observeBattery() =>
      _msgs.observeValuesOf(Battery.state);
}
