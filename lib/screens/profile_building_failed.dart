import 'package:finandy/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

class ProfileBuildingFailure extends StatefulWidget {
  const ProfileBuildingFailure({ Key? key }) : super(key: key);

  @override
  _ProfileBuildingFailureState createState() => _ProfileBuildingFailureState();
}

class _ProfileBuildingFailureState extends State<ProfileBuildingFailure> {
   late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late SvgPicture bg;
  final _formKey = GlobalKey<FormState>();
  bool checkValue = false;
  var _ticketNo;
  TextEditingController goldenTicketController = TextEditingController();
  @override
  void initState() {
    super.initState();
    bg = SvgPicture.asset("assets/images/scardbg.svg");
     _controller = VideoPlayerController.network(
      'https://assets.mixkit.co/videos/preview/mixkit-going-down-a-curved-highway-down-a-mountain-41576-large.mp4',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precachePicture(bg.pictureProvider, context);
  }
  
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                const Text(
                      sorryTxt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff141414),
                        fontSize: 32,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                      )), 
                const SizedBox(height: 7,),      
                const Text(
                        sorryDes,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),  
                const SizedBox(height: 10,),
                FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  const ClosedCaption(text: null), 
                  // Here you can also add Overlay capacities
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: EdgeInsets.all(3),
                    colors: VideoProgressColors(
                        playedColor: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
                const SizedBox(height: 7,),
                const Text(
                        askOthers,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87
                        ),
                      ),  
                const SizedBox(height: 7,),
                const Text(
                        enterTicketNo,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87
                        ),
                      ),  
               const SizedBox(height: 45,),
               Form(
                 key: _formKey,
                 child: TextFormField(
                   controller: goldenTicketController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    enabled: true,
                    maxLength: 4,
                    validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                    decoration: const InputDecoration(
                      hintText: "Enter",
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      labelText: "Golden Ticket",   
                      enabled: true, 
                    ),
                 )),
                  ElevatedButton(
                   onPressed: () async{
                     if(_formKey.currentState!.validate() && checkValue == true){
                       _formKey.currentState!.save();
                          
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const OTPverify(fromPage: "signin",)));
                     }else {
                       return;
                     }
                   },
                  style: ElevatedButton.styleFrom(
                    primary: checkValue ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.65),
                    alignment: Alignment.bottomCenter,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   ),
                   child: const  Padding(
                   padding: EdgeInsets.all(10.0),
                   child: Text(submit, style: TextStyle(fontSize: 18),),
                   ) 
                     )
            ],
            ),
        ),
      ),
    );
  }
}