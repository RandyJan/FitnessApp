import 'dart:ffi';

import 'package:bar_graph/flutter_package_test_1.dart';
import 'package:bar_graph/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';



TextEditingController controller1 = TextEditingController(); 
TextEditingController controller2 = TextEditingController();
TextEditingController genderCont = TextEditingController();
TextEditingController ageCont = TextEditingController();
List<GraphModel> graphModelList = [];
String height = "0";
int weight = 0;
String output = "0";
String bmiRead = "";
int choices = 0;
String userHeight = "cm";
String gender = "0";
int age = 0;
double bodyFat = 0;
double muscleMass = 0;
String userWeight = "kg";
String? _errorText;
String errorTest = "0";
String appbarTitle = "BMI Calculator";
Color indication = Colors.transparent;
Image bodyType = Image.asset("images/weight-loss.png",fit:BoxFit.fill);
int currentPageIndex = 0;
List<String> aaa = [];
List<Widget> currentPageLayout = [
  const BMICalculator(),
  const CalorieCalculator()
];

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
   MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    largestValue = 0;
    
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        
        backgroundColor: Colors.blue.shade300,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(appbarTitle, style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: currentPageLayout[currentPageIndex],
      
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.add_business_outlined),label: "bmi"),
         BottomNavigationBarItem(icon: Icon(Icons.add_home_rounded),label: "calorie")
      ],
      currentIndex: currentPageIndex,
      onTap: (a) {
      // graphModelList.add(GraphModel(dateData: dateData, valueData: valueData, colorData: colorData));
      
      // for(var item in graphModelList)
      // {
      //    var itemValue = item.valueData;
      //     if(itemValue > largestValue)
      //     {
      //         setState((){
      //             largestValue = itemValue;
      //         });
      //     }
      // }
      
        setState(() {
          currentPageIndex = a;
           a == 0 ? appbarTitle = "BMI Calculator" : appbarTitle = "Calorie Calculator";
        });
        print(appbarTitle);
      },),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
