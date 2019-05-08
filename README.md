# DevKit Dart
A pure Dart implementation of the [COBI.Bike DevKit](https://cobi.bike/devkit) built on top
of [Flutter Web](https://github.com/flutter/flutter_web).

## Using
For getting started with Flutter web, see 
[their readme](https://github.com/flutter/flutter_web).
Then, add another dependency for this library in the `pubspec.yaml`:

```yaml
dependencies:
  # ...
  devkit: any

dependency_overrides:
  devkit:
    git:
      url: https://github.com/simolus3/devkit_dart
      path: devkit
```

A working example can be found [here](https://github.com/simolus3/devkit_dart/blob/5aff70e8bd862734280ebe8f68633e8609b68906/modules/hello_world/lib/main.dart#L34-L67),
the relevant lines are highlighted. Don't forget to set `Cobi.simulatorCompatibility` to 
`true` before initializing the `Cobi` object when testing in the [Simulator](https://github.com/cobi-bike/DevKit-Simulator).

## Project structure
- `/devkit`: Main API, to be used by developers
- `/message_compiler`: Responsible to generate serialization and deserialization code used
to communicate with the host app. Only used during development of this library.

I'll write a bunch of example modules and put them in the `/modules` subfolder.


This project is not affiliated with, or endorsed by, COBI.Bike.