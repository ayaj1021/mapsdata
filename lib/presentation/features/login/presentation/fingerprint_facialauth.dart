// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mapsdata/core/config/security/biometrics.dart';
// import 'package:mapsdata/core/utils/enums.dart';
// import 'package:mapsdata/core/utils/strings.dart';

// class FingerprintFacialauth extends StatelessWidget {
//   const FingerprintFacialauth({
//     required this.onAuthenticated,
//     this.dataType = BiometricDataType.password,
//     super.key,
//   });
//   final void Function(String) onAuthenticated;
//   final BiometricDataType dataType;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, c) {
//         final biometrics = ref.read(biometricsProvider);

//         return FutureBuilder<bool>(
//           future: biometrics.canDoBiometrics(),
//           builder: (context, snapshot) {
//             return switch (snapshot.data) {
//               true => GestureDetector(
//                   onTap: () {
//                     _performAuth(
//                       biometrics,
//                       'encryptedPin',
//                       Strings.biometricReason,
//                     );
//                   },
//                   child: (Platform.isIOS)
//                       ? SvgPicture.asset('assets/icons/face-id.svg')
//                       : SvgPicture.asset('assets/icons/finger-print.svg'),
//                 ),
//               _ => const SizedBox(),
//             };
//           },
//         );
//       },
//     );
//   }

//   void _performAuth(
//     Biometrics biometrics,
//     String encryptedPin,
//     String message,
//   ) {
//     biometrics.performAuth(message).then((value) {
//       if (value) {
//         // if (!biometrics.enabledBiometrics) {
//         //   biometrics.setBiometric(value);
//         // }
//         onAuthenticated(encryptedPin);
//       }
//     });
//   }
// }
