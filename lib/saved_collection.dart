import 'package:blogit/bloc/authentication/auth_bloc.dart';
import 'package:blogit/bloc/database/database_bloc.dart';
import 'package:blogit/blog_page.dart';
import 'package:blogit/constants/constants.dart';
import 'package:blogit/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedCollection extends StatelessWidget {
  const SavedCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure || state is AuthInitial) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeView()), (Route<dynamic> route) => false);
        }
      },
      buildWhen: ((previous, current) {
        if (current is AuthFailure || current is AuthInitial) {
          return false;
        }
        return true;
      }),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 247, 245, 245),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                String? displayName = (context.read<AuthBloc>().state as AuthSuccess).displayName;
                context.read<DatabaseBloc>().add(DatabaseFetched(displayName));
                Navigator.pop(context);
              },
            ),
            foregroundColor: Colors.black,
            backgroundColor: const Color.fromARGB(255, 247, 245, 245),
            title: const Text(
              Constants.textSavedCollection,
              style: TextStyle(fontSize: 28),
            ),
          ),
          //Is there a way to use BlocConsumer here instead of BlocBuilder??
          body: BlocBuilder<DatabaseBloc, DatabaseState>(
            builder: (context, state) {
              if (state is SavedDatabaseSuccess) {
                if (state.listOfSavedBlogs.isEmpty) {
                    return const Center(
                      child: Text(Constants.textNoData),
                    );
                  } else {
                    return Center(
                      child: ListView.builder(
                        itemCount: state.listOfSavedBlogs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 8.0, 20, 8),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.38,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                color: Colors.white,
                                shadowColor: const Color.fromARGB(255, 233, 231, 231),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Hero(
                                            tag: "User-$index",
                                            child: CircleAvatar(
                                              backgroundColor: Constants.kBlackColor,
                                              radius: 18,
                                              child: Text(
                                                state.listOfSavedBlogs[index].displayName![0].toUpperCase(),
                                                style: const TextStyle(color: Constants.kGreyColor),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 6.0),
                                            child: Text(
                                              state.listOfSavedBlogs[index].displayName!,
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.listOfSavedBlogs[index].title,
                                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.1,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Text(state.listOfSavedBlogs[index].content,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.normal,
                                                          color: Color.fromARGB(255, 70, 70, 70)),
                                                      overflow: TextOverflow.fade),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.06,
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(backgroundColor: Constants.kBlackColor),
                                              onPressed: () {
                                                Navigator.push(
                                                    context, MaterialPageRoute(builder: (_) => BlogPage(index: index)));
                                              },
                                              child: const Text(
                                                Constants.textReadMore,
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                              )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
              } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Constants.kBlackColor,
                  ));
                }
            },
          )
        );
      },
    );
  }
}
