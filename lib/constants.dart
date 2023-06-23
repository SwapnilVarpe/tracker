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

extension ToString on CategoryType {
  String asString() {
    if (this == CategoryType.income) return 'Income';
    if (this == CategoryType.expense) return 'Expense';
    if (this == CategoryType.investment) return 'Investment';
    return "";
  }
}
