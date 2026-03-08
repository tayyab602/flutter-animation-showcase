import 'dart:io';

Future<void> main() async {
  final server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    5000,
  );

  print('Server running on http://0.0.0.0:5000');

  await for (final request in server) {
    request.response.statusCode = 200;
    request.response.headers.contentType = ContentType.html;
    request.response.headers.set('Cache-Control', 'no-store');
    request.response.write(_htmlContent);
    await request.response.close();
  }
}

const String _htmlContent = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Flutter Counter</title>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    :root {
      --primary: #6750A4;
      --on-primary: #FFFFFF;
      --primary-container: #EADDFF;
      --on-primary-container: #21005D;
      --surface: #FEF7FF;
      --on-surface: #1D1B20;
      --surface-container: #F3EDF7;
      --surface-container-high: #ECE6F0;
      --outline: #79747E;
    }

    @media (prefers-color-scheme: dark) {
      :root {
        --primary: #D0BCFF;
        --on-primary: #381E72;
        --primary-container: #4F378B;
        --on-primary-container: #EADDFF;
        --surface: #141218;
        --on-surface: #E6E0E9;
        --surface-container: #211F26;
        --surface-container-high: #2B2930;
        --outline: #938F99;
      }
    }

    body {
      font-family: 'Roboto', sans-serif;
      background-color: var(--surface);
      color: var(--on-surface);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .app-bar {
      background-color: var(--surface);
      color: var(--on-surface);
      padding: 16px 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      box-shadow: 0 1px 3px rgba(0,0,0,0.12);
    }

    .app-bar h1 {
      font-size: 22px;
      font-weight: 400;
      letter-spacing: 0;
    }

    .app-bar .reset-btn {
      position: absolute;
      right: 8px;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      color: var(--on-surface);
      cursor: pointer;
      width: 48px;
      height: 48px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: background-color 0.2s;
    }

    .app-bar .reset-btn:hover {
      background-color: var(--surface-container-high);
    }

    .content {
      flex: 1;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 24px;
    }

    .subtitle {
      font-size: 16px;
      color: var(--on-surface);
      opacity: 0.8;
      margin-bottom: 16px;
    }

    .counter-display {
      font-size: 96px;
      font-weight: 700;
      color: var(--primary);
      line-height: 1;
      margin-bottom: 32px;
      transition: transform 0.15s ease;
      user-select: none;
    }

    .counter-display.bump {
      transform: scale(1.15);
    }

    .button-row {
      display: flex;
      gap: 16px;
      align-items: center;
    }

    .fab {
      border: none;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.2s ease;
      box-shadow: 0 3px 5px -1px rgba(0,0,0,0.2),
                  0 6px 10px 0 rgba(0,0,0,0.14),
                  0 1px 18px 0 rgba(0,0,0,0.12);
    }

    .fab:hover {
      box-shadow: 0 5px 5px -3px rgba(0,0,0,0.2),
                  0 8px 10px 1px rgba(0,0,0,0.14),
                  0 3px 14px 2px rgba(0,0,0,0.12);
    }

    .fab:active {
      transform: scale(0.95);
    }

    .fab-normal {
      width: 56px;
      height: 56px;
      border-radius: 16px;
      background-color: var(--primary-container);
      color: var(--on-primary-container);
    }

    .fab-large {
      width: 96px;
      height: 96px;
      border-radius: 28px;
      background-color: var(--primary-container);
      color: var(--on-primary-container);
    }

    .fab-normal .material-icons {
      font-size: 24px;
    }

    .fab-large .material-icons {
      font-size: 36px;
    }

    .platform-badge {
      position: fixed;
      bottom: 16px;
      left: 50%;
      transform: translateX(-50%);
      background-color: var(--surface-container-high);
      color: var(--on-surface);
      padding: 8px 16px;
      border-radius: 20px;
      font-size: 12px;
      opacity: 0.7;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .dot {
      width: 6px;
      height: 6px;
      border-radius: 50%;
      background-color: #4CAF50;
    }
  </style>
</head>
<body>
  <div class="app-bar">
    <h1>Flutter Counter</h1>
    <button class="reset-btn" onclick="resetCounter()" title="Reset counter">
      <span class="material-icons">refresh</span>
    </button>
  </div>

  <div class="content">
    <p class="subtitle">You have pushed the button this many times:</p>
    <div class="counter-display" id="counter">0</div>
    <div class="button-row">
      <button class="fab fab-normal" onclick="decrement()" title="Decrement">
        <span class="material-icons">remove</span>
      </button>
      <button class="fab fab-large" onclick="increment()" title="Increment">
        <span class="material-icons">add</span>
      </button>
    </div>
  </div>

  <div class="platform-badge">
    <span class="dot"></span>
    Flutter Counter App &bull; Dart Web Preview
  </div>

  <script>
    let counter = 0;
    const display = document.getElementById('counter');

    function updateDisplay() {
      display.textContent = counter;
      display.classList.add('bump');
      setTimeout(() => display.classList.remove('bump'), 150);
    }

    function increment() {
      counter++;
      updateDisplay();
    }

    function decrement() {
      counter--;
      updateDisplay();
    }

    function resetCounter() {
      counter = 0;
      updateDisplay();
    }
  </script>
</body>
</html>
''';
