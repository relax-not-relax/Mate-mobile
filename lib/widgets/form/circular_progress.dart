import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularProgressCustom extends StatefulWidget {
  const CircularProgressCustom({
    super.key,
    required this.beginColor,
    required this.endColor,
    required this.backgroundColorSelection,
  });

  final Color beginColor;
  final Color endColor;
  final Color backgroundColorSelection;

  @override
  State<CircularProgressCustom> createState() => _CircularProgressCustomState();
}

class _CircularProgressCustomState extends State<CircularProgressCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;
  final ValueNotifier<Color> _currentColor = ValueNotifier(Colors.transparent);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    _animation = ColorTween(
      begin: widget.beginColor,
      end: widget.endColor,
    ).animate(_controller);
    _controller.repeat();

    _animation.addListener(() {
      _currentColor.value = _animation.value!;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: widget.backgroundColorSelection,
      valueColor: _animation,
      strokeWidth: 8.w,
    );
  }
}
