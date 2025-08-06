// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/airtime_topup/data/model/buy_airtime_response.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/dashboard/transaction_history/presentation/view/transaction_details_widget.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class AirtimeSuccessView extends StatelessWidget {
  const AirtimeSuccessView({super.key, required this.data});
  final BuyAirtimeResponse data;

  @override
  Widget build(BuildContext context) {
    final DateTime? parsedDate = data.date;

    final String formattedDate =
        parsedDate != null ? DateFormat.yMMMMd().format(parsedDate) : '';
    final String formattedTime =
        parsedDate != null ? DateFormat.jm().format(parsedDate) : '';
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CustomAppHeaderSection(
                title: 'Transaction Receipt',
              ),
              VerticalSpacing(10),
              SizedBox(
                height: 120,
                child: Lottie.asset('assets/lottie/success.json'),
              ),
              VerticalSpacing(20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0.3,
                        spreadRadius: 0.3,
                        color: Colors.black.withAlpha(
                          (0.4 * 255).toInt(),
                        ),
                      )
                    ]),
                child: Column(
                  children: [
                    Text(
                      '₦${data.amount ?? ''}',
                      style: context.textTheme.s30w600.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    VerticalSpacing(20),
                    Center(
                      child: Text(
                        data.description ?? '',
                        style: context.textTheme.s16w400,
                      ),
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Service',
                      subTitle: data.service ?? '',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Invoice',
                      subTitle: data.reference ?? '',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Number',
                      subTitle: data.phoneNumber ?? '',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Date/Time',
                      subTitle: '$formattedDate | $formattedTime',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Type',
                      subTitle: data.type ?? '',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Status',
                      subTitle: data.status ?? '',
                      statusColor:
                          (data.status?.toLowerCase() ?? '') != 'success'
                              ? Colors.red
                              : AppColors.primary005304,
                    ),
                    VerticalSpacing(20),
                    Text(
                      'Thank you for choosing us!. Kindly reach out to us if the value of this transaction is not received.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              VerticalSpacing(30),
              MapsDataSendButton(
                  onTap: () {
                    _shareTransactionDetails(
                        context, formattedDate, formattedTime);
                  },
                  title: 'Share'),
              VerticalSpacing(20),
              MapsDataSendButton(
                onTap: () => _downloadTransactionReceipt(
                    context, formattedDate, formattedTime),
                title: 'Download',
                textColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      )),
    );
  }

  _shareTransactionDetails(
      BuildContext context, String formattedDate, String formattedTime) {
    // Show a beautiful preview dialog before sharing
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        return SizedBox(
          height: 400,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog Header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Share Transaction Receipt',
                      style: context.textTheme.s18w600,
                    ),
                  ),

                  // Receipt Preview - Using your existing container structure
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 4),
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                        border: Border.all(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Header with emoji
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.primaryColor.withOpacity(0.8)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '📱 TRANSACTION RECEIPT',
                              textAlign: TextAlign.center,
                              style: context.textTheme.s16w600.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const VerticalSpacing(20),

                          // Amount - matching your existing style
                          Text(
                            '₦${data.amount ?? ''}',
                            style: context.textTheme.s30w600.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),

                          const VerticalSpacing(15),

                          // Description
                          Text(
                            data.description ?? '',
                            style: context.textTheme.s16w400,
                            textAlign: TextAlign.center,
                          ),

                          const VerticalSpacing(20),

                          // Transaction Details - using your existing TransactionDetailWidget style
                          _buildShareDetailRow(
                              '🔧 Service', data.service ?? '', context),
                          const VerticalSpacing(12),
                          _buildShareDetailRow(
                              '📄 Invoice', data.reference ?? '', context),
                          const VerticalSpacing(12),
                          _buildShareDetailRow(
                              '📞 Number', data.phoneNumber ?? '', context),
                          const VerticalSpacing(12),
                          _buildShareDetailRow('📅 Date/Time',
                              '$formattedDate | $formattedTime', context),
                          const VerticalSpacing(12),
                          _buildShareDetailRow(
                              '📊 Type', data.type ?? '', context),
                          const VerticalSpacing(12),
                          _buildShareDetailRow(
                              '✅ Status', data.status ?? '', context,
                              statusColor: (data.status?.toLowerCase() ?? '') !=
                                      'success'
                                  ? Colors.red
                                  : AppColors.primary005304),

                          const VerticalSpacing(20),

                          // Footer message
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Text(
                              'Thank you for choosing us! 🙏',
                              textAlign: TextAlign.center,
                              style: context.textTheme.s14w400.copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancel',
                            style: context.textTheme.s16w400.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        MapsDataSendButton(
                          onTap: () {
                            Navigator.of(context).pop();
                            _performShare(formattedDate, formattedTime);
                          },
                          title: 'Share',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(modalContext).viewInsets.bottom),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

// Helper method to build detail rows for the share preview
  Widget _buildShareDetailRow(String title, String value, BuildContext context,
      {Color? statusColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: context.textTheme.s14w500.copyWith(
              color: Colors.grey[700],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: context.textTheme.s14w400.copyWith(
              color: statusColor ?? Colors.black87,
              fontWeight:
                  statusColor != null ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

// Separate method to perform the actual sharing
  void _performShare(String formattedDate, String formattedTime) {
    final String shareText = """
╔══════════════════════════════════╗
║        TRANSACTION RECEIPT        ║
╚══════════════════════════════════╝

💰 Amount: ₦${data.amount ?? 'N/A'}
📝 Description: ${data.description ?? 'N/A'}
🔧 Service: ${data.service ?? 'N/A'}
📄 Invoice: ${data.reference ?? 'N/A'}
📞 Number: ${data.phoneNumber ?? 'N/A'}
📅 Date: $formattedDate
⏰ Time: $formattedTime
📊 Type: ${data.type ?? 'N/A'}
✅ Status: ${data.status ?? 'N/A'}

─────────────────────────────────────
     Thank you for choosing us! 🙏
─────────────────────────────────────

Kindly reach out to us if the value of this transaction is not received.
""";

    Share.share(
      shareText,
      subject: 'Transaction Receipt - ${data.reference ?? 'Unknown'}',
    );
  }

//   void _shareTransactionDetails(
//       BuildContext context, String formattedDate, String formattedTime) {
//     Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 0.3,
//               spreadRadius: 0.3,
//               color: Colors.black.withAlpha(
//                 (0.4 * 255).toInt(),
//               ),
//             )
//           ]),
//       child: Column(
//         children: [],
//       ),
//     );
//     final String shareText = """
// 📱 Transaction Receipt 📱

// 💰 Amount: ₦${data.amount ?? ''}
// 📝 Description: ${data.description ?? ''}
// 🔧 Service: ${data.service ?? ''}
// 📄 Invoice: ${data.reference ?? ''}
// 📞 Number: ${data.phoneNumber ?? ''}
// 📅 Date/Time: $formattedDate | $formattedTime
// 📊 Type: ${data.type ?? ''}
// ✅ Status: ${data.status ?? ''}

// Thank you for choosing us! 🙏
// """;

//     Share.share(
//       shareText,
//       subject: 'Transaction Receipt - ${data.reference ?? ''}',
//     );
//   }

  Future<void> _downloadTransactionReceipt(
      BuildContext context, String formattedDate, String formattedTime) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Request storage permission
      final permission = await Permission.storage.request();
      if (!permission.isGranted) {
        Navigator.of(context).pop(); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Storage permission required to download')),
        );
        return;
      }

      // Create PDF
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
                padding: pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                    color: PdfColors.white,
                    borderRadius: pw.BorderRadius.circular(16),
                    boxShadow: [
                      pw.BoxShadow(
                        blurRadius: 0.3,
                        spreadRadius: 0.3,
                        color: PdfColor.fromInt(0x66000000),
                      )
                    ]),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Center(
                      child: pw.Text(
                        'Transaction Receipt',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Center(
                      child: pw.Text(
                        'Thank you for choosing us!',
                        style: pw.TextStyle(fontSize: 14),
                      ),
                    ),
                    pw.SizedBox(height: 30),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(20),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey300),
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.Column(
                        children: [
                          pw.Center(
                            child: pw.Text(
                              '₦${data.amount ?? ''}',
                              style: pw.TextStyle(
                                fontSize: 28,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.green,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 20),
                          pw.Center(
                            child: pw.Text(
                              data.description ?? '',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ),
                          pw.SizedBox(height: 20),
                          _buildPdfDetailRow('Service', data.service ?? ''),
                          pw.SizedBox(height: 10),
                          _buildPdfDetailRow('Invoice', data.reference ?? ''),
                          pw.SizedBox(height: 10),
                          _buildPdfDetailRow('Number', data.phoneNumber ?? ''),
                          pw.SizedBox(height: 10),
                          _buildPdfDetailRow(
                              'Date/Time', '$formattedDate | $formattedTime'),
                          pw.SizedBox(height: 10),
                          _buildPdfDetailRow('Type', data.type ?? ''),
                          pw.SizedBox(height: 10),
                          _buildPdfDetailRow('Status', data.status ?? ''),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 30),
                    pw.Center(
                      child: pw.Text(
                        'Generated on ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}',
                        style: pw.TextStyle(
                            fontSize: 10, color: PdfColors.grey600),
                      ),
                    ),
                  ],
                ));
          },
        ),
      );

      // Get the directory to save the file
      final Directory? directory = await getExternalStorageDirectory();
      if (directory == null) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to access storage')),
        );
        return;
      }

      // Create the file path
      final String fileName =
          'transaction_receipt_${data.reference ?? DateTime.now().millisecondsSinceEpoch}.pdf';
      final String filePath = '${directory.path}/$fileName';
      final File file = File(filePath);

      // Save the PDF
      await file.writeAsBytes(await pdf.save());

      Navigator.of(context).pop(); // Close loading dialog

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Receipt downloaded to: $filePath'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Copy Path',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: filePath));
            },
          ),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop(); // Close loading dialog if still open
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading receipt: $e')),
      );
    }
  }

  pw.Widget _buildPdfDetailRow(String title, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(value),
      ],
    );
  }
}
