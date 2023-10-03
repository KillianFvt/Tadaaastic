import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tadaaastic/widgets/fractional_border_radius_container.dart';



class FolderShortcut extends StatefulWidget {
  final Color color;
  final String name;
  final int noteAmt;

  const FolderShortcut({super.key,
    this.name = "Du le miam",
    this.noteAmt = 99,
    this.color = Colors.white,
  });

  @override
  State<FolderShortcut> createState() => _FolderShortcutState();
}

class _FolderShortcutState extends State<FolderShortcut> with SingleTickerProviderStateMixin {
  static double _scaleTransformValue = 1;
  static const _durationMilliseconds = 100;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: _durationMilliseconds),
    vsync: this,

  )..addListener(() {
    setState(() => _scaleTransformValue = _animation.value);
  });


  late final Animation<double> _animationCurve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  late final Animation<double> _animation = Tween(begin: 1.0, end: 0.9).animate(_animationCurve);

  void shrink() {
    _controller.forward();
  }

  void restore() {
    Future.delayed(
      const Duration(milliseconds: _durationMilliseconds),
          () => _controller.reverse(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        shrink();
        restore();
      },

      onTapDown: (tdd) {
        shrink();
      },

      onTapCancel: () {
        restore();
      },

      onLongPress: () {

      },

      child: Transform.scale(
        scale: _scaleTransformValue,

        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              children: [

                FractionalTranslation(
                  translation: const Offset(0.15,0.3),
                  child: FractionallySizedBox(
                      alignment: Alignment.center,
                      widthFactor: 0.8, heightFactor: 0.5,

                      child: FractionalBorderRadiusContainer(
                        borderRadiusFactor: 0.04,
                        color: widget.color,
                      )
                  ),
                ),

                Center(
                  child: SvgPicture.asset(
                    "assets/svg/folder.svg",
                    theme: const SvgTheme(
                      currentColor: Color(0xFF171717)
                    ),
                    colorFilter: const ColorFilter.mode(Color(0xFF171717), BlendMode.srcIn),
                    fit: BoxFit.contain,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),

                PositionedDirectional(
                    bottom: 15,
                    start: 10,
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    )
                ),

                PositionedDirectional(
                    top: 14,
                    start: 10,
                    child: Text(
                      "${widget.noteAmt}",
                      style: const TextStyle(
                        color: Color(0xFF949494),
                        fontSize: 10,
                      ),
                    )
                )
              ],
            ),
        ),
      ),
    );
  }
}