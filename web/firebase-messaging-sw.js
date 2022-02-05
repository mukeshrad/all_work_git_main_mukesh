importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
      apiKey: "AIzaSyAs9KJ4_Ems-ES0Lvjs6Po0aSr20UApSsU",
      authDomain: "resilientcreditcard.firebaseapp.com",
      projectId: "resilientcreditcard",
      storageBucket: "resilientcreditcard.appspot.com",
      messagingSenderId: "947980620617",
      appId: "1:947980620617:web:77f74648ac0c421980c098",
      measurementId: "G-SKLPQ7FKDS"
    };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });

