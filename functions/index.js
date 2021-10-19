const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.myFunction = functions.firestore
  .document('notifications/{docId}')
  .onCreate((snapshot, context) => {
  const receiver = snapshot.data().receiver;
  const token = snapshot.data().token;
  const title = snapshot.data().title;
  const body = snapshot.data().body;
  const route = snapshot.data().route;
  const sender = snapshot.data().sender;

  const payload = {
      notification: {
          title: title,
          body: body,
      },
      data: {
          route: route,
          sender: sender,
      },
  };

  admin.messaging().sendToDevice(token, payload);
});