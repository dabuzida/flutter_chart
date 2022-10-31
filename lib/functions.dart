import 'package:intl/intl.dart';

class MyTimeConversion {
  String millisecondsToDate({String format = 'yyyy년 MM월 dd일 a hh시 mm분', required int unixTime}) {
    return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(unixTime));
  }

  String localizeDayToKor({required String engDay}) {
    switch (engDay) {
      case 'Mon':
        return '월';

      case 'Tue':
        return '화';

      case 'Wed':
        return '수';

      case 'Thu':
        return '목';

      case 'Fri':
        return '금';

      case 'Sat':
        return '토';

      case 'Sun':
        return '일';

      default:
        return engDay;
    }
  }
}
