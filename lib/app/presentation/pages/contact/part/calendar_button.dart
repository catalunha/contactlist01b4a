import 'package:contactlist01b4a/app/presentation/controllers/contact/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarButton extends StatelessWidget {
  final ContactController _controller = Get.find();
  final dateFormat = DateFormat('dd/MM/y');

  CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // var lastDate = _controller.contactModel?.birthday ?? DateTime.now();
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: _controller.selectedDate ?? DateTime.now(),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year + 1),
        );
        _controller.selectedDate = selectedDate;
      },
      // borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Obx(() {
              if (_controller.selectedDate != null) {
                return Text(dateFormat.format(_controller.selectedDate!));
              } else {
                return const Text('Selecione uma data');
              }
            }),
          ],
        ),
      ),
    );
  }
}
