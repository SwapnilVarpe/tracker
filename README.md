# Tracker
Tracker flutter app for tracking money and time. There are many apps to track daily expenses, but I wanted to create app which I will use daily. Check it out and use it if find useful.

# Screenshots
* Home screen
![Home](./screenshots/Screenshot%202025-01-23%20at%208.08.22%20PM.png)
* Stats
![Stats](./screenshots/Screenshot%202025-01-23%20at%208.08.50%20PM.png)
* Stats 2
![Stats 2](./screenshots/Screenshot%202025-01-23%20at%208.09.53%20PM.png)
* Add new entry
![Entry](./screenshots/Screenshot%202025-01-23%20at%208.11.29%20PM.png)
* Time planner
![Time planner](./screenshots/Screenshot%202025-01-23%20at%208.12.24%20PM.png)
* Time stats
![Time stats](./screenshots/Screenshot%202025-01-23%20at%208.12.34%20PM.png)
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