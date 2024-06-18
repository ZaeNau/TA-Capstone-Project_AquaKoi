# AquaKoi

AquaKoi is an IoT-based system designed for monitoring and controlling the water quality in koi fish cultivation. The system provides real-time access to water parameters via a mobile application built with Flutter and Firebase, featuring automatic control mechanisms for optimal water conditions.

## Features

- **Real-Time Monitoring**: Track temperature, pH, ammonia levels, dissolved oxygen, and turbidity.
- **Automatic Control**: Automated actuators for maintaining water quality.
- **Notifications**: Receive alerts for abnormal water parameters.
- **Predictive Analysis**: Machine learning integration for predictive insights.
- **User-Friendly Interface**: Manage settings and view data through a responsive mobile app.

## Technologies Used

- **Hardware**: ESP32, Arduino
- **Software**: Flutter, Firebase Realtime Database, Firebase Cloud Messaging
- **Sensors**: Temperature sensor, pH sensor, TDS sensor, Ammonia sensor, Turbidity sensor

## Getting Started

### Prerequisites

- Flutter SDK
- Firebase account
- Arduino IDE

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/ZaeNau/TA-Capstone-Project_AquaKoi.git
   ```
2. Navigate to the project directory:
   ```sh
   cd TA-Capstone-Project_AquaKoi/AquaKoi_main
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Set up Firebase:
   - Add your Firebase project configuration in `firebase_options.dart`.

### Running the App

1. Connect your development device.
2. Run the app:
   ```sh
   flutter run
   ```

## Configuration

- **WiFi Credentials**: Update the SSID and password in your ESP32 code.
- **Firebase Realtime Database URL**: Ensure your database URL is correctly set in the Flutter app and ESP32 firmware.

## Contribution
- **Muhammad Naufal Nur Irawan** - [Profile](https://github.com/ZaeNau)
- **Ali Hanafi Ahmad** - [Profile](https://github.com/hanafi0808)
- **Naili Ikrimah M.Yanis** - [Profile](https://github.com/naailiik)


## License
-

## Contact

- **Muhammad Naufal Nur Irawan** - [Profile](https://github.com/ZaeNau)
- **Project Repository** - [AquaKoi](https://github.com/ZaeNau/TA-Capstone-Project_AquaKoi)
```
