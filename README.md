# SmokeFreeHero

**Author:** [Yuqi Hu](https://www.linkedin.com/in/yuqihu1103/)

**Project Objectives:**

The SmokeFreeHero is an iOS app dedicated to supporting quitting smoke. It provides functionalities such as tracking users’ smoke-free time, calculating associated financial and health benefits, and engaging in a community forum for mutual support and discussion with fellow smoke-quitters. Users will be created and authenticated with Firebase Authentication for security of personal information. Users record the number of cigarettes (or equivalent) and the amount of money they spend on smoking every day. Then, user can simply tap start when they quit smoking. The app will record how long they have been smoke-free, how many cigarettes are not smoked and how much money were saved. They can also share their thoughts and feelings with other users on the built-in forum.

**Technologies:**

Swift, Firebase (Firebase Authentication, Firestore Database, and Firebase Storage)

## Demo

**Project Demo Video:** https://youtu.be/hxtXTSutDzY

**Overview (gif)**

![smokefreehero](https://github.com/yuqihu1103/SmokeFreeHero/assets/133090163/6e299cb0-d096-480b-a4e6-2baaa00b252b)

## Instructions to Build and Use

### Requirements
You need to have a Google Firebase account for all functionalites to work.

### Installation

1. Clone or download the repository.
2. Open Terminal and navigate to the project directory.
3. Install CocoaPods (if not already installed) by running:
```
sudo gem install cocoapods
```
4. Install the project dependencies by running
```
pod install
```
5. Open the `SmokeFreeLife.xcworkspace` file in Xcode.

### Usage

1. Go to the Firebase Console and create a new project.
2. Add your iOS app to the Firebase project and download the `GoogleService-Info.plist` file.
3. Add the `GoogleService-Info.plist` file to your Xcode project.
4. Build and run your app in Xcode to test Firebase integration.

## Project Design

Design document can be found in the [docs](docs) folder, including information on:

1. Introduction - Aims and Planned Features, Target Audience and Product Niche
2. Draft Design - Screen-by-screen Sketch Up
3. Design of Screen-to-screen Flow
4. Backend Design - User Authentication and Database
5. Use of Sensors

## Others

**Acknowledgement:** Thanks to Zican Hao and Shichuan Xuan for assistance in developing the threads section.

**License:** This project is licensed under the MIT License - see the [LICENSE](LICENSE) for details.
