import 'package:finandy/constants/textFields.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> imageList = [
    'assets/images/1_Star_Emoji.svg',
    'assets/images/2_Star_Emoji.svg',
    'assets/images/3_Star_Emoji.svg',
    'assets/images/4_Star_Emoji.svg',
    'assets/images/5_Star_Emoji.svg',
  ];
  String image = '';

  open() async {
    print('asdf');
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
      inAppReview.openStoreListing(appStoreId: '...', microsoftStoreId: '...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const NewAppBar(
                      pageName: 'Rate and Review',
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    buildInititalText(),
                    const SizedBox(
                      height: 42.0,
                    ),
                    buildRatingContainer(),
                    const SizedBox(
                      height: 28.0,
                    ),
                    const Text(
                      'Feedback',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    feedBackTextField(context)
                  ],
                ),
              ),
              UsedButton(
                buttonName: const Center(
                  child: Text(
                    'Submit',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
                  ),
                ),
                onpressed: () {
                  open();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Center buildInititalText() {
    return Center(
      child: Column(
        children: const [
          Text(
            'Are you Happy with our',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
          Text(
            'Services?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  Container feedBackTextField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 16.0,
      ),
      height: 118.0,
      decoration: BoxDecoration(
        // color: Colors.blueGrey,
        border: Border.all(color: const Color(0xff7B8497).withOpacity(0.15)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        maxLines: 6,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 15.0),
        controller: _controller,
        cursorColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black12,
        decoration: kfeedbackFieldDecoration,
      ),
    );
  }

  Container buildRatingContainer() {
    return Container(
        // height: 230.0,
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xff7B8497).withOpacity(0.15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image == ''
                ? Container()
                : SvgPicture.asset(
                    image,
                    height: 80.0,
                  ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: SimpleStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: 0,
                size: 32,
                isReadOnly: false,
                // allowEditing: true,
                onRated: (rate) {
                  setState(() {
                    if (rate! <= 1) {
                      image = imageList[0];
                    } else if (rate <= 2 && rate >= 1) {
                      image = imageList[1];
                    } else if (rate <= 3 && rate >= 2) {
                      image = imageList[2];
                    } else if (rate <= 4 && rate >= 3) {
                      image = imageList[3];
                    } else if (rate <= 5 && rate >= 4) {
                      image = imageList[4];
                    }
                  });
                },
                spacing: 20,
              ),
            ),
          ],
        )

        // show the dialog
        );
  }
}
