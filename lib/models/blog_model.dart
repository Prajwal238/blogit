import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {

  String? displayName;
  String title;
  String content;
  BlogModel({
    required this.title,
    required this.content,
    this.displayName
  });

  BlogModel copyWith({
    String? title,
    String? content,
    String? displayName,
  }) {
    return BlogModel(
      title: title ?? this.title,
      content: content ?? this.content,
      displayName: displayName ?? this.displayName,
    );
  }

  BlogModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : title = doc.data()!["title"],
        content = doc.data()!["content"],
        displayName = doc.data()!["displayName"];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'displayName': displayName
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'BlogModel(title: $title, content: $content)';
}