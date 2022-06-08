import 'package:flutter/material.dart';
import 'package:timer/global/common/constants.dart';
import 'package:timer/global/widgets/border_gradient_container.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class CircularTimer extends StatelessWidget {
  /// The [CircularTimer] creates a circular timer with a center child.
  /// 
  /// * ``height``: The height of the timer.
  /// * ``width``: The width of the timer.
  /// * ``size``: The size of the timer percentage.
  /// * ``max``: The timer set value.
  /// * ``value``: The timer current value.
  /// * ``onDrag``: Called when the user drags the timer.
  /// * ``child``: The centered child.
  ///
  /// Example usage:
  ///
  /// ```dart
  ///   CircularTimer(
  ///     height: 100,
  ///     width: 100,
  ///     size: 100,
  ///     max: 50,
  ///     value: 25,
  ///     onDrag: (moveState) {},
  ///     child: Text("That's the Timer!"),
  ///   );
  /// ```
  CircularTimer({
    Key? key,
    required this.height,
    required this.width,
    this.size = 185,
    required this.max,
    this.value = 0,
    required this.onDrag,
    this.child,
  }) : super(key: key);

  final double height;
  final double width;
  final double size;
  final int max;
  double value;
  final Function(int) onDrag;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BorderGradientContainer(
        height: height,
        width: width,
        shape: BoxShape.circle,
        borderGradient: cPrimaryDarkGradient,
        backgroundGradient: cPrimaryGradient,
        boxShadow: const [
          BoxShadow(
            color: cPrimaryLight,
            blurRadius: 32,
            offset: Offset(-12, -12),
          ),
          BoxShadow(
            color: cPrimaryDark,
            blurRadius: 32,
            offset: Offset(12, 12),
          ),
        ],
        child: _CircularPercentIndicator(
          size: size,
          percent: value,
          onDrag: onDrag,
          child: child,
        ));
  }
}

class _CircularPercentIndicator extends StatelessWidget {
  const _CircularPercentIndicator({
    Key? key,
    required this.size,
    required this.percent,
    required this.onDrag,
    required this.child,
  }) : super(key: key);

  final double size;
  final double min = 0;
  final double max = 100;
  final double percent;
  final Function(int) onDrag;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        double moveState = details.primaryDelta!.sign;
        onDrag(moveState.toInt());
      },
      child: CustomPaint(
        painter: _Painter(
          size: size,
          degree: 360 * (percent / 100),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  const _Painter({
    required this.size,
    required this.degree,
  });

  final double size;
  final double degree;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCenter(center: center, width: this.size, height: this.size),
      vmath.radians(0),
      vmath.radians(360),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = cPrimaryDark
        ..strokeWidth = 4,
    );

    canvas.saveLayer(
      Rect.fromCenter(
          center: center, width: this.size + 10, height: this.size + 10),
      Paint(),
    );

    canvas.drawArc(
      Rect.fromCenter(center: center, width: this.size, height: this.size),
      vmath.radians(-90),
      vmath.radians(degree),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = cAccent
        ..strokeWidth = 4,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
