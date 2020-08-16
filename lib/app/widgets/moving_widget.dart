import 'package:flutter/material.dart';

class MovingWidget extends StatefulWidget {
  MovingWidget({Key key, this.child, this.begin, this.end}) : super(key: key);
  final Widget child;
  final RelativeRect begin, end;
  @override
  _MovingWidgetState createState() => _MovingWidgetState();
}

class _MovingWidgetState extends State<MovingWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            PositionedTransition(
              rect: RelativeRectTween(
                begin: widget.begin,
                end: widget.end,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticOut,
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8), child: widget.child),
            ),
          ],
        );
      },
    );
  }
}
