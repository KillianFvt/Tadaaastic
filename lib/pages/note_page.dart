import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

        child: CustomScrollView(
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
                  child: QuillWidget(focusNode: _focusNode,),
                ),
              )
          ],
        ),

      )
    );
  }
}
