import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mapsdata/core/extensions/text_theme_extension.dart';
import 'package:mapsdata/core/theme/app_colors.dart';
import 'package:mapsdata/presentation/features/airtime_topup/presentation/widgets/airtime_topup_header_section.dart';
import 'package:mapsdata/presentation/features/dashboard/transaction_history/presentation/view/transaction_details_widget.dart';
import 'package:mapsdata/presentation/features/transactions/data/model/get_transactions_response.dart';
import 'package:mapsdata/presentation/general_widgets/app_button.dart';
import 'package:mapsdata/presentation/general_widgets/spacing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class TransactionDetailsView extends StatelessWidget {
  const TransactionDetailsView({super.key, required this.tx});
  final TransactionData tx;

  @override
  Widget build(BuildContext context) {
    final DateTime parsedDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(tx.date ?? '');

    // Format date and time separately
    final String formattedDate =
        DateFormat.yMMMMd().format(parsedDate); // e.g. July 7, 2025
    final String formattedTime = DateFormat.jm().format(parsedDate);
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
              VerticalSpacing(20),
              Text(
                'Thank you for choosing us!. Kindly reach out to us if the value of this transaction is not received.',
                textAlign: TextAlign.center,
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
                      '₦${tx.amount ?? ''}',
                      style: context.textTheme.s30w600.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    VerticalSpacing(20),
                    Center(
                      child: Text(
                        tx.description ?? '',
                        style: context.textTheme.s16w400,
                      ),
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Service',
                      subTitle: tx.service ?? '',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Invoice',
                      subTitle: tx.reference ?? '',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Number',
                      subTitle: tx.phoneNumber ?? '',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Date/Time',
                      subTitle: '$formattedDate | $formattedTime',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Type',
                      subTitle: tx.type ?? '',
                    ),
                    VerticalSpacing(20),
                    TransactionDetailWidget(
                      title: 'Status',
                      subTitle: tx.status ?? '',
                      statusColor: (tx.status?.toLowerCase() ?? '') != 'success'
                          ? Colors.red
                          : AppColors.primary005304,
                    ),
                  ],
                ),
              ),
              VerticalSpacing(30),
              MapsDataSendButton(
                  onTap: () => _shareTransactionDetails(
                      context, formattedDate, formattedTime),
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

  void _shareTransactionDetails(
      BuildContext context, String formattedDate, String formattedTime) {
    final String shareText = """
📱 Transaction Receipt 📱

💰 Amount: ₦${tx.amount ?? ''}
📝 Description: ${tx.description ?? ''}
🔧 Service: ${tx.service ?? ''}
📄 Invoice: ${tx.reference ?? ''}
📞 Number: ${tx.phoneNumber ?? ''}
📅 Date/Time: $formattedDate | $formattedTime
📊 Type: ${tx.type ?? ''}
✅ Status: ${tx.status ?? ''}

Thank you for choosing us! 🙏
""";

    Share.share(
      shareText,
      subject: 'Transaction Receipt - ${tx.reference ?? ''}',
    );
  }

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
            return pw.Column(
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
                          '₦${tx.amount ?? ''}',
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
                          tx.description ?? '',
                          style: pw.TextStyle(fontSize: 16),
                        ),
                      ),
                      pw.SizedBox(height: 20),
                      _buildPdfDetailRow('Service', tx.service ?? ''),
                      pw.SizedBox(height: 10),
                      _buildPdfDetailRow('Invoice', tx.reference ?? ''),
                      pw.SizedBox(height: 10),
                      _buildPdfDetailRow('Number', tx.phoneNumber ?? ''),
                      pw.SizedBox(height: 10),
                      _buildPdfDetailRow(
                          'Date/Time', '$formattedDate | $formattedTime'),
                      pw.SizedBox(height: 10),
                      _buildPdfDetailRow('Type', tx.type ?? ''),
                      pw.SizedBox(height: 10),
                      _buildPdfDetailRow('Status', tx.status ?? ''),
                    ],
                  ),
                ),
                pw.SizedBox(height: 30),
                pw.Center(
                  child: pw.Text(
                    'Generated on ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())}',
                    style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
                  ),
                ),
              ],
            );
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
          'transaction_receipt_${tx.reference ?? DateTime.now().millisecondsSinceEpoch}.pdf';
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
