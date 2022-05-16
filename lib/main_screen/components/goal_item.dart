import 'package:flutter/material.dart';
import 'package:sqflite_note/main_screen/cubit/main_cubit.dart';

Widget noteItem(context1, index ,int id, name){

  return  InkWell(
    child:   Container(

      height: 80,

      width: double.infinity,

      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.blue[900]!,
          ]
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(
              2,2
              ),
            blurRadius: 5,
          )
        ]


      ),

      child: Center(

        child: Text('$id : $name',

          style: const TextStyle(
              fontSize: 18,
            color: Colors.white,

          ),

        ),

      ),

    ),
    onTap: (){
      showDialog(
          barrierDismissible: true,
          context: context1,
          builder: (_) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0))),
            content: Builder(
              builder: (context) {
                MainCubit.get(context1).nameOfNoteEditController.text=name;
                return Container(
                  height: 160,
                  // width: double.infinity/1.5,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue[900],
                        width: double.infinity,
                        height: 30,
                        child: const Center(
                          child: Text('Editting',
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
                        child: TextFormField(

                          controller: MainCubit.get(context1).nameOfNoteEditController,
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

                      Expanded(

                        child: Align(
                          alignment:  FractionalOffset.bottomCenter,
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: (){
                                        MainCubit.get(context1).updateCategory(
                                            MainCubit.get(context1).nameOfNoteEditController.text.toString(),
                                            id);
                                        Navigator.pop(
                                            context);
                                        MainCubit.get(context1).getAllCategory();


                                  },
                                  child: Text('Edit'),
                                  style:ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                                  ) ,
                                ),
                              ),
                              SizedBox(width: 5,),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: (){
                                   MainCubit.get(context1).deleteCategory(id);
                                   Navigator.pop(
                                       context1);
                                   MainCubit.get(
                                       context1)
                                       .getAllCategory();
                                  },
                                  child: Text('REMOVE'),
                                  style:ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                                  ) ,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(

                                onPressed: (){

                                  Navigator.pop(
                                      context1);

                                },
                                child: Text('Cancel'),
                                style:ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.green),
                                ) ,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );


              },
            ),
          ));
    },
  );
}