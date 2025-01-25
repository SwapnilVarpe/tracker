# Tracker
Tracker flutter app for tracking money and time. There are many apps to track daily expenses, but I wanted to create app which I will use daily. Check it out and use it if find useful.

# Screenshots
<img src="./screenshots/Screenshot%202025-01-23%20at%208.08.22%20PM.png" width=300 > <img src="./screenshots/Screenshot%202025-01-23%20at%208.08.50%20PM.png" width=300>
<img src="./screenshots/Screenshot%202025-01-23%20at%208.09.53%20PM.png" width=300> <img src="./screenshots/Screenshot%202025-01-23%20at%208.11.29%20PM.png" width=300>
<img src="./screenshots/Screenshot%202025-01-23%20at%208.12.24%20PM.png" width=300> <img src="./screenshots/Screenshot%202025-01-23%20at%208.12.34%20PM.png" width=300>

# Build
## Command to build release apk
```
flutter clean
flutter build apk --split-per-abi
```
## Generate freezed (code generator for data classes) models
```
flutter pub run build_runner build --delete-conflicting-outputs
```
