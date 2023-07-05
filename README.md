# tracker
Tracker for money and time

## Todo:
-   Expneses
-   Cat/Sub cat
-   Money stats
        Feature: View by excluding some entries (so to negate large amounts in perticular month).
        Design:
            Date range: Month selector and range selector
            Summary of income, exp and investement.
            Cat type selector
            Filters:
                Pie of categories, or list cat.
                Pie of sub cats if exists.
                List of items
-   Schedule >> Time slots
    -   Time card from morning to night.
    -   Should be able to add what I did in given half hour or an hour.
    -   Can add schedule if I want.
-   Time stats
    -   Total time wasted/not counted.
        Time spend by category.
-   Options:
    -   Import data into db.
    -   Dont show salary option.
    -   Unlock using fingerprint.


Issues:
- Scroll issue: https://stackoverflow.com/questions/49153087/flutter-scrolling-to-a-widget-in-listview
https://pub.dev/packages/scrollable_positioned_list
- In add/edit catogory, if added new or deleted cat, cat gets reset to first one.


