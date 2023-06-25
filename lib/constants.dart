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
  'Nov',
  'Dec'
];

enum CategoryType { income, expense, investment }

extension CategoryTypeExt on CategoryType {
  String asString() {
    if (this == CategoryType.income) return 'Income';
    if (this == CategoryType.expense) return 'Expense';
    if (this == CategoryType.investment) return 'Investment';
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
    }
    return CategoryType.expense;
  }
}
