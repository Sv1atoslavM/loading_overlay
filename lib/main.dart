import 'package:flutter/material.dart';
import 'package:loading_overlay/full_screen_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  OverlayEntry? _loadingIndicator;

  NavigatorState? get _navigator => _navigatorKey.currentState;
  OverlayState? get _overlay => _navigator?.overlay;

  void _showLoadingIndicator() {
    if (_overlay == null) return;
    _loadingIndicator = OverlayEntry(
      builder: (context) => FullScreenLoader(
        barrierColor: Colors.black.withOpacity(0.33),
      ),
    );
    _overlay!.insert(_loadingIndicator!);
  }

  void _hideLoadingIndicator() {
    if (_loadingIndicator == null) return;
    _loadingIndicator!.remove();
    _loadingIndicator = null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: InkWell(
            onTap: () => print('tap'),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  _showLoadingIndicator();
                  await Future.delayed(
                    const Duration(seconds: 5),
                    _hideLoadingIndicator,
                  );
                },
                child: const Text('Loading'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
