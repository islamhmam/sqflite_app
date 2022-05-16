import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_note/main_screen/components/goal_item.dart';
import 'package:sqflite_note/main_screen/cubit/MainStates.dart';
import 'package:sqflite_note/main_screen/cubit/main_cubit.dart';

class MainScreen extends  StatelessWidget {
   MainScreen({Key? key}) : super(key: key);

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => MainCubit()..sqlInitial()..getAllCategory(),

      child:BlocConsumer<MainCubit,MainStates>(
        listener: (context, state) {

        },
        builder: (context1,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[900],
              title: const Center(
                child: Text('GOALS',
                style: TextStyle(
                  letterSpacing: 5,
                  fontSize: 38

                ),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(

                  child:ListView.builder
                    (
                      itemCount: MainCubit.get(context1).notesList.length,
                      itemBuilder: (context1, index) {

                        return noteItem(context1,index,
                          MainCubit.get(context1).notesList[index]["id"],
                          MainCubit.get(context1).notesList[index]["name"],

                        );
                      }),

                )

              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal,

              onPressed: (){
                showDialog(
                    barrierDismissible: true,
                    context: context1,
                    builder: (_) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0))),
                      content: Builder(
                        builder: (context) {

                          return Container(
                            height: 130,
                            // width: double.infinity/1.5,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue[900],
                                  width: double.infinity,
                                  height: 30,
                                  child: const Center(
                                    child: Text('Write Your Goal.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,

                                    ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 55,
                                  child: Form(
                                    key: formKey,
                                    child: TextFormField(

                                      controller: MainCubit.get(context1).nameOfNoteController,
                                      validator:(String? val) {
                                              if(val!.isEmpty){
                                                return 'Write your Goal';
                                              }
                                      },

                                      decoration: InputDecoration(
                                        label: Text('Write Here....'),
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior
                                            .never,
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(2),
                                        ),
                                        contentPadding: const EdgeInsets.all(8),


                                      ),


                                    ),
                                  ),
                                ),

                                Expanded(

                                  child: Align(
                                    alignment:  FractionalOffset.bottomCenter,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: (){
                                              if(
                                              formKey.currentState!.validate()
                                              ){
                                               MainCubit.get(context1)
                                                   .insertCategory(MainCubit.get(context1)
                                                   .nameOfNoteController.text.toString());

                                              MainCubit.get(
                                                   context1)
                                                   .nameOfNoteController
                                                   .text = "";



                                              MainCubit.get(
                                                   context1)
                                                   .getAllCategory();
                                               Navigator.pop(
                                                   context);

                                              }
                                            },
                                            child: Text('ADD'),
                                            style:ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.red),
                                            ) ,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: (){
                                              Navigator.pop(
                                                  context);
                                            },
                                            child: Text('CANCEL'),
                                            style:ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                                            ) ,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          );


                        },
                      ),
                    ));
              },
              child:  const Icon(Icons.add,
                size: 42,
                color: Colors.white,),

            ) ,
          );
        },
      ),
    );
  }
}
