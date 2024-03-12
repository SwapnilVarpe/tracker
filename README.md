# Tracker
Tracker for money and time


# Components
- Create basic slider component for dates and month slider.

## Todo:
-   Issues:
-   Money stats
-   Schedule >> Time slots
        Show task info on card
            Cat,sub cat, title, move to actual, mark as done, Exp. diff and pleasure and actual, duration.
        On move to actual, copy task to actual.

        Different colors for planned and actual?
        Remove title as mandatory?

        Change new time entry page to take id and hour.

        ** Test with old db version 1.
        Export/Import activities.

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
