import 'dart:developer';

import 'package:blogit/bloc/search/search_bloc.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.navigate_before_rounded,
              color: Constants.kBlackColor,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: controller,
                cursorColor: Constants.kBlackColor,
                onChanged: (value) {
                  log(value);
                  context.read<SearchBloc>().add(SearchQueryEntered(value));
                },
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 241, 240, 240),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Constants.kBlackColor, width: 0.75)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Constants.kBlackColor, width: 0.75)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Constants.kBlackColor, width: 0.75)),
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  hintText: Constants.hintTextSearchScreen,
                ),
              ),
            ),
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if(state is SearchInitial) {
                return Container();
              }
              if (state is SearchSuccess) {
                if (state.listBasedOnSearch.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.listBasedOnSearch.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.article_outlined,
                            color: Constants.kBlackColor,
                          ),
                          title: Text(state.listBasedOnSearch[index].title),
                          subtitle: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Constants.kBlackColor,
                                radius: 18,
                                child: Text(
                                  state.listBasedOnSearch[index].displayName![0].toUpperCase(),
                                  style: const TextStyle(color: Constants.kGreyColor),
                                ),
                              ),
                              Text(
                                state.listBasedOnSearch[index].displayName!,
                                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(Constants.textNoData),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
