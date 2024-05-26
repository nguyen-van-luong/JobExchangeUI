import 'package:flutter/material.dart';

import '../common/app_constants.dart';
import 'header/left_header.dart';
import 'header/right_header.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      decoration: const BoxDecoration (
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      color: Color.fromARGB(255, 0, 86, 143),
      ),
      child: Center(
        child:
          Container(
            margin: const EdgeInsets.symmetric(horizontal: horizontalSpace),
            constraints: const BoxConstraints(maxWidth: maxContent),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [LeftHeader(), RightHeader()],
            ),
          ),

      ),
    );
    //);
  }
}
