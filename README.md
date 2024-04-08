# Tracker
Tracker for money and time

# Components
    DB on macos: "/Users/swapnilvarpe/Library/Containers/com.apps.swapnilvarpe.tracker/Data/Documents/tracker.db"

## Todo:
-   Issues:
-   Schedule >> Time slots
        Different colors for planned and actual?
        Planned task: notification and recurring.
        Delete cat check, check if activity exists
        Export all db.
        Go to current time button.


-   Time stats
    Date range picker.
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
