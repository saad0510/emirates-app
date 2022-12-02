import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../data/entities/city.dart';
import '../controllers/city_controller.dart';

class SelectCityField extends StatefulWidget {
  const SelectCityField({super.key, required this.onSelected});

  final void Function(City value) onSelected;

  @override
  State<SelectCityField> createState() => _SelectCityFieldState();
}

class _SelectCityFieldState extends State<SelectCityField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<City>(
      hideKeyboardOnDrag: true,
      keepSuggestionsOnLoading: false,
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
        style: context.textTheme.bodyText2,
        controller: controller,
        decoration: const InputDecoration(
          hintText: "Type the name of city",
        ),
      ),
      itemBuilder: (context, city) {
        return ListTile(
          contentPadding: AppPaddings.smallXY,
          tileColor: context.backgroundColor,
          textColor: context.contrastColor,
          title: Text(
            city.fullname,
            style: context.textTheme.subtitle2,
          ),
          subtitle: Text(
            city.airport,
            style: context.textTheme.bodyText2,
          ),
          trailing: Text(city.code),
        );
      },
      suggestionsCallback: (text) async {
        text = text.toLowerCase().trim();
        if (text.isEmpty) return [];
        return context.read<CityController>().search(text);
      },
      loadingBuilder: (_) => Container(
        height: 100.sp,
        width: double.infinity,
        color: context.backgroundColor,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
      noItemsFoundBuilder: (_) => Container(
        width: double.infinity,
        height: 100.sp,
        color: context.backgroundColor,
        alignment: Alignment.center,
        child: const Text("No cities found"),
      ),
      onSuggestionSelected: (city) {
        controller.text = city.name;
        widget.onSelected(city);
      },
    );
  }
}
