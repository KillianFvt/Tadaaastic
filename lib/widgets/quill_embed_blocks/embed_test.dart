import 'package:flutter/material.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class RedBoxEmbedBuilder extends quill.EmbedBuilder {
  RedBoxEmbedBuilder();

  @override
  String get key => 'redbox';

  @override
  Widget build(BuildContext context,
      quill.QuillController controller,
      Embed node,
      bool readOnly,
      bool inline,
      TextStyle textStyle,) {
    final text = node.value.data;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text),
    );
  }
}

class RedBoxEmbed extends quill.CustomBlockEmbed {
  RedBoxEmbed(super.type, super.data);

  static const String redBoxType = 'redbox';

  String get key => redBoxType;
}

// Todo REMEMBER HOW TO USE THIS ISHT
