import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StraightLineBetwWord extends StatelessWidget {
  const StraightLineBetwWord({
    required this.label,
    required this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _customDivider(),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.grey.shade700),
          ),
        ),
        _customDivider(),
      ],
    );
  }

  Expanded _customDivider() {
    return Expanded(
      child: new Container(
          child: Divider(
        thickness: 1,
        color: Colors.grey,
        height: height,
      )),
    );
  }
}
