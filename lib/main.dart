import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double dx = 100, dy = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      dx = screenSize.width / 2;
      dy = screenSize.height / 2;

      SensorsPlatform.instance.gyroscopeEvents.listen((GyroscopeEvent event) {
        setState(() {
          dx = (dx + event.y * 20).clamp(0.0, screenSize.width - 40);
          dy = (dy + event.x * 20).clamp(0.0, screenSize.height - 40);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Transform.translate(
        offset: Offset(dx, dy),
        child: CircleAvatar(
          radius: 20,
        ),
      ),
    );
  }
}
