import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:mate_project/data/project_data.dart';
import 'package:mate_project/models/analysis_response.dart';
import 'package:mate_project/repositories/analysis_repo.dart';

// ignore: must_be_immutable
class NoneStatisticsScreen extends StatelessWidget {
  NoneStatisticsScreen({
    super.key,
    required this.month,
    required this.year,
    required this.getAnalysis,
  });

  final int month;
  final int year;
  final Function(AnalysisResult analysisResult) getAnalysis;

  AnalysisRepository analysisRepository = AnalysisRepository();

  @override
  Widget build(BuildContext context) {
    String monthText = ProjectData.getMonthName(month);
    return Container(
      width: 360.w,
      height: 800.h,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$monthText $year",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Wrap(
            children: [
              Text(
                "No data is available for analysis this month. Please add data files to track.",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 8.h,
            spacing: 8.w,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  AnalysisRepository analysisRepository = AnalysisRepository();
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xlsx', 'xls'],
                  );

                  if (result != null) {
                    String filePath = result.files.single.path!;
                    getAnalysis(await analysisRepository
                        .uploadFileToAnalysis(filePath));
                  } else {
                    print("Không có file được chọn");
                  }
                },
                icon: Icon(
                  IconsaxPlusLinear.document_upload,
                  size: 20.sp,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(
                    Color.fromARGB(255, 127, 119, 245),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 20.w,
                    ),
                  ),
                ),
                label: Text(
                  "Upload data",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  analysisRepository.downloadExcelFile(month, year);
                },
                icon: Icon(
                  IconsaxPlusLinear.document_forward,
                  size: 20.sp,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(
                    Color.fromARGB(255, 84, 110, 255),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 20.w,
                    ),
                  ),
                ),
                label: Text(
                  "Export revenue",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
