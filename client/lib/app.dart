import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart'
    show
        debugPaintSizeEnabled,
        debugPaintBaselinesEnabled,
        debugPaintLayerBordersEnabled,
        debugPaintPointersEnabled,
        debugRepaintRainbowEnabled;
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:com.winwisely99.app/services/services.dart';
import 'navigation.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppConfiguration _configuration =
        Provider.of<AppConfiguration>(context);
    assert(() {
      debugPaintSizeEnabled = _configuration.debugShowSizes;
      debugPaintBaselinesEnabled = _configuration.debugShowBaselines;
      debugPaintLayerBordersEnabled = _configuration.debugShowLayers;
      debugPaintPointersEnabled = _configuration.debugShowPointers;
      debugRepaintRainbowEnabled = _configuration.debugShowRainbow;
      return true;
    }());
    return MaterialApp(
      title: 'WinWisely99',
      initialRoute: '/',
      locale: DevicePreview.of(context)?.locale, // <--
      builder: DevicePreview.appBuilder, // <--
      debugShowMaterialGrid: _configuration.debugShowGrid,
      showPerformanceOverlay: _configuration.showPerformanceOverlay,
      showSemanticsDebugger: _configuration.showSemanticsDebugger,
      onGenerateRoute: routes,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        fontFamily: 'Roboto',
      ),
    );
  }
}
