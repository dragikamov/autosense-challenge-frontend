import 'package:flutter/material.dart';

// A custom button that can be used throughout the app
class MyButton extends StatelessWidget {
  final Widget widget;
  final Function onPressed;
  final Color? color;

  const MyButton({
    Key? key,
    required this.widget,
    required this.onPressed,
    this.color,
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
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: color ?? Theme.of(context).primaryColor,
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
