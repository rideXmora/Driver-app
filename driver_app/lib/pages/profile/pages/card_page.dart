import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/modals/credit_card.dart';
import 'package:driver_app/utils/card_type_enum.dart';
import 'package:driver_app/theme/colors.dart';
import 'package:driver_app/pages/profile/widgets/credit_card.dart';
import 'package:driver_app/widgets/dialog_box.dart';

class MyCardsScreen extends StatefulWidget {
  @override
  _MyCardsScreenState createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  List<CreditCard> cardList = [
    CreditCard(
      cardNumber: "1234123412341234",
      cardExpiry: "01/25",
      cardHolderName: "Avishka Rathnavibushana",
      cardType: CardType.visa,
      cardTypeString: "Visa",
      cardID: "1",
    ),
    CreditCard(
      cardNumber: "1234123412341234",
      cardExpiry: "01/25",
      cardHolderName: "Avishka Rathnavibushana",
      cardType: CardType.americanExpress,
      cardTypeString: "americanExpress",
      cardID: "2",
    ),
    CreditCard(
      cardNumber: "1234123412341234",
      cardExpiry: "01/25",
      cardHolderName: "Avishka Rathnavibushana",
      cardType: CardType.dinersClub,
      cardTypeString: "dinersClub",
      cardID: "3",
    ),
    CreditCard(
      cardNumber: "1234123412341234",
      cardExpiry: "01/25",
      cardHolderName: "Avishka Rathnavibushana",
      cardType: CardType.discover,
      cardTypeString: "discover",
      cardID: "4",
    ),
    CreditCard(
      cardNumber: "1234123412341234",
      cardExpiry: "01/25",
      cardHolderName: "Avishka Rathnavibushana",
      cardType: CardType.masterCard,
      cardTypeString: "masterCard",
      cardID: "5",
    ),
  ];
  late int selectedCard;
  List<Color> colorList = [
    Color(0xff384BE7),
    Color(0xff9A38E7),
    Color(0xff3A93AF),
  ];
  bool dialogBox = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    //loadBankCard();
    setState(() {
      selectedCard = int.parse(cardList[0].cardID);
    });
  }

  Future loadBankCard() async {
    //await cardController.loadBankCards();
    // setState(() {
    //   cardList = cardController.bankCards.value;
    // });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (dialogBox) {
          if (!loading) {
            setState(() {
              dialogBox = false;
            });
          }
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColorWhite,
              title: Text(
                "My Cards",
                style: TextStyle(
                  color: primaryColorBlack,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left_sharp,
                  size: 30,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      dialogBox = true;
                    });
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'Remove Card',
                        style: TextStyle(
                          color: Color(0xFFD7A7A7),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: primaryColorWhite,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                // child: ListView.builder(
                //   physics: BouncingScrollPhysics(),
                //   itemCount: cardList.length,
                //   itemBuilder: (context, index) {
                //     // return Center(
                //     //   child: Padding(
                //     //     padding: const EdgeInsets.only(top: 7, bottom: 10),
                //     //     child: GestureDetector(
                //     //       onTap: () {
                //     //         Navigator.of(context).pop();
                //     //       },
                //     //       child: CreditCardWidget(
                //     //         width: width * 0.9,
                //     //         backgroundColor: (index + 1) % 3 == 1
                //     //             ? colorList[0]
                //     //             : (index + 1) % 3 == 2
                //     //                 ? colorList[1]
                //     //                 : colorList[2],
                //     //         cardNumber: cardList[index].cardNumber,
                //     //         cardType: cardList[index].cardType,
                //     //         cardTypeString: cardList[index].cardTypeString,
                //     //         expireDate: cardList[index].cardExpiry,
                //     //         height: width * 0.55,
                //     //         topSVGAlignment: (index + 1) % 2 == 1
                //     //             ? Alignment.topRight
                //     //             : Alignment.topLeft,
                //     //       ),
                //     //     ),
                //     //   ),
                //     // );

                // return Padding(
                //   padding:
                //       EdgeInsets.only(top: 7, bottom: 10, left: 20, right: 20),
                //   child: Container(
                //     width: width * 0.9,
                //     height: width * 0.55,
                //     decoration: BoxDecoration(
                //       color: primaryColor,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Center(
                //       child: Icon(
                //         Icons.add,
                //         color: primaryColorWhite,
                //         size: 30,
                //       ),
                //     ),
                //   ),
                // );
                //   },
                // ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: cardList
                        .map((card) {
                          int index = cardList.indexOf(card);
                          return Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 7, bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCard = index;
                                  });
                                },
                                child: CreditCardWidget(
                                  selected: selectedCard == index,
                                  width: width * 0.9,
                                  backgroundColor: (index + 1) % 3 == 1
                                      ? colorList[0]
                                      : (index + 1) % 3 == 2
                                          ? colorList[1]
                                          : colorList[2],
                                  cardNumber: cardList[index].cardNumber,
                                  cardType: cardList[index].cardType,
                                  cardTypeString:
                                      cardList[index].cardTypeString,
                                  expireDate: cardList[index].cardExpiry,
                                  height: width * 0.55,
                                  topSVGAlignment:
                                      (int.parse(card.cardID) + 1) % 2 == 1
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                ),
                              ),
                            ),
                          );
                        })
                        .toList()
                        .followedBy([
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 7,
                                bottom: 10,
                              ),
                              child: Container(
                                width: width * 0.9,
                                height: width * 0.55,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: primaryColorWhite,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ])
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          dialogBox
              ? DialogBox(
                  loading: loading,
                  onTap: () {
                    if (!loading) {
                      setState(() {
                        dialogBox = false;
                      });
                    }
                  },
                  onNo: () {
                    if (!loading) {
                      setState(() {
                        dialogBox = false;
                      });
                    }
                  },
                  onYes: () async {
                    if (!loading) {
                      setState(() {
                        loading = true;
                      });
                      Future.delayed(Duration(seconds: 5)).then((value) {
                        setState(() {
                          cardList.removeAt(selectedCard);
                          dialogBox = false;
                          loading = false;
                        });
                        debugPrint(cardList.length.toString());
                      });
                    }

                    // try {
                    //   final result =
                    //       await InternetAddress.lookup('example.com');
                    //   if (result.isNotEmpty &&
                    //       result[0].rawAddress.isNotEmpty) {
                    //     processAppointment(contexts);
                    //   }
                    // } on SocketException catch (_) {
                    //   showDialogBoxTwo(
                    //     context,
                    //     "assets/error_icon.svg",
                    //     "Failed!",
                    //     "Error occurred while trying proceed the payment",
                    //     [
                    //       [
                    //         "Try Again",
                    //         Colors.white,
                    //         Color(0xFFE74646),
                    //         Color(0xFFE74646),
                    //         () {
                    //           Navigator.of(context).pop();
                    //         },
                    //       ],
                    //     ],
                    //   );
                    // }
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
