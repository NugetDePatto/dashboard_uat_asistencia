import 'package:dashboard_uat_asistencia/utils/calendario_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'dart:html' as html;

class PDFRepository {
  obtenerPDF() {
    final pdf = esqueleto();
    guardarPDF(pdf);
  }

  pw.Text texto(String text, {bold = false, center = true}) => pw.Text(
        text,
        textScaleFactor: .9,
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
        style: pw.TextStyle(
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      );

  guardarPDF(pw.Document pdf) async {
    String nombre = 'reporte prueba';

    var savedFile = await pdf.save();

    List<int> fileInts = List.from(savedFile);
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download", "$nombre.pdf")
      ..click();
  }

  esqueleto() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        header: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          child: pw.Column(
            children: [
              pw.SizedBox(height: 20),
              pw.Text(
                'Reporte de Asistencias',
                textScaleFactor: 1.3,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                'Facultad de Ingeniería',
                textScaleFactor: 0.8,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                '${inicioCiclo.toString().substring(0, 10)} - ${finCiclo.toString().substring(0, 10)}',
                textScaleFactor: 0.8,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Table(
                columnWidths: const <int, pw.TableColumnWidth>{
                  0: pw.FlexColumnWidth(.5),
                  1: pw.FlexColumnWidth(2),
                },
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    children: [
                      texto('Profesor', bold: true),
                      pw.Table(
                        columnWidths: const <int, pw.TableColumnWidth>{
                          0: pw.FlexColumnWidth(1.85),
                          1: pw.FlexColumnWidth(.5),
                          2: pw.FlexColumnWidth(.5),
                          3: pw.FlexColumnWidth(1),
                          4: pw.FlexColumnWidth(1),
                          5: pw.FlexColumnWidth(1),
                        },
                        defaultVerticalAlignment:
                            pw.TableCellVerticalAlignment.middle,
                        children: [
                          pw.TableRow(
                            children: [
                              texto('Materia', bold: true),
                              texto('Grado', bold: true),
                              texto('Grupo', bold: true),
                              texto('Dias de clase\nen el periodo', bold: true),
                              texto('Dias de clase\nreportados', bold: true),
                              texto('Porcentaje \nde asistencias', bold: true),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Table(
              border: pw.TableBorder.symmetric(
                inside: const pw.BorderSide(color: PdfColors.grey),
                outside: const pw.BorderSide(color: PdfColors.black),
              ),
              columnWidths: const <int, pw.TableColumnWidth>{
                0: pw.FlexColumnWidth(.5),
                1: pw.FlexColumnWidth(2),
              },
              defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
              children: datos(),
            ),
          ];
        },
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Text(
                  DateTime.now().toString().substring(0, 16),
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
                pw.Text(
                  'Reporte de Asistencias',
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
                pw.Text(
                  'Página ${context.pageNumber} de ${context.pagesCount}',
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf;
  }

  datos() {
    return [];
  }
}
