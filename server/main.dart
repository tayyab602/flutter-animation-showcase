import 'dart:io';

late String _cachedHtml;

Future<void> main() async {
  _cachedHtml = await File('web/index.html').readAsString();

  final server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    5000,
  );

  print('Animation Showcase server running on http://0.0.0.0:5000');

  await for (final request in server) {
    final path = request.uri.path;
    request.response.headers.set('Cache-Control', 'no-store');

    if (path.startsWith('/assets/') && path.endsWith('.json')) {
      final fileName = path.split('/').last;
      final file = File('assets/$fileName');
      if (await file.exists()) {
        request.response.statusCode = 200;
        request.response.headers.contentType = ContentType.json;
        request.response.write(await file.readAsString());
      } else {
        request.response.statusCode = 404;
        request.response.write('Not found');
      }
    } else {
      request.response.statusCode = 200;
      request.response.headers.contentType = ContentType.html;
      request.response.write(_cachedHtml);
    }
    await request.response.close();
  }
}
