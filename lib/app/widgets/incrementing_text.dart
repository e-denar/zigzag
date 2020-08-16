import 'package:flutter/material.dart';

class IncrementingText extends ImplicitlyAnimatedWidget {
  IncrementingText(
      {Key key,
      this.count = 0,
      Duration duration = const Duration(milliseconds: 200),
      Curve curve = Curves.easeIn,
      this.style})
      : super(duration: duration, curve: curve, key: key);

  final int count;
  final TextStyle style;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _IncrementingTextWidgetState();
  }
}

class _IncrementingTextWidgetState
    extends AnimatedWidgetBaseState<IncrementingText> {
  IntTween _intCount;

  @override
  Widget build(BuildContext context) {
    return Text(
      _intCount.evaluate(animation).toString(),
      style: widget.style,
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _intCount = visitor(
      _intCount,
      widget.count,
      (dynamic value) => IntTween(begin: 0),
    );
  }
}
