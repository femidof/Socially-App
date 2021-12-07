const admin = require('firebase-admin')
const functions = require("firebase-functions");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
 

// Show message Delivered
exports.changeMessageStatus = functions.firestore
  .document('rooms/{roomId}/messages/{messageId}')
  .onWrite((change) => {
    const message = change.after.data()
    if (message) {
      if (['delivered', 'seen', 'sent'].includes(message.status)) {
        return null
      } else {
        return change.after.ref.update({
          status: 'delivered',
        })
      }
    } else {
      return null
    }
  })


// SHow last Messages

admin.initializeApp()

const db = admin.firestore()

exports.changeLastMessage = functions.firestore
  .document('rooms/{roomId}/messages/{messageId}')
  .onUpdate((change, context) => {
    const message = change.after.data()
    if (message) {
      return db.doc('rooms/' + context.params.roomId).update({
        lastMessages: [message],
      })
    } else {
      return null
    }
  })



