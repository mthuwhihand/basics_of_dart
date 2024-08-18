interface class ResponseResult<T> {
  const ResponseResult();
}

class Success<T> extends ResponseResult<T> {
  final T data;

  Success(this.data);
}

class Failure<T> extends ResponseResult<T> {
  final String message;

  Failure(this.message);
}
