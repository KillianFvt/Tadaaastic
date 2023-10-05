import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:tadaaastic/widgets/floating_quill_toolbox.dart';
import '../widgets/quill_editor.dart';

class NotePage extends StatefulWidget {

  final String name;
  final int noteId;
  final int parentId;

  const NotePage({
    super.key,
    required this.name,
    required this.noteId,
    required this.parentId,
  });

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  final FocusNode _focusNode = FocusNode();
  final quill.QuillController _controller = quill.QuillController.basic();

  final GlobalKey<FloatingQuillToolboxState> floatingQuillToolboxKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                  SliverAppBar(
                    pinned: true,
                    snap: true,
                    floating: true,
                    stretch: true,

                    backgroundColor: Colors.black,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(widget.name),
                    ),

                    leading: IconButton(
                      icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white
                      ),
                      tooltip: 'Retour',
                      onPressed: () => Navigator.of(context).pop(),
                    ),

                    actions: [
                      IconButton(
                          onPressed: () {
                            floatingQuillToolboxKey.currentState!.toggleMenu();
                          },
                          icon: const Icon(Icons.add, color: Colors.white)
                      ),

                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.white),
                        color: Colors.white,
                        tooltip: 'Sauvegarder',
                        onPressed: () {
                          _focusNode.unfocus();
                        },
                      ),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: QuillWidget(
                        focusNode: _focusNode,
                        controller: _controller,
                      ),
                    ),
                  )
              ],
            ),

            FloatingQuillToolbox(
              key: floatingQuillToolboxKey,
              focusNode: _focusNode,
              controller: _controller,
            ),
          ],
        ),

      )
    );
  }
}
