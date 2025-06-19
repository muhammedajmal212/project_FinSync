import 'package:flutter/material.dart';
import 'package:week5/model/category/category_model.dart';

class AppDropDown extends StatefulWidget {
  final String? Function(CategoryModel?)? validatorKey;
  final CategoryModel? selectedValue;
  final void Function(CategoryModel?)? onChanged;
  final List<CategoryModel> dropdownlist;
  const AppDropDown(
      {super.key,
      required this.dropdownlist,
      required this.onChanged,
      required this.selectedValue,
      required this.validatorKey});

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    CategoryModel? selectedcategory;
    if (widget.dropdownlist.isNotEmpty) {
      selectedcategory = widget.dropdownlist.contains(widget.selectedValue)
          ? widget.selectedValue
          : (widget.dropdownlist.isEmpty ? widget.dropdownlist[0] : null);
    }

    return DropdownButtonFormField<CategoryModel>(
        validator: widget.validatorKey,
        value: selectedcategory,
        decoration: InputDecoration(
          
          fillColor:   const  Color.fromARGB(255, 237, 240, 239),
      
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
        ),
        hint: const Text(
          "Chooose Category",
          style: TextStyle(color: Color(0xFFA4A4A4)),
        ),
        items: widget.dropdownlist.map(
          (category) {
            return DropdownMenuItem<CategoryModel>(
              value: category,
              child: Text(
                category.name,
                style: const TextStyle(
                  color: Color(0xFF2F2F2F),
                ),
              ),
            );
          },
        ).toList(),
        onChanged: widget.onChanged);
  }
}
