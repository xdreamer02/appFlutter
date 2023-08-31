import 'package:flutter/material.dart';
import 'package:planck/src/models/petition_model.dart';
import 'package:planck/src/screens/deliveryman/petition/petition_controller.dart';
import 'package:planck/src/screens/deliveryman/petition/widget/content_petition.dart';
import 'package:provider/provider.dart';

class PetitionScreen extends StatelessWidget {
  final PetitionModel petition;

  const PetitionScreen(this.petition, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PetitionController>.value(
      value: PetitionController(petition),
      child: Consumer<PetitionController>(
        builder: (context, petitionController, child) =>
            ContentPetition(petitionController),
      ),
    );
  }
}
