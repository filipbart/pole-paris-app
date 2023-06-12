import 'package:flutter/material.dart';

class UserPicture extends StatelessWidget {
  final double radius;
  const UserPicture({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: radius,
      backgroundImage: const NetworkImage(
          "https://img.freepik.com/darmowe-zdjecie/wewnatrz-portret-atrakcyjnej-mlodej-europejki-o-rudej-kobiecie-z-piegowata-twarza-i-wlosami-w-biala-bluzke-jej-wyglad-i-postawa-wyrazajace-pewnosc-siebie_273609-493.jpg"),
    );
  }
}
