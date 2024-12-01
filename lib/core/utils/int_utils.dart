import 'package:intl/intl.dart';

extension IntUtils on int{
  String formatNumber (){
    final formatter = NumberFormat('#,###');
    return formatter.format(this);
  }
}