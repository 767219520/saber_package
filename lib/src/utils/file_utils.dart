import 'dart:io';

class FileUtils {
  static String getFileName(String path) {
    return getFileNameByPath(File(path));
  }

  static String getFileNameByPath(File file) {
    return file.path
        .replaceFirst(file.parent.path, "")
        .replaceAll("/", "")
        .replaceAll("\\", "");
  }

  static String getFileNameWithOutExt(String path) {
    String fileName = getFileName(path);
    return fileName.substring(0, fileName.lastIndexOf("."));
  }

  static String getExtendName(String path) {
    return path.substring(path.lastIndexOf(".") + 1);
  }
}
