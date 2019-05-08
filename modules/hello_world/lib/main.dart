import 'package:flutter_web/material.dart';
import 'package:devkit/devkit.dart' hide Theme;
import 'package:rxdart/rxdart.dart'; // Theme clashes with Flutter

void main() {
  Cobi.simulatorCompatibility = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COBI DevKit Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Demoing COBI DevKit with Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Cobi cobi = Cobi();
  int counter = null;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  void _setup() async {
    await cobi.init('my-secret-little-token');
    setState(() {
      counter = 0;
    });

    final thumbControllerActions = Observable(cobi.connectedHub).switchMap<ThumbControllerAction>((hub) {
      if (hub.isPresent) {
        return hub.value.buttonPresses;
      } else {
        return Observable.empty();
      }
    });

    thumbControllerActions.listen((action) {
      if (action == ThumbControllerAction.down) {
        setState(() {
          counter--;
        });
      } else if (action == ThumbControllerAction.up) {
        setState(() {
          counter++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Try to increment this number with the thumb controller',
            ),
            if (counter == null) // Still initializing
              CircularProgressIndicator()
            else
              Text('$counter', style: Theme.of(context).textTheme.headline)
          ],
        ),
      ),
    );
  }

}
