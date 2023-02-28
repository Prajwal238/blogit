import 'package:blogit/add_blog.dart';
import 'package:blogit/blog_page.dart';
import 'package:blogit/saved_collection.dart';
import 'package:blogit/search.dart';
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
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => const AddBlog())));
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
                      },
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
                      onPressed: () {
                        String? uid = (context.read<AuthBloc>().state as AuthSuccess).uid;
                        context.read<DatabaseBloc>().add(SavedBlogsFetched(uid));
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SavedCollection()));
                      },
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
                                                state.listOfBlogs[index].displayName![0].toUpperCase(),
                                                style: const TextStyle(color: Constants.kGreyColor),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 6.0),
                                            child: Text(
                                              state.listOfBlogs[index].displayName!,
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
                                              state.listOfBlogs[index].title,
                                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.1,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: Text(state.listOfBlogs[index].content,
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
            ));
      },
    );
  }
}
