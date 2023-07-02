import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/category.dart';
import 'package:tracker/providers/category_provider.dart';
import 'constants.dart';

class AddCategory extends ConsumerStatefulWidget {
  const AddCategory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCategoryState();
}

class _AddCategoryState extends ConsumerState<AddCategory> {
  final categoryController = TextEditingController();
  final subCatController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    subCatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = categoryStateProvider('');
    var categoryState = ref.watch(categoryProvider);
    var categoryType = categoryState.categoryType;
    var catList = categoryState.categoryList();
    var currentCategory = categoryState.selectedCategory;
    var subCatList = categoryState.subCategoryList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(text: 'Category'),
            Tab(
              text: 'Sub Category',
            )
          ]),
        ),
        body: TabBarView(children: [
          Column(
            children: [
              buildCatChip(categoryType, categoryProvider),
              inputTextField('Add new category', categoryController, () async {
                var cat = categoryController.text;

                if (cat.isNotEmpty) {
                  var num = await DBHelper.insertCategory(Category(
                      category: cat,
                      categoryType: categoryType,
                      subCategory: ''));

                  if (num > 0 && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Category added')));
                    categoryController.text = '';
                    ref.read(categoryProvider.notifier).reload();
                  }
                }
              }),
              Expanded(
                child: ListView(
                  children: catList
                      .map((cat) => Card(
                              child: ListTile(
                            title: Text(cat.category),
                            trailing: PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: const Text('Delete'),
                                  onTap: () async {
                                    int num = await DBHelper.deleteCategory(
                                        categoryType, cat.category);

                                    if (context.mounted) {
                                      if (num > 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Category deleted')));
                                        ref
                                            .read(categoryProvider.notifier)
                                            .reload();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Cannot delete category')));
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          )))
                      .toList(),
                ),
              )
            ],
          ),
          Column(
            children: [
              buildCatChip(categoryType, categoryProvider),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                      value: currentCategory,
                      items: catList.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.category,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(e.category),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        ref.read(categoryProvider.notifier).selectedCategory =
                            value!;
                      })),
              inputTextField('Add new sub category', subCatController,
                  () async {
                var subCat = subCatController.text;
                if (subCat.isNotEmpty) {
                  var num = await DBHelper.insertCategory(Category(
                      category: currentCategory,
                      categoryType: categoryType,
                      subCategory: subCat));

                  if (num > 0 && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sub Category added')));
                    subCatController.text = '';
                    ref.read(categoryProvider.notifier).reload();
                  }
                }
              }),
              Expanded(
                  child: ListView(
                children: subCatList
                    .map((cat) => Card(
                            child: ListTile(
                          title: Text(cat),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text('Delete'),
                                onTap: () async {
                                  int num = await DBHelper.deleteSubCategory(
                                      categoryType, currentCategory, cat);

                                  if (context.mounted) {
                                    if (num > 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Sub Category deleted')));
                                      ref
                                          .read(categoryProvider.notifier)
                                          .reload();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Cannot delete sub category')));
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                        )))
                    .toList(),
              ))
            ],
          )
        ]),
      ),
    );
  }

  Padding inputTextField(
      String label, TextEditingController controller, onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: label),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter text' : null,
            ),
          ),
          ElevatedButton(onPressed: onPressed, child: const Text('Add'))
        ],
      ),
    );
  }

  Padding buildCatChip(CategoryType categoryType,
      StateNotifierProvider<CategoryNotifier, CategoryState> categoryProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilterChip(
              label: Text(CategoryType.expense.asString()),
              selected: categoryType == CategoryType.expense,
              showCheckmark: false,
              onSelected: (onSelected) => ref
                  .read(categoryProvider.notifier)
                  .categoryType = CategoryType.expense),
          FilterChip(
              label: Text(CategoryType.income.asString()),
              selected: categoryType == CategoryType.income,
              showCheckmark: false,
              onSelected: (onSelected) => ref
                  .read(categoryProvider.notifier)
                  .categoryType = CategoryType.income),
          FilterChip(
              label: Text(CategoryType.investment.asString()),
              showCheckmark: false,
              selected: categoryType == CategoryType.investment,
              onSelected: (onSelected) => ref
                  .read(categoryProvider.notifier)
                  .categoryType = CategoryType.investment),
        ],
      ),
    );
  }
}
