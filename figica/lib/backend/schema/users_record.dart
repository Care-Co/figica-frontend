import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../../flutter_set/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "birthday" field.
  String? _birthday;
  String get birthday => _birthday ?? '';
  bool hasBirthday() => _birthday != null;

  // "footPressureType" field.
  String? _footPressureType;
  String get footPressureType => _footPressureType ?? '';
  bool hasFootPressureType() => _footPressureType != null;

  // "groupId" field.
  String? _groupId;
  String get groupId => _groupId ?? '';
  bool hasGroupId() => _groupId != null;

  // "insertTime" field.
  String? _insertTime;
  String get insertTime => _insertTime ?? '';
  bool hasInsertTime() => _insertTime != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "roles" field.
  String? _roles;
  String get roles => _roles ?? '';
  bool hasRoles() => _roles != null;

  // "sex" field.
  String? _sex;
  String get sex => _sex ?? '';
  bool hasSex() => _sex != null;

  // "softDelete" field.
  String? _softDelete;
  String get softDelete => _softDelete ?? '';
  bool hasSoftDelete() => _softDelete != null;

  // "username" field.
  String? _username;
  String get username => _username ?? '';
  bool hasUsername() => _username != null;

  // "deleteTime" field.
  DateTime? _deleteTime;
  DateTime? get deleteTime => _deleteTime;
  bool hasDeleteTime() => _deleteTime != null;

  // "updateTime" field.
  DateTime? _updateTime;
  DateTime? get updateTime => _updateTime;
  bool hasUpdateTime() => _updateTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _birthday = snapshotData['birthday'] as String?;
    _footPressureType = snapshotData['footPressureType'] as String?;
    _groupId = snapshotData['groupId'] as String?;
    _insertTime = snapshotData['insertTime'] as String?;
    _password = snapshotData['password'] as String?;
    _roles = snapshotData['roles'] as String?;
    _sex = snapshotData['sex'] as String?;
    _softDelete = snapshotData['softDelete'] as String?;
    _username = snapshotData['username'] as String?;
    _deleteTime = snapshotData['deleteTime'] as DateTime?;
    _updateTime = snapshotData['updateTime'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _uid = snapshotData['uid'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
  }

  static CollectionReference get collection => FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() => 'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) => other is UsersRecord && reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? birthday,
  String? footPressureType,
  String? groupId,
  String? insertTime,
  String? password,
  String? roles,
  String? sex,
  String? softDelete,
  String? username,
  DateTime? deleteTime,
  DateTime? updateTime,
  String? phoneNumber,
  DateTime? createdTime,
  String? uid,
  String? displayName,
  String? photoUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'birthday': birthday,
      'footPressureType': footPressureType,
      'groupId': groupId,
      'insertTime': insertTime,
      'password': password,
      'roles': roles,
      'sex': sex,
      'softDelete': softDelete,
      'username': username,
      'deleteTime': deleteTime,
      'updateTime': updateTime,
      'phone_number': phoneNumber,
      'created_time': createdTime,
      'uid': uid,
      'display_name': displayName,
      'photo_url': photoUrl,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.birthday == e2?.birthday &&
        e1?.footPressureType == e2?.footPressureType &&
        e1?.groupId == e2?.groupId &&
        e1?.insertTime == e2?.insertTime &&
        e1?.password == e2?.password &&
        e1?.roles == e2?.roles &&
        e1?.sex == e2?.sex &&
        e1?.softDelete == e2?.softDelete &&
        e1?.username == e2?.username &&
        e1?.deleteTime == e2?.deleteTime &&
        e1?.updateTime == e2?.updateTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.createdTime == e2?.createdTime &&
        e1?.uid == e2?.uid &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.birthday,
        e?.footPressureType,
        e?.groupId,
        e?.insertTime,
        e?.password,
        e?.roles,
        e?.sex,
        e?.softDelete,
        e?.username,
        e?.deleteTime,
        e?.updateTime,
        e?.phoneNumber,
        e?.createdTime,
        e?.uid,
        e?.displayName,
        e?.photoUrl
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
