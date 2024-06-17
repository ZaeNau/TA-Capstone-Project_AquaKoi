/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotificationOnSensorChange = functions.database
  .ref("/UsersData/{userId}/Sensors/{sensorType}")
  .onUpdate(async (change, context) => {
    try {
      const sensorType = context.params.sensorType;
      const userId = context.params.userId;
      const sensorValue = change.after.val();

      let title = "";
      if (sensorType === "ph" && (sensorValue < 5 || sensorValue > 8)) {
        title = "Kondisi pH abnormal";
      } else if (sensorType === "Amonia" && sensorValue > 0.2) {
        title = "Kondisi Amonia abnormal";
      } else if (sensorType === "Tds" && (sensorValue < 100 || sensorValue > 500)) {
        title = "Kondisi TDS abnormal";
      } else if (sensorType === "Suhu" && (sensorValue < 20 || sensorValue > 28)) {
        title = "Kondisi Suhu abnormal";
      } 
      // else if (sensorType === "turbidity" && (sensorValue < 5 || sensorValue > 37)) {
      //   title = "Kondisi Turbidity abnormal";
      // }

      if (title) {
        const tokenSnapshot = await admin.database().ref(`/UsersData/${userId}/fcmToken`).once("value");
        const token = tokenSnapshot.val();

        if (token) {
          const message = {
            token: token,
            notification: {
              title: title,
              body: "Segera periksa kondisi kolam anda",
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
              screen: "dashboardScreen",
            },
          };
          await admin.messaging().send(message);
          console.log("Notification sent successfully:", message);
        } else {
          console.log("No FCM token found for user:", userId);
        }
      }
    } catch (error) {
      console.error("Error in sendNotificationOnSensorChange:", error);
    }
  });

