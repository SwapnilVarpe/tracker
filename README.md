# tracker
Tracker for money and time

## Todo:
-   Issues:
        ** (Is this needed?)Check unique contraints in sub cat and cat
-   Android build.
-   Expneses
-   Money stats
        Feature: View by excluding some entries (so to negate large amounts in perticular month).
-   Schedule >> Time slots
    -   Time card from morning to night.
    -   Should be able to add what I did in given half hour or an hour.
    -   Can add schedule if I want.
-   Time stats
    -   Total time wasted/not counted.
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
