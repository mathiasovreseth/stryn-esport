import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stryn_esport/widgets/datePicker/date_picker_utils.dart';

/// Represents a custom picker when picking dates
class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  String text(int value, int length) {
    String month = convertMontIndexToString(value);
    return month.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.year);
    setMiddleIndex(this.currentTime.month);
    setRightIndex(this.currentTime.day);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 1950 && index < 2022) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 1 && index < 13) {
      return text(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 32) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return DateTime.utc(
        currentLeftIndex(), currentMiddleIndex(), currentRightIndex());
  }
}
