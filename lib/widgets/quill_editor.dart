import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';


class QuillWidget extends StatefulWidget {

  final FocusNode focusNode;

  const QuillWidget({
    super.key,
    required this.focusNode,
  });

  @override
  State<QuillWidget> createState() => _QuillWidgetState();
}

class _QuillWidgetState extends State<QuillWidget> {


  final QuillController _controller = QuillController.basic();

  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  //todo add globalkey and move btn

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        IconButton(
          icon: const Icon(Icons.add),
          color: _isMenuOpen ? Colors.white : Colors.grey,
          tooltip: 'Gras',
          onPressed: _toggleMenu,
        ),
        _isMenuOpen ? QuillToolbar.basic(
          controller: _controller,
          toolbarIconSize: 20,
          color: Colors.white,
          showHeaderStyle: false,
          showClearFormat: false,
          showIndent: false,
          showInlineCode: false,
          showSearchButton: false,
          showSubscript: false,
          showQuote: false,
          showLink: false,
          showCodeBlock: false,
          iconTheme: const QuillIconTheme(
            iconUnselectedColor: Colors.white,
            iconSelectedColor: Colors.white,
          ),
        ) : Container(),



        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 200,
          ),
          child: Container(
            color: Colors.black,
            child: QuillEditor.basic(
              controller: _controller,
              focusNode: widget.focusNode,
              readOnly: false,
              autoFocus: false,
              expands: false,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),

            ),
          ),
        ),
      ],
    );
  }
}
