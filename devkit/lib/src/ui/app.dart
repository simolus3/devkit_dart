import 'dart:async';

import 'package:devkit/devkit.dart';
import 'package:flutter_web/widgets.dart';

/// Signature for a function building a widget based on the [Context] the app is
/// opened in.
typedef ContentBuilder = Widget Function(Context context);

class DevKitApp extends StatefulWidget {
  final String title;
  final String accessToken;

  const DevKitApp({Key key, this.title, @required this.accessToken})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<DevKitApp> {
  Cobi _cobi;

  List<StreamSubscription> _streamSubscriptions = [];
  CobiAppTheme _theme = CobiAppTheme.defaults();

  @override
  void initState() {
    super.initState();

    _cobi = Cobi();
    _cobi.init(widget.accessToken);

    _streamSubscriptions.add(_cobi.touchInteractionEnabled.listen((enabled) {
      _updateTheme(_theme.copyWith(touchInteractionEnabled: enabled));
    }));

    _cobi.loadAppTheme().then((nativeTheme) {
      _updateTheme(_theme.copyWith(
        accentColor: nativeTheme.accentColor.dartColor,
        baseColor: nativeTheme.baseColor.dartColor,
        background: nativeTheme.backgroundColor.dartColor,
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();

    _streamSubscriptions.forEach((s) => s.cancel());
  }

  void _updateTheme(CobiAppTheme theme) {
    setState(() {
      _theme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CobiProvider(
      theme: _theme,
      cobi: _cobi,
      child: WidgetsApp(
        color: CobiColors.surf,
      ),
    );
  }
}
