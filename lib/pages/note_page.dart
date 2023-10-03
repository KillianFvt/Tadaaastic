import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(widget.name),
      ),
    );
  }
}
