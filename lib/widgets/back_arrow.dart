import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  final String displayText;
  const BackArrow({super.key, required this.displayText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            padding: EdgeInsets.only(right: 12),
            constraints: const BoxConstraints(),
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)
          ),
          Expanded(
            child: Text(
              displayText,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            )
          ),
        ],
      ),
    );
  }
}