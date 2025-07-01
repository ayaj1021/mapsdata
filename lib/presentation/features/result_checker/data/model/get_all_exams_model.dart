class ExamResponse {
  int? code;
  String? status;
  String? message;
  List<Exam>? exams;
  int? balance;
  bool? pin;

  ExamResponse({
    this.code,
    this.status,
    this.message,
    this.exams,
    this.balance,
    this.pin,
  });

  factory ExamResponse.fromJson(Map<String, dynamic> json) {
    return ExamResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
      exams: (json['exams'] as List<dynamic>?)
          ?.map((e) => Exam.fromJson(e as Map<String, dynamic>))
          .toList(),
      balance: json['balance'] as int?,
      pin: json['pin'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'exams': exams?.map((e) => e.toJson()).toList(),
      'balance': balance,
      'pin': pin,
    };
  }
}

class Exam {
  String? id;
  String? exam;
  int? amount;

  Exam({
    this.id,
    this.exam,
    this.amount,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'] as String?,
      exam: json['exam'] as String?,
      amount: json['amount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exam': exam,
      'amount': amount,
    };
  }
}
