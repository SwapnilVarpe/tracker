# tracker
Tracker for money and time

## Todo:
-   Issues:
-   Money stats
        Feature: View by excluding some entries (so to negate large amounts in perticular month).
-   Schedule >> Time slots
    -   Time card from morning to night.
    -   Should be able to add what I did in given half hour or an hour.
    -   Can add schedule if I want??
    -   Adding both whole day schudule and what I did.
        -   Three col.: Time, Planned, Actual
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

Improv:

To publish, what needs to be done:
    Build command:
        flutter clean
        flutter build apk --split-per-abi
    Gen freezed models: flutter pub run build_runner build --delete-conflicting-outputs
Logo icon color: #7959b7
