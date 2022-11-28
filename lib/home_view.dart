import 'dart:developer';

import 'package:blogit/add_blog.dart';
import 'package:blogit/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/auth_bloc.dart';
import 'bloc/database/database_bloc.dart';
import 'constants/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: SizedBox(
              height: 65.0,
              width: 65.0,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => AddBlog())));
                  },
                  elevation: 5.0,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                height: 75,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      iconSize: 30.0,
                      padding: const EdgeInsets.only(left: 28.0),
                      icon: const Icon(Icons.home),
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 30.0,
                      padding: const EdgeInsets.only(right: 28.0),
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 30.0,
                      padding: const EdgeInsets.only(left: 28.0),
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                    ),
                    IconButton(
                      iconSize: 30.0,
                      padding: const EdgeInsets.only(right: 28.0),
                      icon: const Icon(Icons.bookmark_border_rounded),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 247, 245, 245),
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 247, 245, 245),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                    icon: const Icon(
                      Icons.logout_rounded,
                    ),
                    onPressed: () async {
                      context.read<AuthBloc>().add(AuthSignedOut());
                    })
              ],
              systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Color.fromARGB(255, 247, 245, 245)),
              title: const Text(
                Constants.textLogoText,
                style: TextStyle(fontSize: 35),
              ),
            ),
            body: BlocBuilder<DatabaseBloc, DatabaseState>(
              builder: (context, state) {
                String? displayName = (context.read<AuthBloc>().state as AuthSuccess).displayName;
                if (state is DatabaseSuccess &&
                    displayName != (context.read<DatabaseBloc>().state as DatabaseSuccess).displayName) {
                  context.read<DatabaseBloc>().add(DatabaseFetched(displayName));
                }
                if (state is DatabaseInitial || state is BlogAddedToDatabase) {
                  context.read<DatabaseBloc>().add(DatabaseFetched(displayName));
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DatabaseSuccess) {
                  if (state.listOfBlogs.isEmpty) {
                    return const Center(
                      child: Text(Constants.textNoData),
                    );
                  } else {
                    return Center(
                      child: ListView.builder(
                        itemCount: state.listOfBlogs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.listOfBlogs[index].title,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    state.listOfBlogs[index].displayName!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Text(
                                  state.listOfBlogs[index].content,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ));
      },
    );
  }
}
