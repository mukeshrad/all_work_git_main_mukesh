import 'package:flutter/material.dart';

class SharedCard extends StatelessWidget {
  final String profilePhoto;
  final String personName;
  final String validDate;
  final String phoneNo;
  final String refferedOnDate;
  final String ticketStatus;
  final String creditScoreStatus;
  final VoidCallback onTapShare;
  final Color colorOfCreditScoreStatus;
  const SharedCard({
    Key? key,
    required this.creditScoreStatus,
    required this.personName,
    required this.phoneNo,
    required this.profilePhoto,
    required this.refferedOnDate,
    required this.ticketStatus,
    required this.validDate,
    required this.onTapShare,
    required this.colorOfCreditScoreStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
        color: const Color(0xffFFFFFF),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 15.0,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
              ),
              title: Text(
                personName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Valid Till',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5C5C5C),
                    ),
                  ),
                  Text(
                    validDate,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const MySeparator(color: Color(0xff084E6C)),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mobile',
                            style: TextStyle(
                                fontSize: 14.0, color: Color(0xff5C5C5C)),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            phoneNo,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 47.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Reffered On',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff5C5C5C),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            refferedOnDate,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 17.0,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ticket Status',
                            style: TextStyle(
                                fontSize: 14.0, color: Color(0xff5C5C5C)),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            ticketStatus,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 44.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Credit Score Status',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff5C5C5C),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            creditScoreStatus,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: colorOfCreditScoreStatus,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 17.0,
                  ),
                  const MySeparator(color: Color(0xff084E6C)),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: onTapShare,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.share,
                          color: Color(0xff0D406A),
                        ),
                        SizedBox(
                          height: 14.5,
                        ),
                        Text(
                          'Share Golden Ticket',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff0D406A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 2.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
