import 'package:easy_erp/core/widgets/custom_text_form_field.dart';
import 'package:easy_erp/data/services/local/shared_pref.dart';
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
  DateTime? selectedDate = DateTime.now();
  Future<DateTime?> picktDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomTextFormField(
        labelText: dateController.text,
        isContentBold: true,
        controller: dateController,
        readOnly: true,
        centerContent: true,
        contentSize: 11,
        onTap: () async {
          selectedDate = await picktDate();
          if (selectedDate != null) {
            setState(() {
              dateController.text =
                  DateFormat('dd/MM/yyyy').format(selectedDate!);
              String formatedDate =
                  DateFormat('dd/MM/yyyy').format(selectedDate!);
              SharedPref.set(key: 'invoiceDate', value: formatedDate);
              debugPrint(formatedDate);
            });
          } else {
            setState(() {
              dateController.text =
                  DateFormat('dd/MM/yyyy').format(DateTime.now());
              String formatedDate =
                  DateFormat('dd/MM/yyyy').format(selectedDate!);
              SharedPref.set(key: 'invoiceDate', value: formatedDate);
              debugPrint(formatedDate);
            });
            String period = DateTime.now().hour >= 12 ? 'PM' : 'AM';
            String formatedTime =
                DateFormat('hh:mm $period').format(DateTime.now());
            SharedPref.set(key: 'invoiceTime', value: '$formatedTime $period');
            debugPrint(formatedTime);
          }
        },
      ),
    );
  }
}

class HoursAndMinutes extends StatelessWidget {
  const HoursAndMinutes({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.now();
    TextEditingController timeController = TextEditingController();
    int hour = dateTime.hour % 12;
    int minute = dateTime.minute;
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';
    timeController = TextEditingController(text: '$hour:$minute $period');

    return Center(
      child: CustomTextFormField(
        centerContent: true,
        contentSize: 11,
        labelText: timeController.text,
        isContentBold: true,
        controller: timeController,
        readOnly: true,
      ),
    );
  }
}
