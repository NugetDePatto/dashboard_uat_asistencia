// var savedFile = await pdf.save();
// List<int> fileInts = List.from(savedFile);
// html.AnchorElement(
//     href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
//   ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
//   ..click();
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';
import 'dart:html' as html;

// import 'package:universal_html/html.dart';

class PDFServices {
  pw.Text texto(String text, {bold = false, center = true}) => pw.Text(
        text,
        textScaleFactor: .9,
        textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
        style: pw.TextStyle(
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      );

  pw.TableRow reporteEjemplo(profesor, key, reporte) {
    // print(reporte);
    double porcentaje = 0;

    for (var key in reporte.keys) {
      porcentaje += double.parse(reporte[key]['porcentaje']);
    }

    porcentaje = porcentaje / reporte.length;

    print('PORCENTAJE: $porcentaje');
    return pw.TableRow(
      children: [
        texto(key.toString().split('-')[1], center: false),
        pw.Table(
          columnWidths: const <int, pw.TableColumnWidth>{
            0: pw.FlexColumnWidth(1.85),
            1: pw.FlexColumnWidth(.5),
            2: pw.FlexColumnWidth(.5),
            3: pw.FlexColumnWidth(1),
            4: pw.FlexColumnWidth(1),
            5: pw.FlexColumnWidth(1),
          },
          defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
          children: [
            for (var k in profesor.keys)
              pw.TableRow(
                children: [
                  texto(k.toString(), center: false),
                  texto('-'),
                  texto(k.toString().split('-')[0], center: false),
                  texto(reporte[k]['total'].toString()),
                  texto(reporte[k]['asistencias'].toString()),
                  texto('${reporte[k]['porcentaje']}%', bold: true),
                ],
              ),
            pw.TableRow(
              children: [
                pw.Text(''),
                pw.Text(''),
                pw.Text(''),
                pw.Text(''),
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  height: 25,
                  child: texto(
                    'TOTAL:',
                    center: false,
                    bold: true,
                  ),
                ),
                //sumar todos los porcentajes de asistencias y sacar el promedio
                texto('${porcentaje.toStringAsFixed(2)}%', bold: true),
              ],
            ),
          ],
        ),
      ],
    );
  }

  crearPdf(reporte, total) {
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
                'Del: 20/02/2024 al 06/03/2024',
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
              children: [
                for (var key in total.keys)
                  reporteEjemplo(total[key], key, reporte[key]),
              ],
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
                  '24/04/2024 07:09:00 PM',
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

  ejemploPDF(reporte, total) async {
    print('ENTRO----------------------------');
    final pdf = crearPdf(reporte, total);
    print('ENTRO----------------------------');
    await guardarPDF(pdf);
    print('ENTRO----------------------------');
  }
}
