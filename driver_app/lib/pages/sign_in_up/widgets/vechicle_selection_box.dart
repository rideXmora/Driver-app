import 'package:driver_app/theme/colors.dart';
import 'package:flutter/material.dart';

class VechicleSelectionBox extends StatelessWidget {
  const VechicleSelectionBox({
    Key? key,
    required this.onTap,
    required this.vechicle,
    required this.selected,
  }) : super(key: key);
  final onTap;
  final vechicle;
  final selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              vechicle["type"],
              style: TextStyle(
                fontSize: 17,
                color: selected ? primaryColor : primaryColorBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? primaryColorLight : Color(0xFFC4C4C4),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image(image: AssetImage(vechicle["image"])),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Divider(
                thickness: 1.5,
                color: primaryColorBlack,
                height: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
