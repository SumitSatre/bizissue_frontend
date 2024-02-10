import 'package:json_annotation/json_annotation.dart';

part 'issue_model.g.dart';

@JsonSerializable()
class Blocked {
  bool isBlocked;
  BlockedBy? blockedBy;

  Blocked({
    required this.isBlocked,
      this.blockedBy,
  });

  factory Blocked.fromJson(Map<String, dynamic> json) =>
      _$BlockedFromJson(json);

  Map<String, dynamic> toJson() => _$BlockedToJson(this);

  Blocked copyWith({
    bool? isBlocked,
    BlockedBy? blockedBy,
  }) {
    return Blocked(
      isBlocked: isBlocked ?? this.isBlocked,
      blockedBy: blockedBy ?? this.blockedBy,
    );
  }
}

@JsonSerializable()
class BlockedBy {
  String? name;
  String? id;

  BlockedBy({
     this.name,
     this.id,
  });

  factory BlockedBy.fromJson(Map<String, dynamic> json) =>
      _$BlockedByFromJson(json);

  Map<String, dynamic> toJson() => _$BlockedByToJson(this);

  BlockedBy copyWith({
    String? name,
    String? id,
  }) {
    return BlockedBy(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

@JsonSerializable()
class Critical {
  bool isCritical;
  CriticalBy? markedCriticalBy;

  Critical({
    required this.isCritical,
     this.markedCriticalBy,
  });

  factory Critical.fromJson(Map<String, dynamic> json) =>
      _$CriticalFromJson(json);

  Map<String, dynamic> toJson() => _$CriticalToJson(this);

  Critical copyWith({
    bool? isCritical,
    CriticalBy? markedCriticalBy,
  }) {
    return Critical(
      isCritical: isCritical ?? this.isCritical,
      markedCriticalBy: markedCriticalBy ?? this.markedCriticalBy,
    );
  }
}

@JsonSerializable()
class CriticalBy {
  String? name;
  String? id;

  CriticalBy({
     this.name,
     this.id,
  });

  factory CriticalBy.fromJson(Map<String, dynamic> json) =>
      _$CriticalByFromJson(json);

  Map<String, dynamic> toJson() => _$CriticalByToJson(this);

  CriticalBy copyWith({
    String? name,
    String? id,
  }) {
    return CriticalBy(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

@JsonSerializable()
class OutsiderShort {
  String? name;
  String? id;

  OutsiderShort({
    this.name,
    this.id,
  });

  factory OutsiderShort.fromJson(Map<String, dynamic> json) =>
      _$OutsiderShortFromJson(json);

  Map<String, dynamic> toJson() => _$OutsiderShortToJson(this);

  OutsiderShort copyWith({
    String? name,
    String? id,
  }) {
    return OutsiderShort(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

@JsonSerializable()
class CreatedBy {
  String name;
  String id;

  CreatedBy({
    required this.name,
    required this.id,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

  CreatedBy copyWith({
    String? name,
    String? id,
  }) {
    return CreatedBy(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

@JsonSerializable()
class AssignedTo {
  String name;
  String id;

  AssignedTo({
    required this.name,
    required this.id,
  });

  factory AssignedTo.fromJson(Map<String, dynamic> json) =>
      _$AssignedToFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedToToJson(this);

  AssignedTo copyWith({
    String? name,
    String? id,
  }) {
    return AssignedTo(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

@JsonSerializable()
class IssueModel {
  String issueId;
  String title;
  String? details;
  Blocked blocked;
  Critical critical;
  int delayed;
  CreatedBy createdBy;
  AssignedTo assignedTo;
  String createdDate;
  String deliveryDate;
  String nextFollowUpDate;
  String status;
  bool isAssignToOutsider;
  OutsiderShort? outsider;

  IssueModel({
    required this.issueId,
    required this.title,
     this.details,
    required this.blocked,
    required this.critical,
    required this.delayed,
    required this.createdBy,
    required this.assignedTo,
    required this.createdDate,
    required this.deliveryDate,
    required this.nextFollowUpDate,
    required this.status,
    required this.isAssignToOutsider,
    required this.outsider
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) => _$IssueModelFromJson(json);

  Map<String, dynamic> toJson() => _$IssueModelToJson(this);

  IssueModel copyWith({
    String? issueId,
    String? title,
    String? details,
    Blocked? blocked,
    Critical? critical,
    int? delayed,
    CreatedBy? createdBy,
    AssignedTo? assignedTo,
    String? createdDate,
    String? deliveryDate,
    String? nextFollowUpDate,
    String? status,
    bool? isAssignToOutsider,
    OutsiderShort? outsider,
  }) {
    return IssueModel(
      issueId: issueId ?? this.issueId,
      title: title ?? this.title,
      details: details ?? this.details,
      blocked: blocked ?? this.blocked,
      critical: critical ?? this.critical,
      delayed: delayed ?? this.delayed,
      createdBy: createdBy ?? this.createdBy,
      assignedTo: assignedTo ?? this.assignedTo,
      createdDate: createdDate ?? this.createdDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      nextFollowUpDate: nextFollowUpDate ?? this.nextFollowUpDate,
      status: status ?? this.status,
      isAssignToOutsider: isAssignToOutsider ?? this.isAssignToOutsider,
      outsider: outsider ?? this.outsider,
    );
  }
}

@JsonSerializable()
class GroupIssue {
  String? date;
  List<IssueModel>? issues;

  GroupIssue({ this.date,  this.issues});

  factory GroupIssue.fromJson(Map<String, dynamic> json) =>
      _$GroupIssueFromJson(json);

  Map<String, dynamic> toJson() => _$GroupIssueToJson(this);
}
