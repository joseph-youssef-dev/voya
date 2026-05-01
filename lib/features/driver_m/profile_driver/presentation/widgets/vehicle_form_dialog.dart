import 'package:flutter/material.dart';

import '../../data/models/driver_profile_model.dart';
import '../../logic/cubit/driver_profile_cubit.dart';

class VehicleFormDialog extends StatefulWidget {
  final VehicleModel? vehicle;
  final DriverProfileCubit cubit;

  const VehicleFormDialog({super.key, this.vehicle, required this.cubit});

  @override
  State<VehicleFormDialog> createState() => _VehicleFormDialogState();
}

class _VehicleFormDialogState extends State<VehicleFormDialog> {
  late TextEditingController _modelController;
  late TextEditingController _colorController;
  late TextEditingController _licenseController;
  late TextEditingController _seatsController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _modelController = TextEditingController(text: widget.vehicle?.model ?? '');
    _colorController = TextEditingController(text: widget.vehicle?.color ?? '');
    _licenseController = TextEditingController(text: widget.vehicle?.vehicleLicense ?? '');
    _seatsController = TextEditingController(text: widget.vehicle?.numberOfPassengers.toString() ?? '');
  }

  @override
  void dispose() {
    _modelController.dispose();
    _colorController.dispose();
    _licenseController.dispose();
    _seatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.vehicle == null ? 'Add Vehicle' : 'Edit Vehicle'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Model'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: 'Color'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _licenseController,
                decoration: const InputDecoration(labelText: 'License Plate'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _seatsController,
                decoration: const InputDecoration(labelText: 'Number of Seats'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) return 'Required';
                  if (int.tryParse(val) == null) return 'Must be a number';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.vehicle == null) {
                widget.cubit.addVehicle(
                  model: _modelController.text,
                  color: _colorController.text,
                  vehicleLicense: _licenseController.text,
                  numberOfPassengers: int.parse(_seatsController.text),
                );
              } else {
                widget.cubit.updateVehicle(
                  id: widget.vehicle!.id,
                  model: _modelController.text,
                  color: _colorController.text,
                  vehicleLicense: _licenseController.text,
                  numberOfPassengers: int.parse(_seatsController.text),
                );
              }
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D32B3)),
          child: Text(widget.vehicle == null ? 'Add' : 'Save', style: const TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
