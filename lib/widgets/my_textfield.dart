import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hint;
  final String? errorMessage;
  final IconData? icon;
  final ValueChanged<String> onChanged;
  final bool? fieldUnfilled;
  final RegExp? validator;
  final bool enabled;
  final String? initialValue;
  final bool autocorrectDisable;

  const MyTextField({
    Key? key,
    required this.hint,
    this.errorMessage,
    this.icon,
    required this.onChanged,
    this.fieldUnfilled,
    this.validator,
    this.enabled = true,
    this.initialValue,
    this.autocorrectDisable = false,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.hint,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[200]!,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: widget.fieldUnfilled == true
                  ? Colors.red[800]!
                  : Colors.grey[700]!,
              width: 1,
            ),
          ),
          child: TextFormField(
            onChanged: widget.onChanged,
            initialValue: widget.initialValue,
            enabled: widget.enabled,
            autovalidateMode: widget.fieldUnfilled == null
                ? AutovalidateMode.onUserInteraction
                : (widget.fieldUnfilled!
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled),
            validator: (text) {
              if (text == null || text.isEmpty) {
                return '${widget.errorMessage ?? widget.hint} is required';
              } else if (widget.validator != null &&
                  !widget.validator!.hasMatch(text)) {
                return '${widget.hint} is invalid';
              }

              return null;
            },
            autocorrect: widget.autocorrectDisable ? false : true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
              hintText: widget.hint,
              icon: widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
