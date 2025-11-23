sealed class ApiResult<T> {
  const ApiResult();

  const factory ApiResult.success(T data) = SuccessResult;
  const factory ApiResult.failure(String error) = FailureResult;

  R when<R>({
    required R Function(T) success,
    required R Function(String) failure,
  }) {
    return switch (this) {
      SuccessResult(:final data) => success(data),
      FailureResult(:final error) => failure(error),
    };
  }
}

class SuccessResult<T> extends ApiResult<T> {
  final T data;
  const SuccessResult(this.data);
}

class FailureResult<T> extends ApiResult<T> {
  final String error;
  const FailureResult(this.error);
}