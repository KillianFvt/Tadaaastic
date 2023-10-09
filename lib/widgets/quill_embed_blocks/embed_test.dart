import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class QuillCheckBox extends StatefulWidget {
  const QuillCheckBox({super.key});

  @override
  State<QuillCheckBox> createState() => _QuillCheckBoxState();
}

class _QuillCheckBoxState extends State<QuillCheckBox> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
        height: 25,
        width: 25,
        child: GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
            print('isChecked: $isChecked');
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.indigo,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Opacity(
              opacity: isChecked ? 1 : 0,
              child: const SizedBox(
                height: 25,
                width: 25,
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
        ),
      ),
    );;
  }
}


class RedBoxEmbedBuilder extends quill.EmbedBuilder {
  RedBoxEmbedBuilder();

  @override
  String get key => 'redbox';

  @override
  bool get expanded => false;

  @override
  Widget build(BuildContext context,
      quill.QuillController controller,
      Embed node,
      bool readOnly,
      bool inline,
      TextStyle textStyle,) {

    return const QuillCheckBox();
  }
}

class RedBoxEmbed extends quill.CustomBlockEmbed {
  RedBoxEmbed(super.type, super.data);

  static const String redBoxType = 'redbox';

  String get key => redBoxType;
}

// Todo REMEMBER HOW TO USE THIS ISHT
