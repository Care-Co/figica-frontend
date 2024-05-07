import 'dart:convert';

class GroupData {
  String groupId;
  String groupName;
  List<Member> members;

  GroupData({required this.groupId, required this.groupName, required this.members});

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      groupId: json['groupId'],
      groupName: json['groupName'],
      members: (json['members'] as List).map((m) => Member.fromJson(m)).toList(),
    );
  }
  static GroupData fromJsonString(String jsonString) {
    return GroupData.fromJson(jsonDecode(jsonString));
  }

  @override
  String toString() {
    return 'Group ID: $groupId, Group Name: $groupName, Members Count: ${members.length}';
  }
}

class Member {
  String memberId;
  String authority;
  String firstName;
  String lastName;
  String? photoUrl;
  Status status;

  Member({required this.memberId, required this.authority, required this.firstName, required this.lastName, this.photoUrl, required this.status});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['memberId'],
      authority: json['authority'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      photoUrl: json['photoUrl'],
      status: Status.fromJson(json['status']),
    );
  }
  String toString() {
    return 'memberId: $memberId, authority: $authority';
  }
}

class Status {
  String id;
  bool humanHeight;
  bool humanWeight;
  bool humanFootprint;
  bool schedule;

  Status({required this.id, required this.humanHeight, required this.humanWeight, required this.humanFootprint, required this.schedule});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      humanHeight: json['humanHeight'],
      humanWeight: json['humanWeight'],
      humanFootprint: json['humanFootprint'],
      schedule: json['schedule'],
    );
  }
}
