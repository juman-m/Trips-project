import 'package:capstone_1/blocs/search_bloc/search_bloc.dart';
import 'package:capstone_1/blocs/search_bloc/search_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChange,
  });
  final TextEditingController controller;
  final Function(String query) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.06,
      child: TextField(
        onSubmitted: onChange,
        controller: controller,
        textAlignVertical: const TextAlignVertical(y: 1),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black54,
              ),
              onPressed: () {
                onChange;
              }),
          hintText: 'Search for people',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
              icon: const Icon(
                Icons.close_outlined,
                color: Colors.black54,
              ),
              onPressed: () {
                context.read<SearchBloc>().add(ClearSearchEvent());
                controller.clear();
              }),
        ),
      ),
    );
  }
}
