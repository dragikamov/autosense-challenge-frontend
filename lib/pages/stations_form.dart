import 'package:autosense_challenge_frontend/models/station_model.dart';
import 'package:autosense_challenge_frontend/widgets/add_pump_dialog.dart';
import 'package:autosense_challenge_frontend/widgets/my_button.dart';
import 'package:autosense_challenge_frontend/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class StationsForm extends StatefulWidget {
  final Station? station;

  const StationsForm({Key? key, this.station}) : super(key: key);

  @override
  State<StationsForm> createState() => _StationsFormState();
}

class _StationsFormState extends State<StationsForm> {
  late Station station;

  @override
  void initState() {
    super.initState();
    station = widget.station ??
        Station(
          id: null,
          idName: null,
          name: null,
          address: null,
          city: null,
          longitude: null,
          latitude: null,
          pumps: [],
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.station == null ? 'Add Station' : "Update Station"),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                hint: "ID",
                onChanged: (value) {
                  station.idName = value;
                },
              ),
              MyTextField(
                hint: "Name",
                onChanged: (value) {
                  station.name = value;
                },
              ),
              MyTextField(
                hint: "Address",
                onChanged: (value) {
                  station.address = value;
                },
              ),
              MyTextField(
                hint: "City",
                onChanged: (value) {
                  station.city = value;
                },
              ),
              MyTextField(
                hint: "Longitude",
                onChanged: (value) {
                  station.longitude = double.parse(value);
                },
              ),
              MyTextField(
                hint: "Latitude",
                onChanged: (value) {
                  station.latitude = double.parse(value);
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Pumps:",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      station.pumps[index].fuelType,
                    ),
                    subtitle: Text(
                      station.pumps[index].price.toString(),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddPumpDialog(
                                    id: station.pumps[index].id,
                                    fuelType: station.pumps[index].fuelType,
                                    price: station.pumps[index].price,
                                    available: station.pumps[index].available,
                                    onDone: (id, fuelType, price, available) {
                                      setState(() {
                                        station.pumps[index] = Pump(
                                          id: id,
                                          fuelType: fuelType,
                                          price: price,
                                          available: available,
                                        );
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                station.pumps.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: station.pumps.length,
              ),
              MyButton(
                widget: const Text(
                  "Add Pump",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddPumpDialog(
                        onDone: (id, fuelType, price, available) {
                          setState(() {
                            station.pumps.add(
                              Pump(
                                id: id,
                                fuelType: fuelType,
                                price: price,
                                available: available,
                              ),
                            );
                          });
                        },
                      );
                    },
                  );
                },
              ),
              MyButton(
                widget: const Text(
                  "Add Station",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  // TODO: Add Station
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
