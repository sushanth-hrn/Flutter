const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.onReceiverAccepts = functions.https.onCall(
    (data,context) => {
        var id = data.id;
        functions.firestore.document('/notifications/id').onUpdate((snap,context) => {
            if(snap.data().receiver == true) {
                //notify user about the receiver
            }
        })
    }
)