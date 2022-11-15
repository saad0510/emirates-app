import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../data/entities/city.dart';
import '../controllers/city_controller.dart';

class SelectAirportField extends StatelessWidget {
  const SelectAirportField({super.key});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<City>(
      fieldViewBuilder: (_, textEditingController, focusNode, __) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          style: TextStyle(
            color: context.contrastColor.withOpacity(0.9),
          ),
          decoration: const InputDecoration(
            hintText: "Type the name of city",
          ),
        );
      },
      optionsViewBuilder: (_, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            type: MaterialType.card,
            color: Colors.transparent,
            child: Container(
              width: context.width - 32.w,
              constraints: BoxConstraints(maxHeight: 500.h),
              padding: AppPaddings.smallXY,
              decoration: BoxDecoration(
                color: context.backgroundColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    options.length,
                    (i) {
                      final city = options.elementAt(i);
                      return GestureDetector(
                        onTap: () => onSelected(city),
                        child: ListTile(
                          textColor: context.contrastColor,
                          title: Text(
                            city.fullname,
                            style: context.textTheme.bodyText2,
                          ),
                          trailing: Text(city.code),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
      displayStringForOption: (city) => city.name,
      optionsBuilder: (value) {
        final text = value.text.toLowerCase();
        if (text.isEmpty) return [];

        return CityController.cities.where(
          (e) {
            final city = e.name.toLowerCase();
            return city.startsWith(text);
          },
        );
      },
    );
  }
}
