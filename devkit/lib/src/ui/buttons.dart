import 'package:devkit/devkit.dart';
import 'package:flutter_web/widgets.dart';

class CobiButton extends StatelessWidget {
  final Color background;
  final Widget child;
  final VoidCallback onPressed;

  CobiButton(
      {@required this.child,
      @required this.onPressed,
      this.background,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resolvedColor = background ?? CobiAppTheme.of(context).accentColor;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: resolvedColor,
          shape: StadiumBorder(),
          shadows: [
            BoxShadow(
              offset: Offset(0, 1),
              color: CobiColors.tarmac,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 14),
          child: DefaultTextStyle(
            style: TextStyle(color: CobiColors.tarmac),
            child: child,
          ),
        ),
      ),
    );
  }
}
