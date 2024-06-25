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
      let body = "Segera periksa kondisi kolam anda";

      // Check for abnormal conditions and set notification title and body
      if (sensorType === "ph" && (sensorValue < 5 || sensorValue > 11)) {
        title = "Kondisi pH abnormal";
      } else if (sensorType === "Amonia" && sensorValue > 0.2) {
        title = "Kondisi Amonia abnormal";
      } else if (sensorType === "Tds" && (sensorValue < 100 || sensorValue > 500)) {
        title = "Kondisi TDS abnormal";
        body = "Pompa air diaktifkan secara otomatis";
      } else if (sensorType === "Suhu" && (sensorValue < 20 || sensorValue > 28)) {
        title = "Kondisi Suhu abnormal";
        if (sensorValue < 20) {
          body = "Heater diaktifkan secara otomatis";
        } else if (sensorValue > 28) {
          body = "Chiller diaktifkan secara otomatis";
        }
      } else if (sensorType === "turbidity" && (sensorValue < 5 || sensorValue > 37)) {
        title = "Kondisi Turbidity abnormal";
      }

      if (title) {
        const tokenSnapshot = await admin.database().ref(`/UsersData/${userId}/fcmToken`).once("value");
        const token = tokenSnapshot.val();

        if (token) {
          const message = {
            token: token,
            notification: {
              title: title,
              body: body, // Use the updated body message
            },
            data: {
              click_action: "FLUTTER_NOTIFICATION_CLICK",
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