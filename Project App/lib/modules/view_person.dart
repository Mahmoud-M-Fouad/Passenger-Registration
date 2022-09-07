import 'package:flutter/material.dart';

import '../shared/component/db.dart';
var cousrelist;
class ViewPerson extends StatelessWidget {
  const ViewPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool i =false;
    void showToast(BuildContext context) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(

        const SnackBar(

          content: Text('لا يوجد أى درس هذا اليوم' , style: TextStyle(color: Colors.red),),
        ),
      );
    }

    return Column(
      children: [
        IconButton(onPressed: ()
        async{
          cousrelist =  await allPassenger();
          print(cousrelist);
        }, icon: Icon(Icons.add)),
        cousrelist?.isEmpty ==null?Container():
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context , index)
          {
            return  bulidContainerCourse(index);
          },
          separatorBuilder: (context , index)
          {
            return const SizedBox(height: 10,);
          },
          itemCount: cousrelist.length,
          // shrinkWrap: true,

        )
      ],
    );
  }
}


Widget bulidContainerCourse(int index)
{
  return Padding(
    padding: const EdgeInsets.only(right: 10 , left: 15 , top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            height:800,
            width: double.infinity,
            decoration:  BoxDecoration(
              color: Colors.teal.shade400,
              borderRadius: const BorderRadius.all(
                  Radius.circular(15) //                 <--- border radius here
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${cousrelist[index].name}' , style: const TextStyle(color: Colors.amber , fontSize: 25),),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 100,
                    child: Image.asset('image/open-book.png',height: 100,width: 100,),
                  ),
                ),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text:   TextSpan(
                          children: [
                            const TextSpan(
                              text: "رقم الهاتف ", style: TextStyle(color: Colors.amber , fontSize: 15),
                                    ),
                            TextSpan(

                              text:" ${cousrelist[index].address}", style: TextStyle(color: Colors.amber , fontSize: 15),
                            ),
                          ]
                      ),
                    ),

/*
                    const Divider(height: 5,color: Colors.red,),



                    const Divider(height: 5,color: Colors.red,),
                    const Text(':  العنوان  ' , style: TextStyle(color: Colors.amber , fontSize: 15),),
                    Text('${cousrelist[index].address}' , style: const TextStyle(color: Colors.amber , fontSize: 25),),

                    const Divider(height: 5,color: Colors.red,),
                    const Text(':  العمر  ' , style: TextStyle(color: Colors.amber , fontSize: 15),),
                    Text('${cousrelist[index].age}' , style: const TextStyle(color: Colors.amber , fontSize: 25),),

                    const Divider(height: 5,color: Colors.red,),
                    const Text(':  المؤهل  ' , style: TextStyle(color: Colors.amber , fontSize: 15),),
                    Text('${cousrelist[index].job}' , style: const TextStyle(color: Colors.amber , fontSize: 25),),

                    const Divider(height: 5,color: Colors.red,),
                    const Text(':  البلد المسافر لها  ' , style: TextStyle(color: Colors.amber , fontSize: 15),),
                    Text('${cousrelist[index].country}' , style: const TextStyle(color: Colors.amber , fontSize: 25),),

                    const Divider(height: 5,color: Colors.red,),
                    const Text(':  الفلوس ' , style: TextStyle(color: Colors.amber , fontSize: 15),),
                    Text('${cousrelist[index].money}' , style: const TextStyle(color: Colors.amber , fontSize: 25),),

                    const Divider(height: 5,color: Colors.red,),
                    const Text(':  الملاحظات ' , style: TextStyle(color: Colors.amber , fontSize: 15),),
                    Text('${cousrelist[index].notes}' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
*/
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.delete),color: Colors.red.shade300,),
                    const SizedBox(width: 30,),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.update)),
                  ],
                )

                /*
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                   // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //name
                      //    const Text('Course  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),

                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),
      /*
                      //phone
                      Row(
                        children: [
                          Image.asset('image/presentation.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                          //const Text('Teacher  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].phone} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),
                      //address
                      Row(
                        children: [
                          Image.asset('image/calendar.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                          //const Text('Day  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].address} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),
                      //age
                      Row(
                        children: [
                          Image.asset('image/clock.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                          //const Text('Hour  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].age} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),
                      //job
                      Row(
                        children: [
                          Image.asset('image/phone-call.png',height: 70,width: 70,),
                          const SizedBox(width: 25,),
                          //const Text('Phone  :  ' , style: TextStyle(color: Colors.black , fontSize: 25),),
                          Text('${cousrelist[index].job} ' , style: const TextStyle(color: Colors.amber , fontSize: 25),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(height: 3,color: Colors.deepPurple,),
                      const SizedBox(height: 10,),
                      //country
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${cousrelist[index].id} ' , style: const TextStyle(color: Colors.black , fontSize: 25),),
                        ],
                      ),
*/
                    ],
                  ),

                  */
              ],
            ),
          ),
        ),

      ],
    ),
  );
}