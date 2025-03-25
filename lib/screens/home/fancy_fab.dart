import 'package:cutfx/utils/color_res.dart';
import 'package:flutter/material.dart';

class FancyFab extends StatefulWidget {
  final Function() onPressed;

  const FancyFab({
    super.key,
    required this.onPressed,
  });

  @override
  State<FancyFab> createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.linear;
  final double _fabHeight = 38.0;

  @override
  initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        1,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add() {
    return SizedBox(
      height: 38,
      width: 38,
      child: FloatingActionButton(
        onPressed: () {},
        elevation: isOpened ? 5 : 0,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget image() {
    return Container(
      height: 38,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      margin: EdgeInsets.symmetric(vertical: isOpened ? 10 : 0),
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Image',
        elevation: isOpened ? 5 : 0,
        child: const Icon(
          Icons.image,
          size: 18,
        ),
      ),
    );
  }

  Widget inbox() {
    return Container(
      height: 38,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      margin: EdgeInsets.only(bottom: isOpened ? 10 : 0),
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Inbox',
        elevation: isOpened ? 5 : 0,
        child: const Icon(Icons.inbox),
      ),
    );
  }

  Widget toggle() {
    return InkWell(
      onTap: animate,
      child: Container(
        height: 38,
        width: 38,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, anim) => RotationTransition(
                  turns: child.key == const ValueKey('icon1')
                      ? Tween<double>(begin: 1, end: 0.75).animate(anim)
                      : Tween<double>(begin: 0.75, end: 1).animate(anim),
                  child: ScaleTransition(scale: anim, child: child),
                ),
            child: !isOpened
                ? const Icon(Icons.attachment_rounded,
                    color: ColorRes.white, key: ValueKey('icon1'))
                : const Icon(
                    Icons.close,
                    color: ColorRes.white,
                    key: ValueKey('icon2'),
                  )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 3.0,
              0.0,
            ),
            child: add(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value * 2.0,
              0.0,
            ),
            child: image(),
          ),
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              _translateButton.value,
              0.0,
            ),
            child: inbox(),
          ),
          toggle(),
        ],
      ),
    );
  }
}
