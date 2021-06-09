const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

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

exports.onSenderPosts = functions.firestore.document('notifications/{id}').onCreate(
    async (snapshot) => {
        const newValue = snapshot.data();
        const payload = admin.messaging.MessaginPayload = {
            notification: {
                title: 'New food notification',
                body: `${newValue.Email} has posted a food availability of ${newValue.NumOfMeals} Meals`,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            },
            data: {
                type: 'New Food'
            }
        }
        return fcm.sendToTopic('Receivers',payload);
    }
)

exports.onReceiverAccepts = functions.firestore.document('orders/{id}').onCreate(
    async (snapshot) => {
        const newValue = snapshot.data();
        const userdata = await db.collection('users').doc(newValue.donorId).get();
        const payload = admin.messaging.MessaginPayload = {
            notification: {
                title: 'New Receiver found',
                body: `${userdata.Email} is ready to receive your food`,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            },
            data: {
                type: 'New Receiver'
            }
        }
        return fcm.sendToDevice(userdata.fcm_token,payload);
    }
)

// const id = context.params.id;
        // const notification = admin.firestore().collection('notification').doc(id);
        // notification.get().then((doc) => {
        //     const donorId = doc.data().userId;
        // })

// const userId = newValue.userId;
//         var receiver = newValue.receiver;
//         if(receiver == true){
//             //use fcm token of this user(donor) to notify him about the receiver
//         }