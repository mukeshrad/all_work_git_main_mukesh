import 'package:finandy/constants/textFields.dart';
import 'package:finandy/utils/appBar.dart';
import 'package:finandy/utils/usedButton.dart';
import 'package:flutter/material.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final TextEditingController _controller = TextEditingController();

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
              buttonName: 'Submit',
              onpressed: () {},
            )
          ],
        ),
      ),
    ));
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
        height: 230.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xff7B8497).withOpacity(0.15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SimpleStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: 0,
                size: 32,
                isReadOnly: false,
                // allowEditing: true,
                onRated: (rate) {
                  print(rate);
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
