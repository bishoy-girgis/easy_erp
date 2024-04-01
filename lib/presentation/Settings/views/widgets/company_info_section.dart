// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:easy_erp/core/helper/app_constants.dart';
import 'package:easy_erp/core/helper/page_route_name.dart';
import 'package:easy_erp/core/widgets/custom_elevated_button.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
import 'package:easy_erp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/helper/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/text_builder.dart';

class CompanyInfoSection extends StatefulWidget {
  const CompanyInfoSection({
    super.key,
  });

  @override
  State<CompanyInfoSection> createState() => _CompanyInfoSectionState();
}

class _CompanyInfoSectionState extends State<CompanyInfoSection> {
  int selectedButtonIndex = -1;

  final TextEditingController branchNameController =
      TextEditingController(text: AppConstants.branchName);
  final TextEditingController branchAddressController =
      TextEditingController(text: AppConstants.branchAddress);
  final TextEditingController taxNumberController =
      TextEditingController(text: AppConstants.taxNumber);
  final TextEditingController notesController =
      TextEditingController(text: AppConstants.notes);
  String? imagePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final directory = await getApplicationDocumentsDirectory();
      final newPath = directory.path + '/${DateTime.now()}.png';

      await imageFile.copy(newPath);

      await SharedPref.set(key: 'logoPath', value: newPath); // Add this line

      setState(() {
        imagePath = newPath;
      });
      print("${SharedPref.get(key: "logoPath")}  IMAGE LOGOOOO PATHHH");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextBuilder(
              "Company information",
              isHeader: true,
              fontSize: 15,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextBuilder(
                  "Company logo",
                  isHeader: true,
                  fontSize: 12,
                ),
                imagePath != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 15.w),
                        child: Image.file(File(imagePath!),
                            width: 100.w, height: 100.h),
                      )
                    : Container(),
                Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: IconButton(
                      onPressed: _pickImage,
                      icon: const Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 45,
                      )),
                ),
              ],
            ),
            const Divider(),
            const TextBuilder(
              "Branch Name",
              isHeader: true,
              fontSize: 12,
            ),
            CustomTextFormField(
              controller: branchNameController,
              labelText: branchNameController.text.isEmpty
                  ? "Branch Name"
                  : branchNameController.text,
              focusedBorderColor: Colors.blueGrey,
              onChange: (value) {
                branchNameController.text = value;
                SharedPref.set(key: "branchName", value: value);
                debugPrint('😘😘' + branchNameController.text);
                debugPrint('sharedddddd NAMEEEEEE' +
                    SharedPref.get(key: 'branchName'));
                setState(() {});
              },
            ),
            const Divider(),
            const TextBuilder(
              "Branch Address",
              isHeader: true,
              fontSize: 12,
            ),
            CustomTextFormField(
              controller: branchAddressController,
              labelText: branchAddressController.text.isEmpty
                  ? "Branch Address"
                  : branchAddressController.text,
              onChange: (value) {
                branchAddressController.text = value;
                SharedPref.set(key: "branchAddress", value: value);
                debugPrint('😘😘' + branchAddressController.text);
                debugPrint('sharedddddd ADDRESSSSSSS' +
                    SharedPref.get(key: 'branchAddress'));
                setState(() {});
              },
            ),
            const Divider(),
            const TextBuilder(
              "Tax Number",
              isHeader: true,
              fontSize: 12,
            ),
            CustomTextFormField(
              controller: taxNumberController,
              labelText: taxNumberController.text.isEmpty
                  ? "Tax Number"
                  : taxNumberController.text,
              onChange: (value) {
                taxNumberController.text = value;
                SharedPref.set(key: "taxNumber", value: value);
                debugPrint('😘😘' + taxNumberController.text);
                debugPrint('sharedddddd TAAXXXXXX NUMBERRR' +
                    SharedPref.get(key: 'taxNumber'));
                setState(() {});
              },
            ),
            const Divider(),
            const TextBuilder(
              "Notes",
              isHeader: true,
              fontSize: 12,
            ),
            CustomTextFormField(
              controller: notesController,
              labelText:
                  notesController.text.isEmpty ? "Notes" : notesController.text,
              maxLines: 3,
              onChange: (value) {
                notesController.text = value;
                SharedPref.set(key: "notes", value: value);
                debugPrint('😘😘' + notesController.text);
                debugPrint(
                    'sharedddddd NOTEESSSSSS' + SharedPref.get(key: 'notes'));
                setState(() {});
              },
            ),
            CustomElevatedButton(
              width: double.infinity,
              title: const TextBuilder(
                "Submit",
                color: AppColors.whiteColor,
              ),
              onPressed: () {
                AppConstants.updateSettingValues();
                debugPrint("supmiitttteeeddddddddddddddddddddddddddddddddddd");
                debugPrint(AppConstants.branchName);
                debugPrint(AppConstants.branchAddress);
                debugPrint(AppConstants.taxNumber);
                debugPrint(AppConstants.notes);
                debugPrint(AppConstants.baseUrl);
                debugPrint("${SharedPref.get(key: "baseUrl")}");
                debugPrint(
                    "${SharedPref.get(key: "logoPath")}  IMAGE LOGOOOO PATHHH");
                SharedPref.remove(key: "accessToken");
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    AppRouters.kLogin, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
