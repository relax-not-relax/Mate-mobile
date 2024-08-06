import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:iconly/iconly.dart';
import 'package:mate_project/models/analysis_response.dart';
import 'package:mate_project/models/cash_flow.dart';
import 'package:mate_project/repositories/analysis_repo.dart';
import 'package:mate_project/screens/management/admin/none_statistics_screen.dart';
import 'package:mate_project/screens/management/admin/statistics_details_screen.dart';
import 'package:mate_project/widgets/app_bar/normal_app_bar.dart';
import 'package:mate_project/widgets/form/normal_button_custom.dart';
import 'package:mate_project/widgets/form/normal_dialog_custom.dart';

class AdminStatisticsScreen extends StatefulWidget {
  const AdminStatisticsScreen({super.key});

  @override
  State<AdminStatisticsScreen> createState() => _AdminStatisticsScreenState();
}

class _AdminStatisticsScreenState extends State<AdminStatisticsScreen> {
  // Note mới nhất:
  // Đọc note ở dòng 198
  Widget? content;
  late int selectedMonth;
  late int selectedYear;

  // Test data, gọi API để lấy dữ liệu danh sách thống kê dòng tiền và lời khuyên kinh doanh
  List<CashFlow> data = [];
  late String advice;

  double getTotalRevenue(List<CashFlow> data) {
    return data.fold(0.0, (total, cashFlow) => total + cashFlow.revenue);
  }

  double getTotalProfit(List<CashFlow> data) {
    return data.fold(0.0, (total, cashFlow) => total + cashFlow.profit);
  }

  Future<void> getAdvice(AnalysisResult analysisResult) async {
    final apiKey = "AIzaSyAqtzgSzISIP7xFzEUUWpKohXvGB1kI1aU";
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
    }
    // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final contentS = [Content.text(analysisResult.advice)];
    final response = await model.generateContent(contentS);
    analysisResult.advice = response.text ?? "Cannot analys";
    content = StatisticsDetailsScreen(
      data: analysisResult.listCashFlow,
      month: selectedMonth,
      year: selectedYear,
      totalRevenue: getTotalRevenue(analysisResult.listCashFlow),
      totalProfit: getTotalProfit(analysisResult.listCashFlow),
      advice: analysisResult.advice,
    );

    setState(() {
      content;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedMonth = DateTime.now().month;
    selectedYear = DateTime.now().year;

    // content sẽ được thay đổi phụ thuộc vào filter tháng, năm
    // Khi mới vào trang lần đầu thì filter sẽ là tháng, năm thời điểm hiện tại
    // Nếu tháng, năm thời điểm hiện tại chưa có thì content = NoneStatisticsScreen()
    content = NoneStatisticsScreen(
      getAnalysis: getAdvice,
      month: selectedMonth,
      year: selectedYear,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future displayBottomSheet(BuildContext context) {
      return showModalBottomSheet(
        context: context,
        backgroundColor: const Color.fromARGB(255, 37, 41, 46),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 220.h,
                width: 360.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.h,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Sort by",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        DropdownButton<int>(
                          value: selectedMonth,
                          hint: const Text("Select month"),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          items: <String>[
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                            'July',
                            'August',
                            'September',
                            'October',
                            'November',
                            'December'
                          ].asMap().entries.map((entry) {
                            int idx = entry.key;
                            String month = entry.value;
                            return DropdownMenuItem<int>(
                              value: idx + 1,
                              child: Text(month),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            if (mounted)
                              // ignore: curly_braces_in_flow_control_structures
                              setState(() {
                                selectedMonth = newValue!;
                              });
                          },
                          dropdownColor: const Color.fromARGB(255, 35, 38, 47),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        DropdownButton<int>(
                          value: selectedYear,
                          hint: const Text("Select year"),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          items: List<DropdownMenuItem<int>>.generate(7,
                              (int index) {
                            return DropdownMenuItem<int>(
                              value: 2024 + index,
                              child: Text("Year ${2024 + index}"),
                            );
                          }),
                          onChanged: (int? newValue) {
                            if (mounted)
                              // ignore: curly_braces_in_flow_control_structures
                              setState(() {
                                selectedYear = newValue!;
                              });
                          },
                          dropdownColor: const Color.fromARGB(255, 35, 38, 47),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    NormalButtonCustom(
                      name: "Confirm",
                      action: () {
                        NormalDialogCustom().showWaitingDialog(
                          context,
                          "assets/pics/analyst.png",
                          "Wait a minute",
                          "The system is performing data analysis.",
                          false,
                          const Color.fromARGB(255, 68, 60, 172),
                        );
                        // get ra dữ liệu của tháng và năm được chọn => setState cho content
                        // ...
                        Navigator.of(context).pop();
                      },
                      background: const Color.fromARGB(255, 84, 110, 255),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: const Color.fromARGB(255, 15, 16, 20),
      appBar: TNormalAppBar(
        title: "Statistics",
        isBordered: false,
        isBack: false,
        bgColor: const Color.fromARGB(255, 15, 16, 20),
        titleColor: Colors.white,
        action: IconButton(
          onPressed: () {
            displayBottomSheet(context);
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.transparent,
            ),
          ),
          icon: Icon(
            IconlyLight.filter,
            size: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: content,
    );
  }
}
