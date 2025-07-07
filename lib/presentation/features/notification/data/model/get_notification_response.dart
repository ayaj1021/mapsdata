class NotificationResponse {
  final int? code;
  final String? status;
  final NotificartionUser? user;
  final NotificationData? notification;
  final WhatsappData? whatsapp;
  final ReferralData? referral;

  NotificationResponse({
    this.code,
    this.status,
    this.user,
    this.notification,
    this.whatsapp,
    this.referral,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      code: json['code'],
      status: json['status'],
      user: json['user'] != null
          ? NotificartionUser.fromJson(json['user'])
          : null,
      notification: json['notification'] != null
          ? NotificationData.fromJson(json['notification'])
          : null,
      whatsapp: json['whatsapp'] != null
          ? WhatsappData.fromJson(json['whatsapp'])
          : null,
      referral: json['referral'] != null
          ? ReferralData.fromJson(json['referral'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'user': user?.toJson(),
        'notification': notification?.toJson(),
        'whatsapp': whatsapp?.toJson(),
        'referral': referral?.toJson(),
      };
}

class NotificartionUser {
  final num? wallet;
  final String? commission;
  final String? verification;
  final String? status;

  NotificartionUser({
    this.wallet,
    this.commission,
    this.verification,
    this.status,
  });

  factory NotificartionUser.fromJson(Map<String, dynamic> json) =>
      NotificartionUser(
        wallet: json['wallet'],
        commission: json['commission'],
        verification: json['verification'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'wallet': wallet,
        'commission': commission,
        'verification': verification,
        'status': status,
      };
}

class NotificationData {
  final String? message;

  NotificationData({this.message});

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(message: json['message']);

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}

class WhatsappData {
  final String? number;
  final String? link;

  WhatsappData({this.number, this.link});

  factory WhatsappData.fromJson(Map<String, dynamic> json) => WhatsappData(
        number: json['number'],
        link: json['link'],
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'link': link,
      };
}

class ReferralData {
  final String? commission;

  ReferralData({this.commission});

  factory ReferralData.fromJson(Map<String, dynamic> json) =>
      ReferralData(commission: json['commission']);

  Map<String, dynamic> toJson() => {
        'commission': commission,
      };
}
