# Tracker
Tracker for money and time

# Components

## Todo:
-   Issues:
-   Schedule >> Time slots
        Different colors for planned and actual?
        Planned task: notification and recurring.
        Delete cat check, check if activity exists
        Short unique id for activity.
        Success msg too long and interfering with day picker.
        Export all db.
        Scroll n-1 time.


-   Time stats
    Three section, by category:
        Time spent
        Planned - Actual
        By satisfaction.

-   Options:
    -   Settings provider, for number formatter and global setting.

Refactoring:
    Move models to freezed.
    ** Use new slider component for month selector in exp and stats page.


## Production build
    To publish, what needs to be done:
        Build command:
            flutter clean
            flutter build apk --split-per-abi
        Gen freezed models: flutter pub run build_runner build --delete-conflicting-outputs
    Logo icon color: #7959b7