void _validateInput(){
  String inputText = controller1.text.trim();
  if(inputText.isEmpty){
    _errorText = "Please enter height";
  }
  else if(inputText.contains(RegExp(r'[A-Z]')) || inputText.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
    _errorText = "Please enter digits only";
    // return;
  }
  else{
    _errorText = null;
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.blue.shade300,
          Colors.black45,
        ],
      ),
          ),
          // width: 200,
          // height: 500,16
          // decoration: BoxDecoration(border: Border.all(width: 2)),
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             
            
              Text("Height",style: TextStyle(color: Colors.white,fontSize: 20)),
              Container(
               height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white24),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black38
                  ),
                child: TextField(
                  
                  cursorErrorColor: Colors.amber,
                  style: TextStyle(color: Colors.white),
                  controller: controller1,
                  onChanged: (t){
                    
                    if((t.contains(RegExp(r'[A-Z]')) || t.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) && choices == 0){
   setState(() {
     errorTest = "1";
    _errorText = "Please enter digits only";
   });
    // return;
  }
  else{
    setState(() {
      
    _errorText = null;
    });
  }
                    setState(() {
                      if(choices == 0){
                      t == "" ? height = "0" :
                      height = t;
                      }
                      else{
                         t == "" ? height = "0" :
                      height = t;
                      }
                    });
                    
                  },
                  //  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(border: InputBorder.none,hintText:userHeight,
                   hintStyle: TextStyle(color: Colors.white,fontSize: 18),  ),
                  ),
              ),
              Text("Weight",style: TextStyle(color: Colors.white,fontSize: 20)),
             Container(
              height: 54,
               margin: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white24),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black38
                  ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: controller2,
                  onChanged: (t){
                    setState(() {
                      if(t == "")
                      {
                        weight = 0;
                      }
                      else
                      {
                        weight = int.parse(t);
                      }
                    });
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(border: InputBorder.none, hintText: userWeight,
                  hintStyle: TextStyle(color: Colors.white,fontSize: 18))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(

                  width: 150,
   decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white30),borderRadius: BorderRadius.circular(20),color: Colors.black38),
                  child: TextField(style:TextStyle(color: Colors.white),controller:genderCont, onChanged:(g)  {
                    g = g.toLowerCase();
                    if(g == "m" || g == "male" || g == "boy" || g == "lalaki"){
                      gender = "1";
                    }
                    else if(g == "f"  || g == "female" || g == "girl" || g == "babae"){
                      gender = "2";
                    }
                    else{
                      return;
                    }
                    
                  },decoration: InputDecoration(hintText: "gender",hintStyle: TextStyle(color: Colors.white,fontSize: 18), border: InputBorder.none,), textAlign: TextAlign.center),
               
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white30),borderRadius: BorderRadius.circular(20),color: Colors.black38),
                  child: TextField(keyboardType:TextInputType.number,style:TextStyle(color: Colors.white), controller:ageCont,onChanged: (a){
                    age = a == "" || age.isNaN || age.toString().contains(',') || age.toString().contains('.')  ? 0:int.parse(a);
                  } ,decoration: InputDecoration(hintText: "age",hintStyle: TextStyle(color: Colors.white,fontSize: 18),border: InputBorder.none), textAlign: TextAlign.center,),
                )],
              ),
              Container(
                
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(20,20,20,20),
                
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), 
                color: Colors.deepPurple,),
                child: GestureDetector(onTap: (){
                   String inputText = controller1.text.trim();
  if(inputText.isEmpty){
   setState(() {
     
    _errorText = "Please enter height";
   });
  }
  else if(inputText.contains(RegExp(r'[A-Z]')) || inputText.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
   setState(() {
     
    _errorText = "Please enter digits only";
   });
    // return;
  }
  else{
    setState(() {
      
    _errorText = null;
    });
  }
                  // _validateInput();
                  setState(() {
                    if(choices == 0){
                 output = (weight / ((int.parse(height)/100) * (int.parse(height)/100))).toStringAsFixed(2);
                 var muscleWeight = (int.parse(height) * int.parse(height)*1.1)/double.parse(output);
                 muscleMass =(muscleWeight / weight);
                  if(gender == "1"){
                    bodyFat =(1.2 * double.parse(output)) + (0.23 * age) - (10.08 * 1) - 5.4;
                  }
                else if(gender == "2"){
                    bodyFat =(1.2 * double.parse(output)) + (0.23 * age) - (10.08 * 0) - 5.4;
                  }
                  else{
                    return;
                  }
                 }
                 else{
                 var heightval = height.split("'");
                 var left = int.parse(heightval[0]) * 12;
                 var inches = left + int.parse(heightval[1]);
                 var inchtocm = inches * 2.54;
                 var poundtokg = weight*0.453592;
                  output = ((weight/(inches * inches)) *703).toStringAsFixed(2);
                  
                  print((double.parse(output)).toInt());
                 var muscleWeight = ((double.parse(inchtocm.toString()) * double.parse(inchtocm.toString()))*1.1)/double.parse(output);
                 muscleMass = muscleWeight / poundtokg;
                  if(gender == "1"){
                    bodyFat =(1.2 * double.parse(output)) + (0.23 * age) - (10.08 * 1) - 5.4;
                  }
                else if(gender == "2"){
                    bodyFat =(1.2 * double.parse(output)) + (0.23 * age) - (10.08 * 0) - 5.4;
                  }
                  else{
                    return;
                  }
                 }
                    if( double.parse(output) < 18.5){
                      indication = Colors.blue.shade400;
                      bodyType = Image.asset("images/weight-loss.png",fit:BoxFit.fill);
                      bmiRead = "Underweight";
                    }
                    else if(double.parse(output) >= 18.5 && double.parse(output) <= 24.9){
                      indication = Colors.green.shade400;
                      bodyType = Image.asset("images/muscle.png",fit:BoxFit.fill);
                      bmiRead = "Normal";

                    }
                    else if(double.parse(output) > 24.9 && double.parse(output) <= 39.9){
                      indication = Colors.orange.shade400;
                      bodyType = Image.asset("images/fat.png",fit:BoxFit.fill);
                      bmiRead = "Overweight";

                    }
                    else{
                      if(output == " " || output == "NaN"){
                        return;
                      }
                      else{
                      indication = Colors.red.shade400;
                      bodyType = Image.asset("images/hungry.png",fit:BoxFit.fill);
                      bmiRead = "Obese";
                      }
                    }
                });
                }, child: Text("Compute",style: TextStyle(color: Colors.white)),),
              ),
              Container(
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(30), 
                color: Colors.green.shade400,)
                 
              ),
            SizedBox(height: 10,),
              Text( "Your BMI is $output",style: TextStyle(color: Colors.white)),
              Text(bmiRead, style: TextStyle(color: indication),),
          //     Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
          // AnimatedContainer(decoration:BoxDecoration(border: Border.all(width: 1),color: Colors.black12),  duration: Duration(seconds: 5), curve: Curves.bounceIn, height: 400,width:220, padding: EdgeInsets.all(60.20), child: AnimatedContainer(duration: Duration(seconds: 5),child:bodyType),),
          //    Container(
          //     height: 400,
          //    child: Column(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       Text("Obese",style: TextStyle(color: Colors.white),),
          //       Text("",style: TextStyle(color: Colors.white)),
          //       Text("",style: TextStyle(color: Colors.white)),
          //       Text("Underweight",style: TextStyle(color: Colors.white)),
        
          //     ]
          //    ),),
            
          //     Container(
          //       height: 400,
          //       width: 20,
          //       margin: EdgeInsets.only(right: 20),
          //       decoration: BoxDecoration(border: Border.all(width: 1)),
          //       alignment: Alignment.bottomRight,
          //       child: AnimatedContainer(duration:Duration(seconds: 1),
          //       height: output == "0" ? 0:
          //       ((400/30)* (double.parse(output) -6.6)),width: 50,
          //       color:indication,),
          //     )
        
          //     ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Container( 
            width: 150,
            child: 
                    RadioListTile(
                      contentPadding: EdgeInsets.all(0),
              title: Text("Metric tons",style: TextStyle(fontSize: 14,color: Colors.white),),
              value: 0, 
             groupValue: choices,

              onChanged: (int ? value){
                  setState(() {
                    choices = value!;
                      output = "0";
                    bmiRead = "";
                        controller1.text = "";
                    controller2.text ="";
                    userHeight = "cm";
                    userWeight = "kg";
                  });
              }),),
              Container( 
            width: 150,
            child: 
                    RadioListTile(
                      contentPadding: EdgeInsets.all(0),
              title: Text("Standard",style: TextStyle(fontSize: 14,color: Colors.white),),
              value: 1, 
             groupValue: choices,
              onChanged: (int ? value){
                  setState(() {
                    output = "0";
                    bmiRead = "";
                    controller1.text = "";
                    controller2.text ="";
                    choices = value!;
                    userHeight = "feet";
                    userWeight = "lbs";
                  });
              }),),
          ],),
                Text("Diagnosis",style: TextStyle(color: Colors.white),),
                SizedBox(height: 20,),
                
                     Container(
                       child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                 AnimatedContainer(decoration:BoxDecoration(border: Border.all(width: 1,color: Colors.white38),color: Colors.black38),  duration: Duration(seconds: 5), curve: Curves.bounceIn, height: 200,width:170, padding: EdgeInsets.all(10), child: AnimatedContainer(duration: Duration(seconds: 5),child:bodyType),),
                                 Row(
                                   
                                   children: [
                                    Container(
                                     height: 200,
                                    child: Column(
                                     mainAxisSize: MainAxisSize.max,
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Text("Obese",style: TextStyle(color: Colors.white),),
                                       Text("",style: TextStyle(color: Colors.white)),
                                       Text("",style: TextStyle(color: Colors.white)),
                                       Text("Underweight",style: TextStyle(color: Colors.white)),
                               
                                     ]
                                    ),
                                    
                                    ),
                                          Container(
                                       height: 200,
                                       width: 20,
                                       margin: EdgeInsets.only(right: 20),
                                       decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white38)),
                                       alignment: Alignment.bottomRight,
                                       child: AnimatedContainer(duration:Duration(seconds: 1),
                                       height: output == "0" ? 0:
                                       ((200/30)* (double.parse(output) -6.6)),width: 50,
                                       color:indication,),
                                     )])
                                    ]),
                     ),
                     
            Container(
              height: 100,
              width: 400,
             child:Text( bodyFat == 0 && muscleMass == 0 ? "" :"Your body consist of ${bodyFat.toStringAsFixed(2)}% fat and ${muscleMass.toStringAsFixed(2)}% of lean muscles",style: TextStyle(color: Colors.white),)
              )
            ],
          ),
        ),
      );
  }
}

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({super.key});

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return 
      SingleChildScrollView(
        child: Container(
            height: size.height,
            padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade300,
            Colors.black45,
          ],
        ),),
        child: Column(children: [
          Container(width: size.width,
          child: BarGraph(graphData: graphModelList, largestValue: largestValue, backgroundColor: Colors.black38, textColor: Colors.white, graphHeight: 200),)
        ,
        SizedBox(
          width: size.width*0.9,
          child: Flex(direction: Axis.horizontal, mainAxisSize: MainAxisSize.max,  children: [
            Container(width: 220,
            height: 350,
            decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white24)),
              child: Flex(direction: Axis.vertical, mainAxisSize: MainAxisSize.max,  children: [
                Container(
                  width: 250,
                    decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white24),color: Colors.black38),
                  child: TextField( style: TextStyle(color: Colors.white24,  ),
                   decoration:InputDecoration(hintText: "Enter product",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 21,)), 
                    textAlign: TextAlign.center,
                    cursorColor: Colors.deepPurple,

                  ),
                ),
                Container(width: 250,height: 298,decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white24),color: Colors.black38),)
              ],),
            ),
            Container(width: 210,height: 350,decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white24),color:Colors.black38)
            ,child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Product:  \n \n Calories: \n \n Carbs: \n \n  Fats: ",style: TextStyle(fontSize: 21,color: Colors.white),),
            Container(width: 200,height: 60,alignment:Alignment.center, decoration: BoxDecoration(border: Border.all(width:1,),borderRadius: BorderRadius.circular(50),color: Colors.deepPurple),child: Text("+ ADD",style: TextStyle(color: Colors.white,fontSize: 21),),)],),)
          ],),
        ),
        SizedBox(height: 15,),
        Text("2500",style: TextStyle(fontSize: 50,color: Colors.white,fontWeight:FontWeight.w600),
        ),
        Text("Total Calories",style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight:FontWeight.w600),
        )
        // Flex(direction: Axis.horizontal,
        // children: [
        //    Flex(direction:Axis.vertical,
        //    children:[Container( decoration: BoxDecoration(color: Colors.red),

        //   child: TextField(),),
        //   Container( decoration: BoxDecoration(color: Colors.pink),
        //   child: Container(decoration: BoxDecoration(color: Colors.yellow),),)])
        //     ,

        // ],),
        
        ],),
        ),
      );
   
  }
}