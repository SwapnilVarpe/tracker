import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/db/db_helper.dart';
import 'package:tracker/modal/category.dart';

import 'constants.dart';
import 'providers/category_provider.dart';

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
    var categoryType = ref.watch(catTypeProvider);
    var catList = ref.watch(categoryProvider);
    var currentCategory = ref.watch(currentCatProvider);
    var subCatList = ref.watch(subCategoryProvider);

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
              buildCatChip(categoryType),
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

                    ref.invalidate(categoryProvider);
                  }
                }
              }),
              Expanded(
                  child: catList.when(
                      data: (data) => ListView(
                            children: data
                                .where((element) => element.subCategory.isEmpty)
                                .map((cat) => Card(
                                        child: ListTile(
                                      title: Text(cat.category),
                                      trailing: PopupMenuButton(
                                        icon: const Icon(Icons.more_vert),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            child: const Text('Delete'),
                                            onTap: () async {
                                              int num =
                                                  await DBHelper.deleteCategory(
                                                      categoryType,
                                                      cat.category);

                                              if (context.mounted) {
                                                if (num > 0) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Category deleted')));
                                                  ref.invalidate(
                                                      categoryProvider);
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
                      error: (error, stackTrace) => const Text('Error occured'),
                      loading: () => const CircularProgressIndicator()))
            ],
          ),
          Column(
            children: [
              buildCatChip(categoryType),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: catList.when(
                      data: (data) {
                        return DropdownButtonFormField(
                            value: currentCategory,
                            items: data
                                .where((element) => element.subCategory.isEmpty)
                                .map((e) {
                              return DropdownMenuItem<String>(
                                value: e.category,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(e.category),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              ref.read(currentCatProvider.notifier).state =
                                  value!;
                            });
                      },
                      error: (error, stack) => const Text('Some error occured'),
                      loading: () => const CircularProgressIndicator())),
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

                    ref.invalidate(categoryProvider);
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
                                      ref.invalidate(categoryProvider);
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

  Padding buildCatChip(CategoryType categoryType) {
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
                  .read(catTypeProvider.notifier)
                  .state = CategoryType.expense),
          FilterChip(
              label: Text(CategoryType.income.asString()),
              selected: categoryType == CategoryType.income,
              showCheckmark: false,
              onSelected: (onSelected) => ref
                  .read(catTypeProvider.notifier)
                  .state = CategoryType.income),
          FilterChip(
              label: Text(CategoryType.investment.asString()),
              showCheckmark: false,
              selected: categoryType == CategoryType.investment,
              onSelected: (onSelected) => ref
                  .read(catTypeProvider.notifier)
                  .state = CategoryType.investment),
        ],
      ),
    );
  }
}
