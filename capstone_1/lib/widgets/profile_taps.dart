import 'package:flutter/material.dart';

class ProfileTaps extends StatelessWidget {
  const ProfileTaps(
      {super.key,
      required this.leftWidget,
      required this.rightWidget,
      this.letTabText = 'My'});

  final Widget leftWidget;
  final Widget rightWidget;
  final String letTabText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: TabBar(
            indicatorColor: const Color(0xff8ECAE6),
            labelStyle: const TextStyle(
                color: Color(0xff8ECAE6), fontWeight: FontWeight.w500),
            tabs: [
              Tab(text: '${letTabText.trim()} Trips'),
              const Tab(text: 'Joint Trips'),
            ],
          ),
        ),
        SizedBox(
          height: 500,
          child: TabBarView(
            children: [leftWidget, rightWidget],
          ),
        ),
      ],
    );
  }
}
