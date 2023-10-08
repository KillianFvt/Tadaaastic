import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tadaaastic/widgets/quill_embed_blocks/embed_test.dart';



class QuillWidget extends StatefulWidget {

  final FocusNode focusNode;
  final QuillController controller;

  const QuillWidget({
    super.key,
    required this.focusNode,
    required this.controller,
  });

  @override
  State<QuillWidget> createState() => _QuillWidgetState();
}

class _QuillWidgetState extends State<QuillWidget> {

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 200,
      ),
      child: Container(
        color: Colors.black,
        child: QuillEditor.basic(
          controller: widget.controller,
          focusNode: widget.focusNode,
          readOnly: false,
          autoFocus: false,
          expands: false,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),

          embedBuilders: <EmbedBuilder>[
            RedBoxEmbedBuilder(),
          ],
        ),
      ),
    );
  }
}
