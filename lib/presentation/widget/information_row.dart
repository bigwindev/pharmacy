import 'package:flutter/material.dart';

class InformationRow extends StatelessWidget {
  const InformationRow({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              "$title:",
              textAlign: TextAlign.end,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            child: Text(value),
          ),
        ),
      ],
    );
  }
}
