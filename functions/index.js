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
const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp(functions.config().firebase);
const db = admin.database();
const ref = db.ref('/chungcu/dulieudoc');

exports.monitorGas = functions.database.ref('/chungcu/dulieudoc/gas')
    .onUpdate((change, context) => {
        const newValue = change.after.val();

        // Kiểm tra giá trị mới của "gas"
        if (newValue === 1) {
            // Gửi thông báo phát hiện lửa
            const message = {
                data: {
                    title: 'Phát hiện lửa',
                    body: 'Cảnh báo: Phát hiện lửa!',
                },
                topic: 'fire_alert_topic', // Đổi thành topic bạn muốn
            };

            return admin.messaging().send(message);
        } else if (newValue !== 0) {
            // Gửi thông báo phát hiện khí gas
            const message = {
                data: {
                    title: 'Phát hiện khí gas',
                    body: 'Cảnh báo: Phát hiện khí gas!',
                },
                topic: 'gas_alert_topic', // Đổi thành topic bạn muốn
            };

            return admin.messaging().send(message);
        }

        // Trường hợp khác, không gửi thông báo
        return null;
    });
