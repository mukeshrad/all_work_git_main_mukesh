class Server {
  final String url = 'http://eeda-103-77-43-57.ngrok.io';
  // final String y
  final String contact = 'contact';
  final String sms = 'sms';
  final String appsInfo = 'appsInfo';
   
  //  Server(){}

  getUri(String eP){
    if(eP == contact){
       return Uri.parse(url+'/captcha/');
    }else if(eP == sms){
       return Uri.parse(url+'/otp/');
     }else if(eP == appsInfo){
       return Uri.parse(url+'/signup/');
     }
    //  else if(eP == login){
    //    return Uri.parse(url+'/login/');
    //  }else if(eP == reqAdd){
    //    return Uri.parse(url+'/request-address/');
    //  }else if(eP == reqAc){
    //    return Uri.parse(url+'/accept/');
    //  }
  }
}