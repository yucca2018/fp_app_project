import 'package:flutter/material.dart';

Widget buildUserInfoText(String label, String value,
    {bool bold = false, double fontSize = 18}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$label: $value',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      const SizedBox(height: 8),
    ],
  );
}

class StringUtils {
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}
