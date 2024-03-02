# Tracker
Tracker for money and time


# Components
- Create basic slider component for dates and month slider.

## Todo:
-   Issues:
-   Money stats
-   Schedule >> Time slots
        Support for adding multiple tasks in one hour.
        Show task info on card
            Cat,sub cat, title, move to actual, mark as done, Exp. diff and pleasure and actual, duration.
        On move to actual, copy task to actual.
        Add mark as done field in activity.

        Chane cat component to take activity as input and corr. modification.
        DB changes for activity table (insert, edit etc.)

        -   Add Predicted difficulty and satisfaction level and corr. actual levels
        -   Cat and sub cats
        -   Needs to be simple, need not be min to min recording but overall hourly record.

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
