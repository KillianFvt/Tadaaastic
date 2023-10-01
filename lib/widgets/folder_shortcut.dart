import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class FolderShortcut extends StatefulWidget {
  const FolderShortcut({super.key});

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
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
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
            )
          ],
        ),

    );
  }
}
