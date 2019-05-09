/// The COBI.Bike DevKit is a javascript library to talk to COBI.Bike apps and
/// use their functionality programmatically. This gives you an easy access to
/// a lot of ride data and allows you to control cool features of the COBI.BIKE
/// system. This library is a pure-dart re-implementation of that library for
/// modern Dart webapps which can then be used as modules inside of COBI.Bike
/// apps.
/// Check out the [readme](https://github.com/simolus3/devkit_dart) of this
/// library or the documentation of the [Cobi] class on how to get started.
library devkit;

// for docs
import 'package:devkit/src/api/cobi.dart';

export 'package:devkit/src/spec/format.cobi.dart'
    hide writeWithPath, parseWithPath, channels, specVersion;

export 'package:devkit/src/api/cobi.dart';
export 'package:devkit/src/spec/context.dart';

export 'package:devkit/src/ui/app.dart';
export 'package:devkit/src/ui/buttons.dart';
export 'package:devkit/src/ui/theming.dart';
