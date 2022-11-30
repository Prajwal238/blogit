import 'package:blogit/cubit/text_to_speach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/database/database_bloc.dart';
import 'constants/constants.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key, required this.index});

  final int index;

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {

  // @override
  // void dispose() {
  //   context.read<TextToSpeachCubit>().dispose();
  //   super.dispose();
  // }

  //Dispose Will not work in this way

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kBlackColor,
      appBar: AppBar(
          foregroundColor: Constants.kBlackColor,
          backgroundColor: const Color.fromARGB(255, 247, 245, 245),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.bookmark_border_rounded,
                ),
                onPressed: () {})
          ],
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Color.fromARGB(255, 247, 245, 245)),
          leading: IconButton(
              icon: const Icon(
                Icons.navigate_before_rounded,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Image.asset(
              'assets/background-blogit.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          BlocBuilder<DatabaseBloc, DatabaseState>(
            builder: ((context, state) {
              if (state is DatabaseSuccess) {
                var index = widget.index;
                return DraggableScrollableSheet(
                    initialChildSize: 0.8,
                    minChildSize: 0.8,
                    maxChildSize: 0.9,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
                          color: Color.fromARGB(255, 247, 245, 245),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              Hero(
                                tag: "Title-$index",
                                child: Text(
                                  state.listOfBlogs[index].title,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.015,
                              ),
                              Row(
                                children: [
                                  Hero(
                                    tag: "User-$index",
                                    child: CircleAvatar(
                                      backgroundColor: Constants.kBlackColor,
                                      radius: 13,
                                      child: Text(
                                        state.listOfBlogs[index].displayName![0].toUpperCase(),
                                        style: const TextStyle(fontSize: 10, color: Constants.kGreyColor),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      state.listOfBlogs[index].displayName!,
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  BlocProvider(
                                    create: (context) => TextToSpeachCubit(),
                                    child: BlocBuilder<TextToSpeachCubit, TextToSpeachState>(
                                      builder: (context, ttsstate) {
                                        return IconButton(
                                            onPressed: () {
                                              (ttsstate is TextToSpeachPlaying)
                                                  ? context.read<TextToSpeachCubit>().pause()
                                                  : context.read<TextToSpeachCubit>().play(state.listOfBlogs[index].title + state.listOfBlogs[index].content);
                                            },
                                            icon: Icon(
                                              color: Colors.grey,
                                              size: 20,
                                                (ttsstate is TextToSpeachPlaying) ? Icons.pause_circle : Icons.play_circle));
                                      },
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(
                                  state.listOfBlogs[index].content,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 70, 70, 70)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Constants.kBlackColor,
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
