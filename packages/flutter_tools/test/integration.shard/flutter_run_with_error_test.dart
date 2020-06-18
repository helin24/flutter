// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:file/file.dart';
import 'package:flutter_tools/src/base/file_system.dart';

import '../src/common.dart';
import 'test_data/project_with_early_error.dart';
import 'test_driver.dart';
import 'test_utils.dart';

void main() {
  Directory tempDir;
  final ProjectWithEarlyError _project = ProjectWithEarlyError();
  FlutterRunTestDriver _flutter;

  setUp(() async {
    tempDir = createResolvedTempDirectorySync('run_test.');
    await _project.setUpIn(tempDir);
    _flutter = FlutterRunTestDriver(tempDir);
  });

  tearDown(() async {
    await _flutter.stop();
    tryToDelete(tempDir);
  });

  test('flutter run reports an early error in an application', () async {
    final StringBuffer stdout = StringBuffer();
    _flutter.stdout.listen(stdout.writeln);

    await _flutter.run(startPaused: true, withDebugger: true, structuredErrors: true);
    await _flutter.resume();
    await _flutter.stop();

    expect(stdout.toString(), contains('══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞══════════════════'));
  }, skip: 'working on other test');

  test('flutter run for web reports an early error in an application', () async {
    final StringBuffer stdout = StringBuffer();
    _flutter.stdout.listen(stdout.writeln);

    await _flutter.run(startPaused: true, withDebugger: true, structuredErrors: true, chrome: true);
    await _flutter.resume();
    await _flutter.stop();

    print(stdout);

//    expect(stdout.toString(), contains('══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞══════════════════'));
  });
}
