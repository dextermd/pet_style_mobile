import 'package:flutter/material.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:searchfield/searchfield.dart';

class SearchableDropdown extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final List<SearchFieldListItem<String>> suggestions;
  final String? Function(String?)? validator;

  const SearchableDropdown({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.suggestions,
    this.validator,
  });

  List<SearchFieldListItem<String>> _filterSuggestions(String query) {
    final lowerCaseQuery =
        query.toLowerCase().replaceAll('-', '').replaceAll(' ', '');
    return suggestions.where((item) {
      final suggestion =
          item.searchKey.toLowerCase().replaceAll('-', '').replaceAll(' ', '');
      return suggestion.contains(lowerCaseQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SearchField(
      controller: controller,
      focusNode: focusNode,
      hint: 'Выберите породу',
      suggestionStyle: const TextStyle(
        color: AppColors.primaryText,
        fontSize: 13,
      ),
      suggestions: suggestions,
      scrollbarDecoration: ScrollbarDecoration(
        thumbColor: AppColors.primaryElement.withAlpha(120),
        radius: const Radius.circular(10),
      ),
      searchInputDecoration: SearchInputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(16),
        fillColor: AppColors.containerColor.withAlpha(50),
        filled: true,
        hintStyle: TextStyle(
          color: AppColors.primaryText.withAlpha(120),
          fontSize: 13,
        ),
      ),
      suggestionsDecoration: SuggestionDecoration(
        color: AppColors.containerColor.withAlpha(50),
        borderRadius: BorderRadius.circular(10),
      ),
      validator: validator,
      suggestionState: Suggestion.expand,
      onSuggestionTap: (SearchFieldListItem<String> x) {
        controller.text = x.searchKey;
        focusNode.unfocus();
      },
      onSearchTextChanged: (query) {
        return _filterSuggestions(query);
      },
    );
  }
}
