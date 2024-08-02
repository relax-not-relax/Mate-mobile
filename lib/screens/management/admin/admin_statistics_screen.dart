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

class AdminStatisticsScreen extends StatefulWidget {
  const AdminStatisticsScreen({super.key});

  @override
  State<AdminStatisticsScreen> createState() => _AdminStatisticsScreenState();
}

class _AdminStatisticsScreenState extends State<AdminStatisticsScreen> {
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
      totalRevenue: getTotalRevenue(data),
      totalProfit: getTotalProfit(data),
      advice: analysisResult.advice,
    );

    setState(() {
      content;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedMonth = 5;
    selectedYear = 2024;

    // content sẽ được thay đổi phụ thuộc vào filter tháng, năm
    // Khi mới vào trang lần đầu thì filter sẽ là tháng, năm thời điểm hiện tại
    // Nếu tháng, năm thời điểm hiện tại chưa có thì content = NoneStatisticsScreen()
    content = NoneStatisticsScreen(
      getAnalysis: getAdvice,
      month: selectedMonth,
      year: selectedYear,
    );

    // Nếu tháng, năm thời điểm hiện tại đã có data thì content = StatisticsDetailsScreen();
    // data = [
    //   CashFlow(
    //     time: DateTime(2024, 5, 7, 0),
    //     revenue: 500,
    //     cost: 200,
    //     profit: 300,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 10, 0),
    //     revenue: 1000,
    //     cost: 1200,
    //     profit: -200,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 12, 0),
    //     revenue: 400,
    //     cost: 50,
    //     profit: 350,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 15, 0),
    //     revenue: 500,
    //     cost: 200,
    //     profit: 300,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 16, 0),
    //     revenue: 1000,
    //     cost: 1200,
    //     profit: -200,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 20, 0),
    //     revenue: 400,
    //     cost: 50,
    //     profit: 350,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 22, 0),
    //     revenue: 500,
    //     cost: 200,
    //     profit: 300,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 24, 0),
    //     revenue: 1000,
    //     cost: 1200,
    //     profit: -200,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 25, 0),
    //     revenue: 400,
    //     cost: 50,
    //     profit: 350,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 26, 0),
    //     revenue: 500,
    //     cost: 200,
    //     profit: 300,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 27, 0),
    //     revenue: 1000,
    //     cost: 1200,
    //     profit: -200,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 28, 0),
    //     revenue: 400,
    //     cost: 50,
    //     profit: 350,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 29, 0),
    //     revenue: 100,
    //     cost: 20,
    //     profit: 80,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 30, 0),
    //     revenue: 1500,
    //     cost: 500,
    //     profit: 1000,
    //   ),
    //   CashFlow(
    //     time: DateTime(2024, 5, 31, 0),
    //     revenue: 2000,
    //     cost: 1000,
    //     profit: 1000,
    //   ),
    // ];
    // // Call API to get advice
    // advice =
    //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";
    // content = StatisticsDetailsScreen(
    //   data: data,
    //   month: selectedMonth,
    //   year: selectedYear,
    //   totalRevenue: getTotalRevenue(data),
    //   totalProfit: getTotalProfit(data),
    //   advice: advice,
    // );
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
                              setState(() {
                                // Gọi     setState trong StatefulBuilder
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
                      action: () {},
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
