final months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

enum CategoryType { income, expense, investment, activity }

extension CategoryTypeExt on CategoryType {
  String asString() {
    if (this == CategoryType.income) return 'Income';
    if (this == CategoryType.expense) return 'Expense';
    if (this == CategoryType.investment) return 'Investment';
    if (this == CategoryType.activity) return 'Activity';
    return "";
  }

  static CategoryType fromString(String str) {
    switch (str) {
      case 'Income':
        return CategoryType.income;
      case 'Expense':
        return CategoryType.expense;
      case 'Investment':
        return CategoryType.investment;
      case 'Activity':
        return CategoryType.activity;
    }
    return CategoryType.expense;
  }
}
