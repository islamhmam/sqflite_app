import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_note/main_screen/cubit/MainStates.dart';

class MainCubit extends Cubit<MainStates>{
  MainCubit() : super(InitMainState());

  static MainCubit get(context)=> BlocProvider.of(context);

  var nameOfNoteController = TextEditingController();
  var nameOfNoteEditController = TextEditingController();

  int? selectedIndex;

  List<Map> notesList=[];

  sqlInitial() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
    await db.execute('''
      CREATE TABLE Test (
      id INTEGER PRIMARY KEY,
      name TEXT
      )
  ''');
    });
    emit(OpenDataState());
    // await db.close();
  }

  insertCategory(nameOfCategory) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database db = await openDatabase(path);


      await db.rawInsert(
          'INSERT INTO Test(name) VALUES("$nameOfCategory")');



    emit(InsertDataSuccessState());
    await db.close();
  }

  getAllCategory() async {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database db = await openDatabase(path);
    await db.query('Test').then((value) {
      notesList = value;
      emit(GetDataSuccessState());
      selectedIndex = null;
    }).catchError((onError) {
      emit(GetDataErrorState(onError.toString()));
      print(onError);
    });

    //
    // notesList = await db.rawQuery('SELECT * FROM Test');
    // List<Map> expectedList = [
    //   {'name': 'updated name'},
    //   {'name': 'another name'}
    // ];
    // print(notesList);
    // print(expectedList);
    // emit(GetDataSuccessState());
    await db.close();
  }

  selectItem(index) {
    selectedIndex = index;
    emit(SelectedIndexState());
  }

  deleteCategory(int id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database db = await openDatabase(path);
    await db
        .rawDelete(
        "DELETE FROM Test WHERE id = ${id} ")
        .then((value) {
      print(value.toString());
      emit(DeleteDataSuccessState());
      selectedIndex = null;
    }).catchError((onError) {
      print(onError.toString());
      emit(DeleteDataErrorState(onError.toString()));
    });
    await db.close();
  }



  updateCategory(name,  id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    Database db = await openDatabase(path);
    await db.rawUpdate(
        ' UPDATE Test SET name = ? WHERE id = ? ',
        [name, id]).then((value) {
      print(value.toString());
      emit(UpdateDataSuccessState ());
      selectedIndex = null;
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateDataErrorState(onError.toString()));
    });
    await db.close();
  }


}