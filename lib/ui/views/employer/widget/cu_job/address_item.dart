import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final String provinceName;
  final String address;
  final VoidCallback onDelete;

  const AddressItem({
    super.key,
    required this.provinceName,
    required this.address,
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
            Text(provinceName + ": ", style: const TextStyle(fontSize: 16, color: Colors.black87)),
            Text(address,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                maxLines: 1),
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
