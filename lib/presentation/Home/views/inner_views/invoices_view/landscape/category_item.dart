import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helper/app_colors.dart';
import '../../../../../../core/widgets/text_builder.dart';

class CategoryItem {
  final String id;
  final String name;

  CategoryItem({required this.id, required this.name});
}
class SearchOnCategorySection extends StatefulWidget {
  final String labelText;

  const SearchOnCategorySection({Key? key, required this.labelText}) : super(key: key);

  @override
  _SearchOnCategorySectionState createState() => _SearchOnCategorySectionState();
}

class _SearchOnCategorySectionState extends State<SearchOnCategorySection> {
  TextEditingController myController = TextEditingController();
  var categoryKey = GlobalKey<DropdownSearchState>();

  // Define static data
  final List<CategoryItem> categories = [
    CategoryItem(id: '1', name: 'Print'),
    CategoryItem(id: '2', name: 'Pencil'),
    CategoryItem(id: '3', name: 'Papers'),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<CategoryItem>(
      key: categoryKey,
      items: categories,
      itemAsString: (CategoryItem category) => category.name,
      popupProps: const PopupProps.menu(
        showSearchBox: true,
      ),
      dropdownButtonProps: const DropdownButtonProps(
        color: AppColors.primaryColorBlue,
      ),
      validator: (value) {
        if (value == null) {
          return "Please select a category";
        }
        return null;
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        textAlign: TextAlign.center,
        baseStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 9.sp,
          fontWeight: FontWeight.bold,
        ),
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          label: TextBuilder(widget.labelText, fontSize: 11),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onChanged: (CategoryItem? data) {

      },
    );
  }
}
