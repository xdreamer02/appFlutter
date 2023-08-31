import 'package:flutter/material.dart';
import 'package:planck/constants/status_constant.dart';
import 'package:planck/src/models/petition_model.dart';
import 'package:planck/src/screens/deliveryman/petition/petition_screen.dart';
import 'package:planck/src/screens/deliveryman/petitions/widget/info_petitions.dart';
import 'package:planck/src/screens/deliveryman/petitions/widget/slider_apply.dart';
import 'package:planck/src/widgets/avatar_image.dart';
import 'package:planck/src/widgets/card_notifications_icon.dart';

class ListPetitions extends StatelessWidget {
  final List<PetitionModel> petitions;

  const ListPetitions(this.petitions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: petitions.length,
      itemBuilder: (context, index) => _Petition(petitions[index]),
    );
  }
}

class _Petition extends StatelessWidget {
  final PetitionModel petition;
  final double height = 150;

  const _Petition(this.petition);

  @override
  Widget build(BuildContext context) {
    final card = SizedBox(
      height: height,
      child: Card(
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: <Widget>[
            AvatarImage(image: petition.store.company.image),
            InfoPetitions(height: height, petition: petition),
          ],
        ),
      ),
    );
    return Stack(
      children: <Widget>[
        card,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.blueAccent.withOpacity(0.6),
                onTap: () async {
                  if (petition.status == StatusOrder.started) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetitionScreen(petition),
                    ),
                  );
                }),
          ),
        ),
        petition.status == StatusOrder.started
            ? SliderApply(petition)
            : Container(),
        CardNotificationsIcon(
          notifications: petition.notificationsDeliveryman,
          status: petition.status,
        )
      ],
    );
  }
}
