import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Utils {
  static String getFormattedDateSimple(int time) {
    DateFormat date = DateFormat("dd/MM/yyyy");
    return date.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }

  static String getDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(now);
  }

  static String getDateTimeHour() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(now);
  }

  static String getDateTimeConv(String date) {
    return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
  }

  static String getHourTime() {
    DateTime now = DateTime.now();
    return DateFormat('HH:mm:ss').format(now);
  }
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({this.maxDigits});
  final int? maxDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits!) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ ${formatter.format(value / 100)}";
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class DecimalTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regEx = RegExp(r'^\d*\.?\d*');
    final String newString = regEx.stringMatch(newValue.text) ?? '';
    return newString == newValue.text ? newValue : oldValue;
  }
}


// // how to use
// Widget _fieldValues() {
//     return Padding(
//       padding: EdgeInsets.only(top: 10, bottom: 60),
//       child:  TextFormField(
//               decoration: InputDecoration(
//                 icon: Icon(Icons.monetization_on),
//                 labelText: 'Valor *',
//               ),
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 FilteringTextInputFormatter.digitsOnly,
//                 CurrencyPtBrInputFormatter()
//               ]
//        );
//  }