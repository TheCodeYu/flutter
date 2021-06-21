import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

/// description:
///
/// user: yuzhou
/// date: 2021/6/20

class PieCharData {
  const PieCharData(this.id, this.indicator, this.pieChartSectionData);
  final int id;
  final Indicator indicator;
  final PieChartSectionData pieChartSectionData;
}

class PieChartCustomer extends StatefulWidget {
  final List<PieCharData> pieCharData;

  const PieChartCustomer({Key? key, required this.pieCharData})
      : super(key: key);
  @override
  _PieChartCustomerState createState() => _PieChartCustomerState();
}

class _PieChartCustomerState extends State<PieChartCustomer> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        child: Column(
          children: [
            const SizedBox(
              height: 28,
            ),
            Wrap(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    widget.pieCharData.length,
                    (index) => Indicator(
                          color: widget.pieCharData[index].indicator.color,
                          text: widget.pieCharData[index].indicator.text,
                          isSquare:
                              widget.pieCharData[index].indicator.isSquare,
                          size: touchedIndex == 0 ? 18 : 16,
                          textColor:
                              touchedIndex == 0 ? Colors.black : Colors.grey,
                        ))),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput
                                  is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      startDegreeOffset: 180,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 1,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      widget.pieCharData.length,
      (i) {
        final isTouched = i == touchedIndex;
        final opacity = isTouched ? 1.0 : 0.6;
        final data = widget.pieCharData[i].pieChartSectionData;
        return PieChartSectionData(
          color: data.color.withOpacity(opacity),
          value: data.value,
          title: data.title,
          radius: data.radius,
          titleStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titlePositionPercentageOffset: 0.55,
        );
      },
    );
  }
}
