import 'package:blogit/bloc/database/database_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authentication/auth_bloc.dart';
import 'constants/constants.dart';

OutlineInputBorder border = const OutlineInputBorder(borderSide: BorderSide(color: Constants.kBlackColor, width: 3.0));

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatabaseBloc, DatabaseState>(
      listener: (context, state) {
        if (state is BlogAddedToDatabase) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: BlocBuilder<DatabaseBloc, DatabaseState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.check,
              ),
              onPressed: () {
                String? displayName = (context.read<AuthBloc>().state as AuthSuccess).displayName;
                if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                  context.read<DatabaseBloc>().add(CreatingBlog(
                      title: titleController.text, content: contentController.text, displayName: displayName));
                }
              },
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 247, 245, 245),
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.navigate_before,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            Constants.texthelpertitle,
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: TextField(
                                style: const TextStyle(color: Colors.black),
                                controller: titleController,
                                decoration: InputDecoration(
                                    helperText: 'Please Enter your title',
                                    hintText: 'topic',
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                    border: border,
                                    focusedBorder: border)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            Constants.texthelperbody,
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  maxLines: 1500,
                                  controller: contentController,
                                  decoration: InputDecoration(
                                      helperText: 'Please type in the content for your blog.',
                                      hintText: 'Type in your content...',
                                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                      border: border,
                                      focusedBorder: border)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
