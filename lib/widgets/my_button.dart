import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget widget;
  final Function onPressed;
  final double roundness;
  final Color? color;
  final Color? accentColor;

  const MyButton({
    Key? key,
    required this.widget,
    required this.onPressed,
    this.roundness = 28,
    this.color,
    this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(15),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              color ?? Theme.of(context).primaryColor,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundness),
                side: BorderSide(
                  color: accentColor ?? color ?? Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          onPressed: () => onPressed(),
          child: widget,
        ),
      ),
    );
  }
}
