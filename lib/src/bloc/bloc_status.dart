enum Status { LOADING, ERROR, COMPLATED }

class BlocStatus<T> {
  Status status;
  T data;
  String message;

  BlocStatus.loading() : status = Status.LOADING;
  BlocStatus.error(this.message) : status = Status.ERROR;
  BlocStatus.complated(this.data) : status = Status.COMPLATED;

  @override
  String toString() {
    return "Status = $status \n Message = $message \n Data: $data";
  }
}
