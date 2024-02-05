import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  TextEditingController dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  // String date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomTextFormField(
        labelText: dateController.text,
        isContentBold: true,
        controller: dateController,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000),
          );
          if (pickedDate != null) {
            setState(() {
              dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
              // date = DateFormat('dd/MM/yyyy').format(pickedDate);
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }
}

class HoursAndMinutes extends StatefulWidget {
  const HoursAndMinutes({super.key});

  @override
  State<HoursAndMinutes> createState() => _HoursAndMinutesState();
}

class _HoursAndMinutesState extends State<HoursAndMinutes> {
  TextEditingController dateController =
      TextEditingController(text: DateFormat('HH:MM').format(DateTime.now()));
  // String date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomTextFormField(
        labelText: dateController.text,
        isContentBold: true,
        controller: dateController,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(3000),
          );
          if (pickedDate != null) {
            setState(() {
              dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
              // date = DateFormat('dd/MM/yyyy').format(pickedDate);
            });
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }
}
