import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tadaaastic/hive_adapters/color_adapter.dart';


void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(ColorAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(
            background: Colors.black),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'Tadaastic'),
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

  late Box colorBox;
  Color currentColor = const Color(0xff443a49);

  @override
  void initState() {
    loadAsyncs();
    super.initState();
  }

  void loadAsyncs() async {
    colorBox = await Hive.openBox('colorBox');
    currentColor = colorBox.get("currentColor") ?? const Color(0xff443a49);
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  void updateColorBox() {
    colorBox.put('currentColor', currentColor);
    print("Color updated in hive, now set to $currentColor");
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$currentColor',
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(color: currentColor),
            ),

            GestureDetector(
              onTapUp: (tapUpDetails) => updateColorBox(),
              child: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Ajouter une note',
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
