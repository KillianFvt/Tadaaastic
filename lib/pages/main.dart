import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tadaaastic/pages/note_page.dart';
import 'package:tadaaastic/widgets/folder_shortcut.dart';

import '../hive_adapters/color_adapter.dart';


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
      home: const GeneralOverview(title: 'Tadaastic'),
    );
  }
}

class GeneralOverview extends StatefulWidget {
  const GeneralOverview({super.key, required this.title});

  final String title;

  @override
  State<GeneralOverview> createState() => _GeneralOverviewState();
}

class _GeneralOverviewState extends State<GeneralOverview> {

  List<Widget> folders = [
    const FolderShortcut(color: Color(0xFF5B20A5)),
    const FolderShortcut(color: Color(0xFFB56B15)),
    const FolderShortcut(color: Color(0xFF208DA5)),
    const FolderShortcut(color: Color(0xFF53A520)),
    const FolderShortcut(color: Color(0xFFA52020)),
  ];

  void newNote() {
    Navigator.push(context, MaterialPageRoute(
        builder:
            (context) => const NotePage(
              name: "Test",
              noteId: 0,
              parentId: 1,
            )
    ));
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      floatingActionButton: FloatingActionButton(
          onPressed: newNote,
          tooltip: 'Nouvelle note',
          child: const Icon(Icons.add)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,

      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[

            const SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              backgroundColor: Colors.teal,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Demo'),
              ),
            ),
            
            SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100.0,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 1,
                  ),

                  delegate: SliverChildListDelegate(
                    folders
                  ),
                ),
            ),

            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2 / 1,
              ),

              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },

                childCount: 13,
              )
            ),
          ],
        ),
      )
    );
  }
}
