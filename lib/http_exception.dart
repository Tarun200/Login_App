class HttpException implements Exception
{
  final String messasge;
  HttpException(this.messasge);
  @override
  String toString() {
    // TODO: implement toString
    return messasge;
  }
}