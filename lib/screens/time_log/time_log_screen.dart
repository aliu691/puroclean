// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:puroclean/utils/puroclean_attendance.dart';

class TimeLogScreen extends StatefulWidget {
  const TimeLogScreen({super.key});

  static PageRoute<void> getRoute() {
    const settings = RouteSettings(name: '/log-time');

    return MaterialPageRoute<void>(
      builder: (_) => const TimeLogScreen(),
      settings: settings,
    );
  }

  @override
  State<TimeLogScreen> createState() => _TimeLogScreenState();
}

final containerShadow = [
  const BoxShadow(
    offset: Offset(2, 5),
    color: Color(0XFF6B6B6B),
    blurRadius: 10,
  ),
  BoxShadow(
    offset: const Offset(0, 12),
    color: const Color(0XFF515151).withOpacity(0.5),
    blurRadius: 50,
  ),
  BoxShadow(
    offset: const Offset(0, 6),
    color: const Color(0XFF000000).withOpacity(0.25),
    blurRadius: 30,
    spreadRadius: 4,
  ),
];

class _TimeLogScreenState extends State<TimeLogScreen> {
  TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  TimeOfDay? selectedTime;
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF393838),
      appBar: AppBar(
        backgroundColor: const Color(0XFF393838),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: GestureDetector(
                    //onTap: () => print('pressed'),
                    onTap: () => _updateSheet(),
                    child: Container(
                      padding: const EdgeInsets.all(80),
                      decoration: BoxDecoration(
                        boxShadow: containerShadow,
                        border: Border.all(color: Colors.white, width: 16),
                        shape: BoxShape.circle,
                        color: const Color(0XFFF91919),
                      ),
                      child: Text(
                        'Out of the \nWareheouse',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
                Text(
                  'Forgot to tap?',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: const Color(0XFFB0FFB4),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter the time you left?',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: const Color(0XFFE2E2E2),
                      ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  child: TextFormField(
                    readOnly: true,
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now(),
                        initialEntryMode: entryMode,
                        orientation: orientation,
                        builder: (BuildContext context, Widget? child) {
                          // We just wrap these environmental changes around the
                          // child in this builder so that we can apply the
                          // options selected above. In regular usage, this is
                          // rarely necessary, because the default values are
                          // usually used as-is.
                          return Theme(
                            data: Theme.of(context).copyWith(
                              materialTapTargetSize: tapTargetSize,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat: use24HourTime,
                                ),
                                child: child!,
                              ),
                            ),
                          );
                        },
                      );
                      setState(() {
                        selectedTime = time;
                        timeController.text = selectedTime!.format(context);
                      });
                    },
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Enter time',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    controller: timeController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFFF91919),
                    ),
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                    ),
                    onPressed: () => print('log'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_updateSheet() async {
  final sheet = GSheets(googleCredentials);

  final spreadSheet = await sheet.spreadsheet(spreadsheetId);

  final exactSheet = spreadSheet.worksheetByTitle('attendance1')!;

  await exactSheet.values.insertValue('aliu', column: 1, row: 4);

  await exactSheet.values.insertValue('out of warehouse', column: 2, row: 4);

  await exactSheet.values.insertValue(DateTime.now(), column: 3, row: 4);
}
