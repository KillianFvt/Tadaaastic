import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class FloatingQuillToolbox extends StatefulWidget {
  final FocusNode focusNode;
  final QuillController controller;
  final bool isMenuOpen;

  const FloatingQuillToolbox({
    super.key,
    required this.focusNode,
    required this.controller,
    this.isMenuOpen = false,
  });

  @override
  State<FloatingQuillToolbox> createState() => FloatingQuillToolboxState();
}

class FloatingQuillToolboxState extends State<FloatingQuillToolbox> with SingleTickerProviderStateMixin {


  late double bottomShift = MediaQuery.of(context).viewInsets.bottom;

  static double _toolboxBottomShift = 80;

  double get toolboxBottomShift => _toolboxBottomShift;

  static const _durationMilliseconds = 250;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: _durationMilliseconds),
    vsync: this,

  )..addListener(() {
    setState(() => _toolboxBottomShift = _animation.value);
  });


  late final Animation<double> _animationCurve = CurvedAnimation(parent: _controller, curve: Curves.easeInSine);

  late final Animation<double> _animation = Tween(begin: 80.0, end: 0.0).animate(_animationCurve);

  void openMenu() {
    _controller.forward();
  }

  void closeMenu() {
    _controller.reverse();
  }

  void toggleMenu([bool? force]) {
    if (force != null) {
      if (force) {
        openMenu();
      } else {
        closeMenu();
      }
    } else {
      if (_controller.isCompleted) {
        closeMenu();
      } else {
        openMenu();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    closeMenu();
  }

  @override
  void dispose() {
    closeMenu();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        bottom: 0 - _toolboxBottomShift,

        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),

            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
              ),

              child: Opacity(
                opacity: 1 - (_toolboxBottomShift / 80),

                child: SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width,

                  child: QuillToolbar.basic(
                    controller: widget.controller,
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
                    showFontSize: true,
                    iconTheme: const QuillIconTheme(
                      iconUnselectedColor: Colors.white,
                      iconSelectedColor: Colors.white,
                      iconSelectedFillColor: Colors.transparent,
                      iconUnselectedFillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
