const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.myFunction = functions.firestore
  .document('notifications/{docId}')
  .onCreate((snapshot, context) => {
  const receiver = snapshot.data().receiver;
  const token = snapshot.data().token;

  const payload = {
      notification: {
          title: "cloud function demo",
          body: "test",
      },
      data: {
          body: "test",
      },
  };

  admin.messaging().sendToDevice(token, payload);
});