import 'package:flutter/material.dart';


class FQTToggler extends StatefulWidget {

  final VoidCallback onPressed;
  final VoidCallback positionClose;
  final VoidCallback positionOpen;
  final int durationMilliseconds;

  const FQTToggler({
    super.key,
    required this.onPressed,
    required this.positionClose,
    required this.positionOpen,
    this.durationMilliseconds = 250,
  });

  @override
  State<FQTToggler> createState() => FQTTogglerState();
}

class FQTTogglerState extends State<FQTToggler> with SingleTickerProviderStateMixin {

  double buttonsOpacity = 2.0;
  double bottomShift = 0.0;

  late final AnimationController _opacityController = AnimationController(
    duration: Duration(milliseconds: widget.durationMilliseconds),
    vsync: this,

  )..addListener(() {
    setState(() => buttonsOpacity = _opacityAnimation.value);
  });


  late final Animation<double> _opacityAnimationCurve = CurvedAnimation(parent: _opacityController, curve: Curves.easeInSine);
  late final Animation<double> _opacityAnimation = Tween(begin: 2.0, end: 0.0).animate(_opacityAnimationCurve);

  void reset() {
    _opacityController.reverse();
  }

  void open() {
    _opacityController.forward();
  }

  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        widget.onPressed();
        if (_opacityController.isCompleted) {
          _opacityController.reverse();
          widget.positionClose();
        } else {
          _opacityController.forward();
          widget.positionOpen();
        }
      },

      child: Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          bottom: 10.0,
        ),

        child: Stack(
          children: [
            Opacity(
              opacity: (buttonsOpacity > 1.0) ? 0.0 : 1.0 - buttonsOpacity,
              child: const Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 30.0,
              ),
            ),

            Opacity(
              opacity: (buttonsOpacity < 1.0) ? 0.0 : buttonsOpacity - 1.0,
              child: const Icon(
                Icons.design_services_rounded,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PositionedFQTToggler extends StatefulWidget {

  final int durationMilliseconds;
  final VoidCallback onPressed;

  const PositionedFQTToggler({
    super.key,
    required this.onPressed,
    this.durationMilliseconds = 250,
  });

  @override
  State<PositionedFQTToggler> createState() => PositionedFQTTogglerState();
}

class PositionedFQTTogglerState extends State<PositionedFQTToggler> with SingleTickerProviderStateMixin {

  double bottomShift = 0.0;
  GlobalKey<FQTTogglerState> fqtTogglerKey = GlobalKey();


  late final AnimationController _positionController = AnimationController(
    duration: Duration(milliseconds: widget.durationMilliseconds),
    vsync: this,

  )..addListener(() {
    setState(() => bottomShift = _positionAnimation.value);
  });


  late final Animation<double> _positionAnimationCurve = CurvedAnimation(parent: _positionController, curve: Curves.easeInSine);
  late final Animation<double> _positionAnimation = Tween(begin: 0.0, end: 80.0).animate(_positionAnimationCurve);

  void open() {
    fqtTogglerKey.currentState!.open();
    _positionController.forward();
  }

  void reset() {
    fqtTogglerKey.currentState!.reset();
    _positionController.reverse();
  }

  @override
  void dispose() {
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(

      right: 0.0,
      bottom: bottomShift,

      child: FQTToggler(
        key: fqtTogglerKey,
        onPressed: widget.onPressed,
        durationMilliseconds: widget.durationMilliseconds,
        positionClose: reset,
        positionOpen: open,
      )
    );
  }
}


