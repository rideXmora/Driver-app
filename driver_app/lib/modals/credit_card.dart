import 'package:driver_app/utils/card_type_enum.dart';

class CreditCard {
  String cardNumber;
  CardType cardType;
  String cardTypeString;
  String cardExpiry;
  String cardHolderName;
  String cardID;

  CreditCard({
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardHolderName,
    required this.cardType,
    required this.cardTypeString,
    required this.cardID,
  });
}
