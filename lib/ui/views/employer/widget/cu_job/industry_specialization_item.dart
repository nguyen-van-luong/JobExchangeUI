import 'package:flutter/material.dart';

class IndustryItem extends StatelessWidget {
  final String industry;
  final VoidCallback onDelete;

  const IndustryItem({
    super.key,
    required this.industry,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(industry, style: const TextStyle(fontSize: 16, color: Colors.black87)),
            IconButton(
                icon: const Icon(Icons.close),
                onPressed: onDelete,
                iconSize: 20,
                style: ButtonStyle(
                  iconColor: MaterialStateProperty.all(Colors.black54),
                )),
          ],
        ),
      ),
    );
  }
}
