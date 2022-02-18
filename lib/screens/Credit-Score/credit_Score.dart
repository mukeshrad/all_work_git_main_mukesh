import 'package:flutter/material.dart';

import '../../utils/appBar.dart';

class CreditScore extends StatefulWidget {
  const CreditScore({Key? key}) : super(key: key);

  @override
  _CreditScoreState createState() => _CreditScoreState();
}

class _CreditScoreState extends State<CreditScore> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 16.0,
              ),
              child: NewAppBar(pageName: 'Credit Score'),
            ),
            Expanded(
                child: ListView(
              children: [
                buildCreditScoreCard(
                  upOrDown: 'Up',
                  asset: 'assets/images/transscore.png',
                  score: '777',
                  sinceLastMonthDownOrUpValue: '130',
                  doingHow: 'Doing Great',
                  sliderValue: 0.75,
                  doingHowColor: const Color(0xff77B255),
                  onDownload: () {},
                ),
                const SizedBox(
                  height: 16.0,
                ),
                buildCreditScoreCard(
                  upOrDown: 'Down',
                  asset: 'assets/images/equifaxscore.png',
                  score: '760',
                  sinceLastMonthDownOrUpValue: '130',
                  doingHow: 'Not Bad',
                  sliderValue: 0.3,
                  doingHowColor: const Color(0xffC73140),
                  onDownload: () {},
                ),
                const SizedBox(
                  height: 16.0,
                ),
                buildCreditScoreCard(
                  upOrDown: 'Down',
                  asset: 'assets/images/experianscore.png',
                  score: '770',
                  sinceLastMonthDownOrUpValue: '130',
                  doingHow: 'Good',
                  sliderValue: 0.5,
                  doingHowColor: const Color(0xffF4900C),
                  onDownload: () {print('asdf');},
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Padding buildCreditScoreCard(
      {required String asset,
      required String score,
      required String doingHow,
      required String sinceLastMonthDownOrUpValue,
      required String upOrDown,
      required double sliderValue,
      required Color doingHowColor,
      required VoidCallback onDownload}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          // vertical: 16.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0.0, 5.0),
              blurRadius: 30.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  asset,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    score,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 50.0,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onDownload,
                  icon: const Icon(
                    Icons.download_outlined,
                    color: Color(0xff66757F),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              decoration: BoxDecoration(
                  color: doingHowColor,
                  borderRadius: BorderRadius.circular(30.0)),
              padding: const EdgeInsets.symmetric(
                horizontal: 21.0,
                vertical: 8.0,
              ),
              child: Text(
                doingHow,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Slider(
              value: sliderValue,
              onChanged: (v) {},
              activeColor: doingHowColor,
            ),
            ListTile(
              leading: const Text(
                '300',
                style: TextStyle(
                  color: Color(0xff323232),
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              title: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: upOrDown == 'Down' ? '↙ ' : '↑',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '$upOrDown $sinceLastMonthDownOrUpValue points since last month',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: const Text(
                '850',
                style: TextStyle(
                  color: Color(0xff323232),
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
