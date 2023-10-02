import 'package:flutter/material.dart';

class FractionalBorderRadiusContainer extends StatefulWidget {
  final double? width;
  final double? height;
  final Color color;
  final double borderRadiusFactor;
  final Widget? child;

  const FractionalBorderRadiusContainer({super.key,
    required this.borderRadiusFactor,
    this.width,
    this.height,
    this.color = Colors.white,
    this.child,
  });

  @override
  State<FractionalBorderRadiusContainer> createState() => _FractionalBorderRadiusContainerState();
}

class _FractionalBorderRadiusContainerState extends State<FractionalBorderRadiusContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(
          widget.borderRadiusFactor *
              (widget.width ?? 1 * MediaQuery.of(context).size.width),
        ),
      ),
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => print(widget.borderRadiusFactor *
              (widget.width ?? 1 * MediaQuery.of(context).size.width),)
    );
  }
}