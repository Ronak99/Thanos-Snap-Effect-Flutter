import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snappable/snappable.dart';

void main() => runApp(MyApp());

final reactKey = GlobalKey<SnappableState>();
final xamarinKey = GlobalKey<SnappableState>();
final ionicKey = GlobalKey<SnappableState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AppBody(),
      ),
    );
  }
}

class FlutterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 200,
          left: 30,
          child: Snappable(
            snapOnTap: true,
            child: FlutterLogo(
              size: 350,
            ),
          ),
        )
      ],
    );
  }
}

class AppBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Gauntlet(),
        OtherFrameworks(),
      ],
    );
  }
}

class OtherFrameworks extends StatefulWidget {
  @override
  _OtherFrameworksState createState() => _OtherFrameworksState();
}

class _OtherFrameworksState extends State<OtherFrameworks> {
  String xamarin =
      "https://pspdfkit.com/images/guides/shared/other-languages/xamarin/xamarin-logo-3175f8b9.png";
  String react =
      "https://cdn4.iconfinder.com/data/icons/logos-3/600/React.js_logo-512.png";
  String ionic =
      "https://discoversdkcdn.azureedge.net/postscontent/cropped-ionic-logo-horizontal-transparent.png";

  @override
  Widget build(BuildContext context) {
    var middle = MediaQuery.of(context).size.width / 2;

    return Positioned(
      top: 400,
      left: middle - 75,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Snappable(
            key: reactKey,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                react,
              ),
            ),
          ),
          Snappable(
            key: xamarinKey,
            offset: Offset(-64, 32),
            child: SizedBox(
              height: 80,
              width: 150,
              child: Image.network(
                xamarin,
              ),
            ),
          ),
          Snappable(
            key: ionicKey,
            offset: Offset(-32, 64),
            child: SizedBox(
              height: 80,
              width: 150,
              child: Image.network(
                ionic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Gauntlet extends StatefulWidget {
  @override
  GauntletState createState() => GauntletState();
}

class GauntletState extends State<Gauntlet> {
  String gauntletUrl = "gauntlet.PNG";
  final key = GlobalKey<SnappableState>();

  void snapGauntlet() {
    setState(() {
      gauntletUrl = "gauntlet_snapping.PNG";
    });

    ionicKey.currentState.isGone
        ? bringBackIonic()
        : ionicKey.currentState.snap();

    xamarinKey.currentState.isGone
        ? xamarinKey.currentState.reset()
        : xamarinKey.currentState.snap();

    reactKey.currentState.isGone
        ? reactKey.currentState.reset()
        : reactKey.currentState.snap();

    Timer(Duration(milliseconds: 300), () {
      setState(() {
        gauntletUrl = "gauntlet.PNG";
      });
    });
  }

  void bringBackIonic() {
    try {
      ionicKey.currentState.reset();
    } catch (e) {
      print("problem");
    }
  }

  @override
  Widget build(BuildContext context) {
    var middle = MediaQuery.of(context).size.width / 2;
    double flutterLogoSize = 150;

    return Positioned(
      top: 100,
      left: middle - flutterLogoSize / 2,
      child: SizedBox(
        height: flutterLogoSize + 30,
        width: flutterLogoSize + 30,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: FlutterLogo(
                size: flutterLogoSize,
              ),
              onTap: () => snapGauntlet(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(gauntletUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
