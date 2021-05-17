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

// exports.onReceiverAccepts = functions.https.onCall(
//     (data,context) => {
//         var id = data.id;
//         functions.firestore.document('/notifications/id').onUpdate((snap,context) => {
//             if(snap.data().receiver == true) {
//                 //notify user about the receiver
//             }
//         })
//     }
// )

exports.onReceiverAccepts = functions.firestore.document('notifications/{id}').onUpdate(
    (change,context) => {
        // const id = context.params.id;
        // const notification = admin.firestore().collection('notification').doc(id);
        // notification.get().then((doc) => {
        //     const donorId = doc.data().userId;
        // })
        const newValue = change.after.data();
        const userId = newValue.userId;
        var receiver = newValue.receiver;
        if(receiver == true){
            //use fcm token of this user(donor) to notify him about the receiver
        }
    }
)