import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/models/category_model.dart';
import 'package:planck/src/widgets/category_dropdown/category_dropdown_controller.dart';
import 'package:provider/provider.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown(this.category, {Key? key}) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final categoryDropdownController =
        Provider.of<CategoryDropdownController>(context);

    return GestureDetector(
      onTap: () {
        if (categoryDropdownController.inAsyncCall) return;
        onTextFieldTap(context, categoryDropdownController);
      },
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormField(
              onSaved: (_) {
                category.id = categoryDropdownController.category.id;
                category.image = categoryDropdownController.category.image;
              },
              validator: (_) {
                if (categoryDropdownController.category.id <= 0) {
                  categoryDropdownController.isCategorySelected = false;
                  return '';
                }
                categoryDropdownController.isCategorySelected = true;
                return null;
              },
              builder: (_) => Row(
                children: [
                  const Icon(Icons.category_outlined, color: kPrimaryColor),
                  const SizedBox(width: kDefaultPadding),
                  Text(categoryDropdownController.dropdown.name),
                  Expanded(child: Container()),
                  const Icon(Icons.content_paste_go, color: kPrimaryColor),
                ],
              ),
            ),
            Visibility(
                visible: !categoryDropdownController.isCategorySelected,
                child: const Divider(color: kErrorColor, thickness: 1.5)),
            Visibility(
              visible: categoryDropdownController.inAsyncCall,
              child: const LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  onTextFieldTap(BuildContext context,
      CategoryDropdownController categoryDropdownController) {
    DropDownState(
      DropDown(
        bottomSheetTitle: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: [
              const Icon(Icons.category_outlined, color: kPrimaryColor),
              const SizedBox(width: kDefaultPadding),
              Text(S.of(context).tCategories,
                  style: const TextStyle(fontSize: 17))
            ],
          ),
        ), 
        data: categoryDropdownController.categoryItems,
        selectedItems: (List<dynamic> selectedList) async {
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              await categoryDropdownController.setDropdown(item);
            }
          }
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }
}
