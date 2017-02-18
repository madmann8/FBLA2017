# Yard Sale

## What does it do?
Yard Sale is an iOS app designed for quick and easy browsing and submission of items in order to raise money for students to attend the FBLA NLC. 

## Visuals
The app is designed for simplicity, and easy uploading and viewing of donations. Instead of a being search based application, the app relies on the user walking/swiping around the "Yard Sale" in order to find what is ideal for them. 


## Screen Shots
### Login
![img_1104](https://cloud.githubusercontent.com/assets/17242119/23090057/86f9f8aa-f562-11e6-9002-2eec11871dfd.PNG)

### Home
![img_1105](https://cloud.githubusercontent.com/assets/17242119/23090058/92f11c10-f562-11e6-9bb8-d360328eea1f.PNG)

### About FBLA
![img_1106](https://cloud.githubusercontent.com/assets/17242119/23090060/9ba09fac-f562-11e6-8a48-e3cdf13e5bad.PNG)

### Uploading a product
![img_1108](https://cloud.githubusercontent.com/assets/17242119/23090063/aa4e826c-f562-11e6-9802-b9737c36bf95.PNG)

### Browsing Products
![simulator screen shot feb 17 2017 10 38 30 pm](https://cloud.githubusercontent.com/assets/17242119/23090069/bb1b4274-f562-11e6-93fd-a7d41ef09e73.png)
![simulator screen shot feb 17 2017 10 38 33 pm](https://cloud.githubusercontent.com/assets/17242119/23090068/bb1a33b6-f562-11e6-8919-b94caf98d84c.png)



## Requirements

- iOS 10.2+
- Swift 3.0

## Installation

This project is reliant on **[CocoaPods](https://cocoapods.org/)** for external libraries. 

Once Cocoa Pods are installed, simply run "Pod update" in the root folder of the project.

In order to run the app, open YardSale.xcworkspace, select a simulator (iPhone 7 plus is ideal),and press the run button. 

## Backend

The app uses **[Firebase](https://firebase.google.com/)**

Unfortunately, due to unforeseen issues, while data could be pushed to Firebase, there was difficulty in pulling it from Firebase. Due to this, the browse section of the app is not packaged in the February 17 version of the app. However, an example of the browse section is seen above (made with dummy data).
