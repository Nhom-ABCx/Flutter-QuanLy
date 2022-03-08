import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_quanly/all_page.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class ProcessTimelinePage extends StatefulWidget {
  const ProcessTimelinePage({Key? key}) : super(key: key);

  @override
  _ProcessTimelinePageState createState() => _ProcessTimelinePageState();
}

class _ProcessTimelinePageState extends State<ProcessTimelinePage> {
  //phan` nay` la` copy tu` code mau~, tu custom, gan' vao`
  final _processes = [
    'Đặt hàng',
    'Duyệt',
    'Đóng gói',
    'Xuất kho',
    'Hoàn thành',
  ];
  final _icons = [
    Icons.shopping_cart,
    Icons.recommend,
    Icons.inventory,
    Icons.exit_to_app,
    Icons.done_all,
  ];

  Color completeColor = const Color(0xff5e6172);
  Color inProgressColor = const Color(0xff5ec792);
  Color todoColor = const Color(0xffd1d2d7);

  Color getColor(int index) {
    int processIndex = Provider.of<DonHangController>(context, listen: false).processIndex;
    if (index == processIndex) {
      return inProgressColor;
    } else if (index < processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        color: Colors.white,
        child: Timeline.tileBuilder(
          theme: TimelineThemeData(
            direction: Axis.horizontal,
            connectorTheme: const ConnectorThemeData(
              space: 30.0,
              thickness: 5.0,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            itemCount: _processes.length,
            connectionDirection: ConnectionDirection.before,
            itemExtentBuilder: (_, __) => MediaQuery.of(context).size.width / _processes.length,
            oppositeContentsBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Icon(_icons[index], color: getColor(index)),
              );
            },
            contentsBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  _processes[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: getColor(index),
                  ),
                ),
              );
            },
            indicatorBuilder: (_, index) {
              Color color; //init
              Widget child = const SizedBox(); //init
              if (index == Provider.of<DonHangController>(context, listen: true).processIndex) {
                color = inProgressColor;
                child = const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              } else if (index < Provider.of<DonHangController>(context, listen: true).processIndex) {
                color = completeColor;
                child = const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 15.0,
                );
              } else {
                color = todoColor;
              }

              if (index <= Provider.of<DonHangController>(context, listen: true).processIndex) {
                return Stack(
                  children: [
                    CustomPaint(
                      size: const Size(30.0, 30.0),
                      painter: _BezierPainter(
                        color: color,
                        drawStart: index > 0,
                        drawEnd: index < Provider.of<DonHangController>(context, listen: true).processIndex,
                      ),
                    ),
                    DotIndicator(
                      size: 30.0,
                      color: color,
                      child: child,
                    ),
                  ],
                );
              } else {
                return Stack(
                  children: [
                    CustomPaint(
                      size: const Size(15.0, 15.0),
                      painter: _BezierPainter(
                        color: color,
                        drawEnd: index < _processes.length - 1,
                      ),
                    ),
                    OutlinedDotIndicator(
                      borderWidth: 4.0,
                      color: color,
                    ),
                  ],
                );
              }
            },
            connectorBuilder: (_, index, type) {
              if (index > 0) {
                if (index == Provider.of<DonHangController>(context, listen: true).processIndex) {
                  final prevColor = getColor(index - 1);
                  final color = getColor(index);
                  List<Color> gradientColors;
                  if (type == ConnectorType.start) {
                    gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                  } else {
                    gradientColors = [prevColor, Color.lerp(prevColor, color, 0.5)!];
                  }
                  return DecoratedLineConnector(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                      ),
                    ),
                  );
                } else {
                  return SolidLineConnector(
                    color: getColor(index),
                  );
                }
              } else {
                return null;
              }
            },
          ),
        ));
  }
}

/// hardcoded bezier painter
/// TODO: Bezier curve into package component
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    double angle;
    Offset offset1;
    Offset offset2;

    Path path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius, radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.drawStart != drawStart || oldDelegate.drawEnd != drawEnd;
  }
}
