/// {@template devkit_dart/context}
/// A context represents where a module has been opened (dashboard, home,
/// settings, etc.). You can query this context after a page load to show
/// different content when your module has been opened from the homescreen or
/// from the dashboard.
/// {@endtemplate}
enum Context {

  /// Context for modules launched from the dashboard of the COBI.Bike app while
  /// it is attached to a bike.
  onRide,
  /// Context for modules launched from the homescreen of the COBI.Bike app
  offRide,
  /// Context for modules launched from the dashboard of the COBI.Bike app, but
  /// in settings mode. If you want to, you can differentiate between this and
  /// [Context.onRide] to show different content when the user has chosen to
  /// go do the settings of your module.
  onRideSettings,
  /// Context for modules launched from the homescreen of the COBI.Bike app, but
  /// in settings mode. You can differentiate between this context and
  /// [Context.offRide] to show a settings screen instead.
  offRideSettings

}