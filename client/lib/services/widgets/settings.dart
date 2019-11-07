import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/app_config.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppConfiguration configuration =
        Provider.of<AppConfiguration>(context);
    void _handleShowGridChanged(bool value) {
      configuration.change(debugShowGrid: value);
    }

    void _handleShowSizesChanged(bool value) {
      configuration.change(debugShowSizes: value);
    }

    void _handleShowBaselinesChanged(bool value) {
      configuration.change(debugShowBaselines: value);
    }

    void _handleShowLayersChanged(bool value) {
      configuration.change(debugShowLayers: value);
    }

    void _handleShowPointersChanged(bool value) {
      configuration.change(debugShowPointers: value);
    }

    void _handleShowRainbowChanged(bool value) {
      configuration.change(debugShowRainbow: value);
    }

    void _handleShowPerformanceOverlayChanged(bool value) {
      configuration.change(showPerformanceOverlay: value);
    }

    void _handleShowSemanticsDebuggerChanged(bool value) {
      configuration.change(showSemanticsDebugger: value);
    }

    Widget buildAppBar(BuildContext context) {
      return AppBar(title: const Text('Settings'));
    }

    Widget buildSettingsPane(BuildContext context) {
      final List<Widget> rows = <Widget>[
        ListTile(
          leading: const Icon(Icons.picture_in_picture),
          title: const Text('Show rendering performance overlay'),
          onTap: () {
            _handleShowPerformanceOverlayChanged(
                !configuration.showPerformanceOverlay);
          },
          trailing: Switch(
            value: configuration.showPerformanceOverlay,
            onChanged: _handleShowPerformanceOverlayChanged,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.accessibility),
          title: const Text('Show semantics overlay'),
          onTap: () {
            _handleShowSemanticsDebuggerChanged(
                !configuration.showSemanticsDebugger);
          },
          trailing: Switch(
            value: configuration.showSemanticsDebugger,
            onChanged: _handleShowSemanticsDebuggerChanged,
          ),
        ),
      ];
      assert(() {
        // material grid and size construction lines are only available in checked mode
        rows.addAll(<Widget>[
          ListTile(
            leading: const Icon(Icons.border_clear),
            title: const Text('Show material grid (for debugging)'),
            onTap: () {
              _handleShowGridChanged(!configuration.debugShowGrid);
            },
            trailing: Switch(
              value: configuration.debugShowGrid,
              onChanged: _handleShowGridChanged,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.border_all),
            title: const Text('Show construction lines (for debugging)'),
            onTap: () {
              _handleShowSizesChanged(!configuration.debugShowSizes);
            },
            trailing: Switch(
              value: configuration.debugShowSizes,
              onChanged: _handleShowSizesChanged,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.format_color_text),
            title: const Text('Show baselines (for debugging)'),
            onTap: () {
              _handleShowBaselinesChanged(!configuration.debugShowBaselines);
            },
            trailing: Switch(
              value: configuration.debugShowBaselines,
              onChanged: _handleShowBaselinesChanged,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.filter_none),
            title: const Text('Show layer boundaries (for debugging)'),
            onTap: () {
              _handleShowLayersChanged(!configuration.debugShowLayers);
            },
            trailing: Switch(
              value: configuration.debugShowLayers,
              onChanged: _handleShowLayersChanged,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.mouse),
            title: const Text('Show pointer hit-testing (for debugging)'),
            onTap: () {
              _handleShowPointersChanged(!configuration.debugShowPointers);
            },
            trailing: Switch(
              value: configuration.debugShowPointers,
              onChanged: _handleShowPointersChanged,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.gradient),
            title: const Text('Show repaint rainbow (for debugging)'),
            onTap: () {
              _handleShowRainbowChanged(!configuration.debugShowRainbow);
            },
            trailing: Switch(
              value: configuration.debugShowRainbow,
              onChanged: _handleShowRainbowChanged,
            ),
          ),
        ]);
        return true;
      }());
      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        children: rows,
      );
    }

    return Scaffold(
        appBar: buildAppBar(context), body: buildSettingsPane(context));
  }
}
