import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {

  String bid;
  String? displayName;
  String title;
  String content;
  BlogModel({
    required this.bid,
    required this.title,
    required this.content,
    this.displayName
  });

  BlogModel copyWith({
    required String bid,
    String? title,
    String? content,
    String? displayName,
  }) {
    return BlogModel(
      bid: bid,
      title: title ?? this.title,
      content: content ?? this.content,
      displayName: displayName ?? this.displayName
    );
  }

  BlogModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : bid = doc.data()!["bid"],
        title = doc.data()!["title"],
        content = doc.data()!["content"],
        displayName = doc.data()!["displayName"];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bid': bid,
      'title': title,
      'content': content,
      'displayName': displayName
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'BlogModel(bid: $bid, title: $title, content: $content)';
}