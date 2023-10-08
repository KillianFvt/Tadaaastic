import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:tadaaastic/widgets/floating_quill_toolbox.dart';
import 'package:tadaaastic/widgets/quill_editor.dart' show QuillWidget;
import 'package:tadaaastic/widgets/fqt_toggler.dart';
import 'package:tadaaastic/widgets/quill_embed_blocks/embed_test.dart';


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

class _NotePageState extends State<NotePage> with WidgetsBindingObserver {

  final FocusNode _focusNode = FocusNode();
  final quill.QuillController _controller = quill.QuillController.basic();

  final GlobalKey<FloatingQuillToolboxState> floatingQuillToolboxKey = GlobalKey();
  final GlobalKey<PositionedFQTTogglerState> fqtPosTogglerKey = GlobalKey();

  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final double bottomInset = MediaQuery.of(context).viewInsets.vertical;
    final bool newValue = bottomInset > 0.0;
    if (newValue != isKeyboardVisible) {
      setState(() {
        isKeyboardVisible = newValue;
      });
      if (!isKeyboardVisible) {
        floatingQuillToolboxKey.currentState!.closeMenu();
        fqtPosTogglerKey.currentState!.reset();
        _focusNode.unfocus();
      } else {
        floatingQuillToolboxKey.currentState!.openMenu();
        fqtPosTogglerKey.currentState!.open();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

        child: WillPopScope(


          onWillPop: () async {
            return _focusNode.hasFocus ? false : true;
          },


          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                    SliverAppBar(
                      pinned: true,
                      snap: true,
                      floating: true,
                      stretch: true,

                      shape: const Border(
                        bottom: BorderSide(
                          color: Color(0xFF252525),
                          width: 0.5,
                        ),
                      ),

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
                        onPressed: () {
                          floatingQuillToolboxKey.currentState!.closeMenu();
                          Navigator.of(context).pop();
                        },
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

                        IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          color: Colors.white,
                          tooltip: 'yes',
                          onPressed: () {

                            // insert a redbox embed into the editor
                            final block = quill.BlockEmbed.custom(
                              RedBoxEmbed(
                                RedBoxEmbed.redBoxType,
                                'This is a red box embed gregrgrdgrdgrdgdrgrdgrdgrdgrdgrdgrdgrd',
                                // Todo REMEMBER HOW TO USE THIS ISHT
                              ),
                            );

                            final controller = _controller;
                            final index = controller.selection.baseOffset;
                            final length = controller.selection.extentOffset - index;

                            controller.replaceText(index, length, block, null);

                          },
                        ),
                      ],
                    ),

                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.black,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,


                          child: QuillWidget(
                            focusNode: _focusNode,
                            controller: _controller,
                          ),
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

              PositionedFQTToggler(
                key: fqtPosTogglerKey,
                onPressed: () {
                  floatingQuillToolboxKey.currentState!.toggleMenu();
                },
              ),
            ],
          ),
        ),

      )
    );
  }
}
