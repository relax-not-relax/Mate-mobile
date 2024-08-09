import 'package:flutter/material.dart';
import 'package:mate_project/models/pack.dart';
import 'package:mate_project/screens/subscription/widgets/pack_element.dart';

class SubscriptionSelection extends StatefulWidget {
  const SubscriptionSelection({
    super.key,
    required this.pack,
    required this.onSelectPack,
  });

  final Pack pack;
  final void Function(Pack) onSelectPack;

  @override
  State<SubscriptionSelection> createState() => _SubscriptionSelectionState();
}

class _SubscriptionSelectionState extends State<SubscriptionSelection> {
  List<Pack> packSelection = [];

  @override
  void initState() {
    super.initState();
    packSelection = [
      Pack(
        packId: 1,
        price: 289,
        packName: "Gold Room",
        description: "",
        duration: 0,
        status: true,
      ),
      Pack(
        packId: 2,
        price: 199,
        packName: "Silver Room",
        description: "",
        duration: 0,
        status: true,
      ),
      Pack(
        packId: 3,
        price: 99,
        packName: "Bronze Room",
        description: "",
        duration: 0,
        status: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: packSelection.map(
        (p) {
          return InkWell(
            onTap: () {
              widget.onSelectPack(p);
            },
            child: PackElement(
              packInput: p,
              selected: p.packId == widget.pack.packId,
            ),
          );
        },
      ).toList(),
    );
  }
}
