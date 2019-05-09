import 'package:devkit/devkit.dart';
import 'package:flutter_web/widgets.dart';
import 'package:flutter_web_ui/ui.dart';

class CobiColors {
  const CobiColors._();

  // https://github.com/cobi-bike/DevKit-UI/blob/master/sass/_variables.scss#L15

  static const Color surf = Color(0xFF00C8E6);
  static const Color surfDark = Color(0xFF007D90);

  static const Color coral = Color(0xFFFA4B69);

  static const Color tarmac = Color(0xFF2D2D37);
  static const Color defaultBg = Color(0xFFF7F7F7);

  static const Color positive = Color(0xFF5cb85c);
  static const Color negative = Color(0xFFd9534f);
}

class CobiAppTheme {
  final Color accentColor;
  final Color baseColor;
  final Color background;

  final bool touchInteractionEnabled;

  const CobiAppTheme(
      {this.accentColor,
      this.baseColor,
      this.background,
      this.touchInteractionEnabled = true});
  const CobiAppTheme.defaults()
      : accentColor = CobiColors.surf,
        baseColor = CobiColors.surfDark,
        background = CobiColors.defaultBg,
        touchInteractionEnabled = true;

  CobiAppTheme copyWith(
      {Color accentColor,
      Color baseColor,
      Color background,
      bool touchInteractionEnabled}) {
    return CobiAppTheme(
      accentColor: accentColor ?? this.accentColor,
      baseColor: baseColor ?? this.baseColor,
      background: background ?? this.background,
      touchInteractionEnabled:
          touchInteractionEnabled ?? this.touchInteractionEnabled,
    );
  }

  static CobiAppTheme of(BuildContext context) {
    return CobiProvider.themeOf(context) ?? const CobiAppTheme.defaults();
  }
}

class CobiProvider extends InheritedWidget {
  final CobiAppTheme theme;
  final Cobi cobi;

  const CobiProvider({
    Key key,
    @required Widget child,
    @required this.theme,
    @required this.cobi,
  })  : assert(child != null),
        super(key: key, child: child);

  static CobiAppTheme themeOf(BuildContext context) {
    final provider = context.inheritFromWidgetOfExactType(CobiProvider,
        aspect: CobiAppTheme);
    return (provider as CobiProvider)?.theme;
  }

  static Cobi cobiOf(BuildContext context) {
    final provider =
        context.inheritFromWidgetOfExactType(CobiProvider, aspect: Cobi);
    return (provider as CobiProvider)?.cobi;
  }

  @override
  bool updateShouldNotify(CobiProvider old) {
    return false;
  }
}
