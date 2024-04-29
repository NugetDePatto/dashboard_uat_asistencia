import 'dart:convert';
import 'package:universal_html/html.dart' as html;

class ArchivoRepositorie {
  void descargar(List lista, String nombre) {
    final jsonString = jsonEncode(lista);
    final blob = html.Blob([jsonString], 'application/json');
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '$nombre.json')
      ..style.display = 'none';

    html.document.body?.children.add(anchor);
    anchor.click();

    html.Url.revokeObjectUrl(url);
    anchor.remove();
  }
}
