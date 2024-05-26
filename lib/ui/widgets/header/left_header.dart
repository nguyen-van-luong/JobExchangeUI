import 'package:flutter/material.dart';
import 'package:untitled1/ui/router.dart';

class LeftHeader extends StatefulWidget {
  const LeftHeader({super.key});

  @override
  State<LeftHeader> createState() => _LeftHeaderState();
}

class _LeftHeaderState extends State<LeftHeader> {
  bool _isJobHovering = false;
  bool _isEmployHovering = false;
  bool _isCVHovering = false;
  bool _isStudentHovering = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              appRouter.go('/');
            },
            child: const Text(
              'JOB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
          ),
          SizedBox(width: screenSize.width / 20),
          InkWell(
            onHover: (value) {
              setState(() {
                value ? _isJobHovering = true : _isJobHovering = false;
              });
            },
            onTap: () {
              appRouter.go('/viewsearch');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Việc làm',
                  style: TextStyle(
                      color: _isJobHovering ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(width: screenSize.width / 30),
          InkWell(
            onHover: (value) {
              setState(() {
                value ? _isEmployHovering = true : _isEmployHovering = false;
              });
            },
            onTap: () {
              appRouter.go('/search_employer');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nhà tuyển dụng',
                  style: TextStyle(
                      color: _isEmployHovering ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(width: screenSize.width / 30),
          InkWell(
            onHover: (value) {
              setState(() {
                value ? _isCVHovering = true : _isCVHovering = false;
              });
            },
            onTap: () {
              appRouter.go('/cv/viewsearch');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CV',
                  style: TextStyle(
                      color: _isCVHovering ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(width: screenSize.width / 30),
          InkWell(
            onHover: (value) {
              setState(() {
                value ? _isStudentHovering = true : _isStudentHovering = false;
              });
            },
            onTap: () {
              appRouter.go('/search_student');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sinh viên',
                  style: TextStyle(
                      color: _isStudentHovering ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
