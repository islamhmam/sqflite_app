class MainStates {}

class InitMainState extends MainStates{}
class OpenDataState extends MainStates{}
class GetDataSuccessState extends MainStates{}
class GetDataLoadingState extends MainStates{}
class GetDataErrorState extends MainStates{
  String error;
  GetDataErrorState(this.error);
}

class InsertDataSuccessState extends MainStates{}
class InsertDataLoadingState extends MainStates{}
class InsertDataErrorState extends MainStates{
  String error;
  InsertDataErrorState(this.error);
}

class DeleteDataSuccessState extends MainStates{}
class DeleteDataLoadingState extends MainStates{}
class DeleteDataErrorState extends MainStates{
  String error;
  DeleteDataErrorState(this.error);
}

class UpdateDataSuccessState extends MainStates{}
class UpdateDataLoadingState extends MainStates{}
class UpdateDataErrorState extends MainStates{
  String error;
  UpdateDataErrorState(this.error);
}



class SelectedIndexState extends MainStates{}