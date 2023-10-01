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
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},  //TODO make the function

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
                      borderRadiusFactor: 0.2,
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

              // TODO add the name

              // TODO add the note count
            ],
          ),

      ),
    );
  }
}
