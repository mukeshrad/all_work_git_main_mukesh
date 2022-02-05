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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: const Color(0xffF3F3F3),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 15.0,
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
                  const Divider(
                    thickness: 1,
                  ),
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
                            width: 6.0,
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
                            width: 6.0,
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
                            width: 6.0,
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
                            width: 6.0,
                          ),
                          Text(
                            creditScoreStatus,
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
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                    onTap: onTapShare,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.share),
                        SizedBox(
                          width: 14.5,
                        ),
                        Text(
                          'Share Golden Ticket',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
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
