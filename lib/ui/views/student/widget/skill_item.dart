import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SkillItem extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  const SkillItem({
    super.key,
    required this.name,
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
            Text(name, style: const TextStyle(fontSize: 16, color: Colors.black87)),
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