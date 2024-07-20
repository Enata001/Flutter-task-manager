import 'package:flutter/material.dart';

class SlideLeftWidget extends StatefulWidget {
  final Widget? child;
  final Duration duration;

  const SlideLeftWidget({
    super.key,
    @required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<SlideLeftWidget> createState() => _SlideLeftWidgetState();
}

class _SlideLeftWidgetState extends State<SlideLeftWidget> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(_controller),
      child: widget.child,
    );
  }
}
