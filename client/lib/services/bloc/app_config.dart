// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

class AppConfiguration with ChangeNotifier {
  bool _debugShowGrid = false;
  bool _debugShowSizes = false;
  bool _debugShowBaselines = false;
  bool _debugShowLayers = false;
  bool _debugShowPointers = false;
  bool _debugShowRainbow = false;
  bool _showPerformanceOverlay = false;
  bool _showSemanticsDebugger = false;

  bool get debugShowGrid => _debugShowGrid;
  bool get debugShowSizes => _debugShowSizes;
  bool get debugShowBaselines => _debugShowBaselines;
  bool get debugShowLayers => _debugShowLayers;
  bool get debugShowPointers => _debugShowPointers;
  bool get debugShowRainbow => _debugShowRainbow;
  bool get showPerformanceOverlay => _showPerformanceOverlay;
  bool get showSemanticsDebugger => _showSemanticsDebugger;

  void init() {
    _debugShowGrid = false;
    _debugShowSizes = false;
    _debugShowBaselines = false;
    _debugShowLayers = false;
    _debugShowPointers = false;
    _debugShowRainbow = false;
    _showPerformanceOverlay = false;
    _showSemanticsDebugger = false;
  }

  void change(
      {bool debugShowGrid,
      bool debugShowSizes,
      bool debugShowBaselines,
      bool debugShowLayers,
      bool debugShowPointers,
      bool debugShowRainbow,
      bool showPerformanceOverlay,
      bool showSemanticsDebugger}) {
    _debugShowGrid = debugShowGrid ?? _debugShowGrid;
    _debugShowSizes = debugShowSizes ?? _debugShowSizes;
    _debugShowBaselines = debugShowBaselines ?? _debugShowBaselines;
    _debugShowLayers = debugShowLayers ?? _debugShowLayers;
    _debugShowPointers = debugShowPointers ?? _debugShowPointers;
    _debugShowRainbow = debugShowRainbow ?? _debugShowRainbow;
    _showPerformanceOverlay = showPerformanceOverlay ?? _showPerformanceOverlay;
    _showSemanticsDebugger = showSemanticsDebugger ?? _showSemanticsDebugger;
    notifyListeners();
  }
}
