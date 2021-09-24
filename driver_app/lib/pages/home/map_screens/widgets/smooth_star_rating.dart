import 'package:flutter/material.dart';
import 'package:driver_app/theme/colors.dart';

class SmoothStarRating extends StatelessWidget {
  SmoothStarRating({
    Key? key,
    required this.rating,
    this.starCount = 5,
    this.onRatingChanged1,
    this.onRatingChanged2,
    this.onRatingChanged3,
    this.onRatingChanged4,
    this.onRatingChanged5,
  }) : super(key: key);
  final onRatingChanged1;
  final onRatingChanged2;
  final onRatingChanged3;
  final onRatingChanged4;
  final onRatingChanged5;
  final int rating;
  final starCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onRatingChanged1,
          child: Icon(
            Icons.star_rate_rounded,
            color: rating >= 1 ? Color(0xFFFFD708) : primaryColorWhite,
            size: 40,
          ),
        ),
        GestureDetector(
          onTap: onRatingChanged2,
          child: Icon(
            Icons.star_rate_rounded,
            color: rating >= 2 ? Color(0xFFFFD708) : primaryColorWhite,
            size: 40,
          ),
        ),
        GestureDetector(
          onTap: onRatingChanged3,
          child: Icon(
            Icons.star_rate_rounded,
            color: rating >= 3 ? Color(0xFFFFD708) : primaryColorWhite,
            size: 40,
          ),
        ),
        GestureDetector(
          onTap: onRatingChanged4,
          child: Icon(
            Icons.star_rate_rounded,
            color: rating >= 4 ? Color(0xFFFFD708) : primaryColorWhite,
            size: 40,
          ),
        ),
        GestureDetector(
          onTap: onRatingChanged5,
          child: Icon(
            Icons.star_rate_rounded,
            color: rating >= 5 ? Color(0xFFFFD708) : primaryColorWhite,
            size: 40,
          ),
        ),
      ],
    );
  }
}
