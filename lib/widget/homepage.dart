import 'package:aadhar/utils/constants.dart';
import 'package:aadhar/widget/get_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Required Variables
  final pdf = pw.Document();
  File? file;

  // Variable to save PDF File
  bool isDownloading = false;
  DateTime time = DateTime.now();

  // Variable to change User Image on Aadhar Card
  String? profilePic;
  bool isImageSelect = false;
  late File imageFile;

  // Variable to change QR Code on Aadhar Card
  String? qrPic;
  bool isQRSelect = false;
  late File qrFile;

  // Variables for First Page Details
  String name = GetDetailsPage1.name.text;
  String fatherName = GetDetailsPage1.fatherName.text;
  String gender = GetDetailsPage1.selectedGender!;
  String dob = GetDetailsPage1.dob.text;
  String townOrCityName = GetDetailsPage1.townOrCity.text;
  String districtName = GetDetailsPage1.district.text;
  String? stateName = GetDetailsPage1.selectedState;
  String pinCode = GetDetailsPage1.pinCode.text;

  // Variables for Second Page Details
  String hindiName = GetDetailsPage2.hindiName.text;
  String hindiFatherName = GetDetailsPage2.hindiFatherName.text;
  String hindiGender = GetDetailsPage2.selectedHindiGender!;
  String hindiTownOrCityName = GetDetailsPage2.hindiTownOrCity.text;
  String hindiDistrictName = GetDetailsPage2.hindiDistrict.text;
  String? hindiStateName = GetDetailsPage2.selectedHindiState;

  // Variables for Third Page Details
  String phoneNumber = GetDetailsPage3.phoneNumber.text;
  String enrolmentNumber = GetDetailsPage3.enrolmentNumber.text;
  String aadharNumber = GetDetailsPage3.aadharNumber.text;
  String vid = GetDetailsPage3.vid.text;

  writeOnPDF() async {
    // Aadhar card template for PDF
    final aadharTemplate = pw.MemoryImage(
      (await rootBundle.load('assets/images/aadhar.png')).buffer.asUint8List(),
    );

    // User Image
    final selectedImage = pw.MemoryImage(
      File(profilePic!).readAsBytesSync(),
    );

    // QR Image
    final selectedQR = pw.MemoryImage(
      File(qrPic!).readAsBytesSync(),
    );

    // Fonts for Hindi Text
    final hindiFont = await PdfGoogleFonts.hindRegular();
    final boldFont = await PdfGoogleFonts.hindBold();

    // PDF
    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(0),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(children: [
            pw.Center(child: pw.Image(aadharTemplate, fit: pw.BoxFit.cover)),

            // Todo: --- SECTION-1 ---
            // Enrolment Number
            pw.Positioned(
                top: 264.1,
                left: 178,
                child: pw.Text(
                  enrolmentNumber,
                  style: const pw.TextStyle(
                      fontSize: 9.25, color: PdfColors.black),
                )),

            // Hindi Name
            pw.Positioned(
                top: 290,
                left: 73.5,
                child: pw.Text(hindiName,
                    style: pw.TextStyle(
                        fontSize: 6.8,
                        fontNormal: hindiFont,
                        color: PdfColors.black))),

            // English Name
            pw.Positioned(
                top: 299,
                left: 73.5,
                child: pw.Text(
                  name,
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // Father's Name
            pw.Positioned(
                top: 308,
                left: 73.5,
                child: pw.Text(
                  "S/O: $fatherName",
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // Town or City Name
            pw.Positioned(
                top: 317,
                left: 73.5,
                child: pw.Text(
                  townOrCityName,
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // Address
            pw.Positioned(
                top: 326,
                left: 73.5,
                child: pw.Text(
                  "$districtName $stateName - $pinCode",
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // Mobile Number
            pw.Positioned(
                top: 335,
                left: 73.5,
                child: pw.Text(
                  phoneNumber,
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // Todo: --- SECTION-2 ---
            // QR Photo
            pw.Positioned(
                top: 413,
                left: 190,
                child: pw.Container(
                    width: 86,
                    height: 86,
                    color: PdfColors.white,
                    child: pw.SizedBox(
                        width: 34,
                        height: 40,
                        child: pw.Image(selectedQR, fit: pw.BoxFit.cover)))),

            // Aadhar Number
            pw.Positioned(
                top: 523.5,
                left: 111,
                child: pw.Text(
                  aadharNumber,
                  style:
                      const pw.TextStyle(fontSize: 14, color: PdfColors.black),
                )),

            // VID
            pw.Positioned(
                top: 538,
                left: 135,
                child: pw.Text(
                  vid,
                  style:
                      const pw.TextStyle(fontSize: 7.5, color: PdfColors.black),
                )),

            // Todo: --- SECTION-3 ---
            // User Photo
            pw.Positioned(
                top: 612,
                left: 56,
                child: pw.Container(
                    width: 54,
                    height: 66,
                    color: PdfColors.white,
                    child: pw.SizedBox(
                        width: 34,
                        height: 40,
                        child: pw.Image(selectedImage, fit: pw.BoxFit.cover)))),

            // Hindi Name
            pw.Positioned(
                top: 612,
                left: 118,
                child: pw.Text(
                  hindiName,
                  style: pw.TextStyle(
                      fontSize: 6.8,
                      color: PdfColors.black,
                      fontNormal: hindiFont),
                )),

            // English Name
            pw.Positioned(
                top: 621,
                left: 118,
                child: pw.Text(
                  name,
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // DOB
            pw.Positioned(
                top: 630,
                left: 118,
                child: pw.Text(
                  "जन्म तिथि/DOB: $dob",
                  style: pw.TextStyle(
                      fontSize: 6.8,
                      color: PdfColors.black,
                      fontNormal: hindiFont),
                )),

            // Gender
            pw.Positioned(
                top: 639,
                left: 118,
                child: pw.Text(
                  "$hindiGender/ $gender",
                  style: pw.TextStyle(
                      fontSize: 6.8,
                      color: PdfColors.black,
                      fontNormal: hindiFont),
                )),

            // Aadhar Number
            pw.Positioned(
                top: 707,
                left: 119,
                child: pw.Text(
                  aadharNumber,
                  style:
                      const pw.TextStyle(fontSize: 11, color: PdfColors.black),
                )),

            // VID
            pw.Positioned(
                top: 720,
                left: 118,
                child: pw.Text(
                  "VID : $vid",
                  style:
                      const pw.TextStyle(fontSize: 7, color: PdfColors.black),
                )),

            // Todo: --- SECTION-4 ---
            // Address Label
            pw.Positioned(
                top: 604,
                left: 309,
                child: pw.Text(
                  "पता:",
                  style: pw.TextStyle(
                      fontSize: 6.8,
                      color: PdfColors.black,
                      fontNormal: boldFont),
                )),

            // Father's name and city name in hindi
            pw.Positioned(
                top: 611.5,
                left: 309,
                child: pw.Text(
                  "$hindiFatherName, $hindiTownOrCityName",
                  style: pw.TextStyle(
                      fontSize: 6.8,
                      color: PdfColors.black,
                      fontNormal: hindiFont),
                )),

            // district name in hindi
            pw.Positioned(
                top: 619,
                left: 309,
                child: pw.Text(
                  hindiDistrictName,
                  style: pw.TextStyle(
                      fontSize: 6.8,
                      color: PdfColors.black,
                      fontNormal: hindiFont),
                )),

            // state name and pin code in hindi
            pw.Positioned(
                top: 626.5,
                left: 309,
                child: pw.Text(
                  "$hindiStateName - $pinCode",
                  style: pw.TextStyle(
                      fontSize: 6.8,
                      color: PdfColors.black,
                      fontNormal: hindiFont),
                )),

            // Father's name and city name in english
            pw.Positioned(
                top: 647,
                left: 309,
                child: pw.Text(
                  "$fatherName, $townOrCityName",
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // district name in english
            pw.Positioned(
                top: 654.5,
                left: 309,
                child: pw.Text(
                  districtName,
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // state name and pin code in english
            pw.Positioned(
                top: 662,
                left: 309,
                child: pw.Text(
                  "$stateName - $pinCode",
                  style:
                      const pw.TextStyle(fontSize: 6.8, color: PdfColors.black),
                )),

            // QR Photo
            pw.Positioned(
                top: 614,
                left: 460,
                child: pw.Container(
                    width: 86,
                    height: 86,
                    color: PdfColors.white,
                    child: pw.SizedBox(
                        width: 34,
                        height: 40,
                        child: pw.Image(selectedQR, fit: pw.BoxFit.cover)))),

            // Aadhar Number
            pw.Positioned(
                top: 707,
                left: 387,
                child: pw.Text(
                  aadharNumber,
                  style:
                      const pw.TextStyle(fontSize: 11, color: PdfColors.black),
                )),

            // VID
            pw.Positioned(
                top: 720,
                left: 405,
                child: pw.Text(
                  vid,
                  style:
                      const pw.TextStyle(fontSize: 7, color: PdfColors.black),
                )),
          ]);
        }));
  }

  // Function to save PDF
  Future savePDF() async {
    final directory = await getExternalStorageDirectory();
    if (kDebugMode) {
      print(directory?.path);
    }

    file = File("${directory?.path}/Aadhar-$time.pdf");

    final pdfBytes = await pdf.save();
    await file?.writeAsBytes(pdfBytes);
    // ignore: use_build_context_synchronously
    showSnackbar(context,
        "PDF Saved Successfully to File/Android/data/com.generate.aadhar/files/Aadhar-$time.pdf");

    setState(() {
      isDownloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Building Scaffold to Preview the PDF File
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: isDownloading
            ? const Text(
                "PDF is Saving...",
                style: TextStyle(
                    color: Colors.orange,
                    fontFamily: 'OpenSans-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              )
            : Text(
                "Aadhar Preview",
                style: TextStyle(
                    color: primaryColor,
                    fontFamily: 'OpenSans-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
      ),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              // Template
              Image.asset("assets/images/aadhar.png"),

              // Todo: --- SECTION-1 ---
              // Enrolment Number
              Positioned(
                  top: 160.5,
                  left: 108,
                  child: Text(
                    enrolmentNumber,
                    style: const TextStyle(fontSize: 7, color: Colors.black),
                  )),

              // Hindi Name
              Positioned(
                  top: 177,
                  left: 44,
                  child: Text(
                    hindiName,
                    style: const TextStyle(fontSize: 5, color: Colors.black),
                  )),

              // English Name
              Positioned(
                  top: 183,
                  left: 44,
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // Father's Name
              Positioned(
                  top: 189,
                  left: 44,
                  child: Text(
                    "S/O: $fatherName",
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // Town or City Name
              Positioned(
                  top: 195,
                  left: 44,
                  child: Text(
                    townOrCityName,
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // Address
              Positioned(
                  top: 201,
                  left: 44,
                  child: Text(
                    "$districtName $stateName - $pinCode",
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // Phone Number
              Positioned(
                  top: 207,
                  left: 44,
                  child: Text(
                    phoneNumber,
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // Todo: --- SECTION-2 ---
              // QR Image
              Positioned(
                  top: 250,
                  left: 115,
                  child: Container(
                      width: 52,
                      height: 52,
                      color: Colors.white,
                      child: qrPic == null
                          ? const Icon(
                              CupertinoIcons.qrcode,
                              size: 50,
                              color: Colors.black,
                            )
                          : SizedBox(
                              width: 34,
                              height: 40,
                              child: Image.file(
                                qrFile,
                                fit: BoxFit.cover,
                              ),
                            ))),

              // Upload QR Button
              Positioned(
                  top: 288,
                  left: 152,
                  child: GestureDetector(
                    onTap: () async {
                      isQRSelect = true;
                      final XFile? pickImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery, imageQuality: 100);

                      if (pickImage != null) {
                        setState(() {
                          qrPic = pickImage.path;
                          qrFile = File(qrPic!);
                        });
                      }
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white),
                          color: primaryColor),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  )),

              // Aadhar Number
              Positioned(
                  top: 316.6,
                  left: 67,
                  child: Text(
                    aadharNumber,
                    style: const TextStyle(fontSize: 10.5, color: Colors.black),
                  )),

              // VID
              Positioned(
                  top: 326,
                  left: 81,
                  child: Text(
                    vid,
                    style: const TextStyle(fontSize: 5.6, color: Colors.black),
                  )),

              // Todo: --- SECTION-3 ---
              // User Image
              Positioned(
                  top: 370,
                  left: 34,
                  child: Container(
                      width: 34,
                      height: 40,
                      color: Colors.white,
                      child: profilePic == null
                          ? const Icon(
                              CupertinoIcons.person,
                              size: 35,
                              color: Colors.black,
                            )
                          : SizedBox(
                              width: 34,
                              height: 40,
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              ),
                            ))),

              // Upload Image Button
              Positioned(
                  top: 395,
                  left: 55,
                  child: GestureDetector(
                    onTap: () async {
                      isImageSelect = true;
                      final XFile? pickImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery, imageQuality: 100);

                      if (pickImage != null) {
                        setState(() {
                          profilePic = pickImage.path;
                          imageFile = File(profilePic!);
                        });
                      }
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white),
                          color: primaryColor),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  )),

              // Hindi Name
              Positioned(
                  top: 371,
                  left: 74,
                  child: Text(
                    hindiName,
                    style: const TextStyle(fontSize: 5, color: Colors.black),
                  )),

              // English Name
              Positioned(
                  top: 376.5,
                  left: 74,
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 5.2, color: Colors.black),
                  )),

              // DOB
              Positioned(
                  top: 382,
                  left: 74,
                  child: Text(
                    "जन्म तिथि/DOB: $dob",
                    style: const TextStyle(fontSize: 5.2, color: Colors.black),
                  )),

              // Gender
              Positioned(
                  top: 387.5,
                  left: 74,
                  child: Text(
                    "$hindiGender/ $gender",
                    style: const TextStyle(fontSize: 5.2, color: Colors.black),
                  )),

              // Aadhar Number
              Positioned(
                  top: 428,
                  left: 72,
                  child: Text(
                    aadharNumber,
                    style: const TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),

              // VID
              Positioned(
                  top: 435.5,
                  left: 70,
                  child: Text(
                    "VID : $vid",
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // Todo: --- SECTION-4 ---
              // Address Label
              const Positioned(
                  top: 366,
                  left: 187,
                  child: Text(
                    "पता:",
                    style: TextStyle(
                        fontSize: 4.5,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),

              // Father's name and city name in hindi
              Positioned(
                  top: 370.5,
                  left: 187,
                  child: Text(
                    "$hindiFatherName, $hindiTownOrCityName",
                    style: const TextStyle(fontSize: 4.5, color: Colors.black),
                  )),

              // district name in hindi
              Positioned(
                  top: 375,
                  left: 187,
                  child: Text(
                    hindiDistrictName,
                    style: const TextStyle(fontSize: 4.5, color: Colors.black),
                  )),

              // state name and pin code in hindi
              Positioned(
                  top: 379.5,
                  left: 187,
                  child: Text(
                    "$hindiStateName - $pinCode",
                    style: const TextStyle(fontSize: 4.5, color: Colors.black),
                  )),

              // Father's name and city name in english
              Positioned(
                  top: 391,
                  left: 187,
                  child: Text(
                    "$fatherName, $townOrCityName",
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // district name in english
              Positioned(
                  top: 396,
                  left: 187,
                  child: Text(
                    districtName,
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // state name and pin code in english
              Positioned(
                  top: 401,
                  left: 187,
                  child: Text(
                    "$stateName - $pinCode",
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),

              // QR Image
              Positioned(
                  top: 371.5,
                  left: 278,
                  child: Container(
                      width: 52,
                      height: 52,
                      color: Colors.white,
                      child: qrPic == null
                          ? const Icon(
                              CupertinoIcons.qrcode,
                              size: 50,
                              color: Colors.black,
                            )
                          : SizedBox(
                              width: 34,
                              height: 40,
                              child: Image.file(
                                qrFile,
                                fit: BoxFit.cover,
                              ),
                            ))),

              // Aadhar Number
              Positioned(
                  top: 428,
                  left: 234,
                  child: Text(
                    aadharNumber,
                    style: const TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),

              // VID
              Positioned(
                  top: 435.5,
                  left: 244.5,
                  child: Text(
                    vid,
                    style: const TextStyle(fontSize: 5.5, color: Colors.black),
                  )),
            ],
          ),
        ),
      ),

      // Button to Download PDF
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.picture_as_pdf),
        onPressed: () async {
          setState(() {
            isDownloading = true;
          });
          await Future.delayed(const Duration(seconds: 2));

          writeOnPDF();
          savePDF();
        },
        label: const Text("Save PDF"),
      ),
    );
  }
}
