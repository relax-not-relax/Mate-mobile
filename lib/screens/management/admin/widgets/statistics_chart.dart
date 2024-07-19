import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mate_project/models/cash_flow.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({
    super.key,
    required this.cashFlows,
  });

  final List<CashFlow> cashFlows;

  @override
  State<StatisticsChart> createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4.w,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: const Color.fromARGB(255, 76, 102, 232),
          width: 12.w,
        ),
        BarChartRodData(
          toY: y2,
          color: const Color.fromARGB(255, 206, 202, 251),
          width: 12.w,
        ),
      ],
    );
  }

  List<BarChartGroupData> createList(List<CashFlow> cashFlows) {
    final daysOfWeek = List.generate(7, (index) => index);
    List<BarChartGroupData> result = [];

    result = daysOfWeek.map(
      (dayOfWeek) {
        double revenue = 0.0;
        double cost = 0.0;
        final dayCashFlows = cashFlows
            .where((cashflow) => cashflow.time.weekday == dayOfWeek + 1)
            .toList();
        for (CashFlow cashflow in dayCashFlows) {
          revenue += cashflow.revenue;
          cost += cashflow.cost;
        }
        return makeGroupData(
          dayOfWeek,
          ((revenue * 5) / 1000),
          ((cost * 5) / 1000),
        );
      },
    ).toList();

    return result;
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 12.sp,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 5) {
      text = '1K';
    } else if (value == 25) {
      text = '5K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final Widget text = Text(
      titles[value.toInt()],
      style: TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16.h, //margin top
      child: text,
    );
  }

  @override
  void initState() {
    super.initState();
    final items = createList(widget.cashFlows);
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 25,
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(
                    show: true,
                  ),
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
