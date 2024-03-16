# Tracker
Tracker for money and time


# Components
- Create basic slider component for dates and month slider.

## Todo:
-   Issues:
-   Money stats
-   Schedule >> Time slots
        Show task info on card

        Different colors for planned and actual?

        Import activities.

    Testing:
        ** Test with old db version 1.
        Import/Export entries and acts.
        Check if old enties are good.


-   Time stats
    -   Total time worked/utilized.
    -   Most satisfying tasks.
        Time spend by category.
-   Options:
    -   Settings provider, for number formatter and global setting.

Refactoring:
    Move models to freezed.
    ** Use new slider component for month selector in exp and stats page.

Improv:

To publish, what needs to be done:
    Build command:
        flutter clean
        flutter build apk --split-per-abi
    Gen freezed models: flutter pub run build_runner build --delete-conflicting-outputs
Logo icon color: #7959b7
