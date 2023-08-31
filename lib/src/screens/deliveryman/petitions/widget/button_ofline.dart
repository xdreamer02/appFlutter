import 'package:flutter/material.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/screens/deliveryman/petitions/petitions_controller.dart';

class ButtonOfline extends StatelessWidget {
  const ButtonOfline({
    Key? key,
    required this.petitionsController,
  }) : super(key: key);

  final PetitionsController petitionsController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
      label: Text(
        S.of(context).bOffline,
        style: const TextStyle(color: Colors.white),
      ),
      icon: const Icon(
        Icons.night_shelter_outlined,
        color: Colors.white,
        size: 28,
      ),
      onPressed: () {
        petitionsController.startOnline();
      },
    );
  }
}
