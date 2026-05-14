import 'dart:ffi';

import 'dart:io';

import 'package:ffi/ffi.dart';

typedef NativeStudentDetails = Void Function(Pointer<Utf8>, Int32, Float);

typedef DartStudentDetails = void Function(Pointer<Utf8>, int, double);

typedef NativePrintNames = Void Function(Pointer<Pointer<Utf8>>, Int32);

typedef DartPrintNames = void Function(Pointer<Pointer<Utf8>>, int);

void main() {
  final dylib = DynamicLibrary.open('./libapp.so');

  final printStudentDetails =
      dylib
          .lookup<NativeFunction<NativeStudentDetails>>('printStudentDetails')
          .asFunction<DartStudentDetails>();

  final printNames =
      dylib
          .lookup<NativeFunction<NativePrintNames>>('printNames')
          .asFunction<DartPrintNames>();

  print("How many names?");
  final n = int.parse(stdin.readLineSync()!);

  final namesPtr = malloc.allocate<Pointer<Utf8>>(n);

  for (int i = 0; i < n; i++) {
    print("Enter name $i:");
    final name = stdin.readLineSync()!;

    namesPtr[i] = name.toNativeUtf8();
  }

  printNames(namesPtr, n);

  for (int i = 0; i < n; i++) {
    malloc.free(namesPtr[i]);
  }

  malloc.free(namesPtr);

  print("Enter name:");
  final name = stdin.readLineSync()!;

  print("Enter age:");
  final age = int.parse(stdin.readLineSync()!);

  print("Enter height:");
  final height = double.parse(stdin.readLineSync()!);

  final namePointer = name.toNativeUtf8();

  printStudentDetails(namePointer, age, height);

  malloc.free(namePointer);
}
