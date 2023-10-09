import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/material.dart';

int searchLineStart(QuillController controller, int position) {
  if (controller.selection.start == 0) {
    return 0;
  } else {
    final text = controller.document.toPlainText();
    final lineStart = text.lastIndexOf('\n', position - 1);
    return lineStart + 1;
  }
}