import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthHeader extends StatelessWidget {
  const MonthHeader({
    super.key,
    required this.currentPage,
    required this.disableFutureDates,
    required this.onPrevious,
    required this.onNext,
    required this.goToToday,
  });

  final int currentPage;
  final bool disableFutureDates;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final VoidCallback goToToday;

  @override
  Widget build(BuildContext context) {
    final year = currentPage ~/ 12;
    final month = (currentPage % 12) + 1;
    final date = DateTime(year, month, 1);
    final formattedMonth = DateFormat.yMMMM().format(date);
    final isFuture = date.isAfter(DateTime.now());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (onPrevious != null)
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.arrow_left),
          )
        else
          const SizedBox(),
        GestureDetector(
          onTap: goToToday,
          child: Text(
            formattedMonth,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        if (onNext != null)
          IconButton(
            onPressed: (!disableFutureDates || !isFuture) ? onNext : null,
            icon: const Icon(Icons.arrow_right),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
