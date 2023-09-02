import 'package:autosense_challenge_frontend/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class AddPumpDialog extends StatefulWidget {
  final int? id;
  final String? fuelType;
  final double? price;
  final bool? available;
  final void Function(int? id, String fuelType, double price, bool available)
      onDone;

  const AddPumpDialog({
    Key? key,
    this.id,
    this.fuelType,
    this.price,
    this.available,
    required this.onDone,
  }) : super(key: key);

  @override
  State<AddPumpDialog> createState() => _AddPumpDialogState();
}

class _AddPumpDialogState extends State<AddPumpDialog> {
  String fuelType = "";
  double price = 0;
  bool available = true;

  @override
  void initState() {
    super.initState();
    fuelType = widget.fuelType ?? "";
    price = widget.price ?? 0;
    available = widget.available ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      title: Text(
        "Add Pump",
        style: Theme.of(context).textTheme.displaySmall!.merge(
              TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextField(
              initialValue: fuelType,
              hint: "Fuel Type",
              onChanged: (value) {
                fuelType = value;
              }),
          MyTextField(
              initialValue: price.toString(),
              hint: "Price",
              onChanged: (value) {
                price = double.parse(value);
              }),
          Row(
            children: [
              Checkbox(
                value: available,
                onChanged: (bool? value) {
                  setState(() {
                    available = value!;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              ),
              const Text("Available"),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            "Done",
            style: Theme.of(context).textTheme.headlineSmall!.merge(
                  TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
          ),
          onPressed: () {
            widget.onDone(widget.id, fuelType, price, available);
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            "Cancel",
            style: Theme.of(context).textTheme.headlineSmall!.merge(
                  TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
