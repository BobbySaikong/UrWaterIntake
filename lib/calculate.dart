import 'package:flutter/material.dart';
import 'package:water_intake_calculator/main.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

void main() {

runApp(MaterialApp(home: Splashscreen(),));
  
}

class _MainAppState extends State<MainApp> {

  //initialize items for dropdownbutton temperature
  List<DropdownMenuItem<String>> temperature = [
    DropdownMenuItem<String>(value: 'Hot', child: Text('Hot')),
    DropdownMenuItem<String>(value: 'Cold', child: Text('Cold')),
  ];
  List<DropdownMenuItem<String>> activitylevel = [
    DropdownMenuItem<String>(value: 'Sedentary', child: Text('Sedentary')),
    DropdownMenuItem<String>(value: 'Active', child: Text('Active')),
  ];
//initialize items for dropdownbutton temperature
//initialize initialvalue for dropdown button and calculation variable
  String selectedvalue1 = 'Hot';
  double extraintake1 = 0;
  String selectedvalue2 = 'Sedentary';
  double extraintake2 = 0;
  double miminumwaterintake = 2.0;
  double totalwaterintake = 0;
  String totalwatervalue = '0';
//controller for recieving textfieldform input
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController totalwaterintake_controller = TextEditingController();
  final textformfieldkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(//appbar title
          title: Center(child: Text('Ur WaterIntake!',style: TextStyle(fontStyle: FontStyle.italic),)),
          backgroundColor: Colors.blueGrey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 300,
                  child: Form(
                    key: textformfieldkey,
                    child: TextFormField(
                      //forceErrorText: 'Please input the weight correctly.',
                      controller: weightcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        //errorText: 'Fill in bro',
                        hintText: 'e.g; 50.90',
                        icon: Icon(Icons.monitor_weight),
                        border: OutlineInputBorder(),
                        label: Text('Enter weight(Kg)'),
                      ),
                      validator: (value) {
                        if (double.tryParse(value!) == null) {
                          return 'please enter valid number.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select temperature:            Select activity level:'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),

                    child: SizedBox(
                      height: 60,
                      width: 130,
                      //dropdown button for temperature
                      child: DropdownButton(
                        value: selectedvalue1,
                        items: temperature,
                        onChanged: (newvalue1) => {
                          setState(() {
                            selectedvalue1 = newvalue1!;
                          }),
                        },
                        icon: Icon(Icons.thermostat),
                        iconSize: 50,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                    child: SizedBox(
                      height: 60,
                      width: 130,
                      //dropdown button for activity level
                      child: DropdownButton(
                        value: selectedvalue2,
                        items: activitylevel,
                        onChanged: (newvalue2) => {
                          setState(() {
                            selectedvalue2 = newvalue2!;
                          }),
                        },
                        icon: Icon(Icons.man, size: 50),
                      ),
                    ),
                  ),
                ],
              ),
              //calculate button
              ElevatedButton(
                onPressed: () {
                  if (textformfieldkey.currentState!.validate()) {
                    setState(() {
                      totalwaterintake_controller.text = calculateWater(
                        weightcontroller,
                        selectedvalue1,
                        selectedvalue2,
                      ).toStringAsFixed(2);
                    });
                  }
                },
                child: Text('Calculate Recommended Intake'),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('WATER INTAKE RECOMMENED (Liters)'),
              ),

            //recommennded water intake field
              TextFormField(
                readOnly: true,
                controller: totalwaterintake_controller,
                onChanged: (newvalue3) => {
                  setState(() {
                    totalwaterintake_controller.text = calculateWater(
                      weightcontroller,
                      selectedvalue1,
                      selectedvalue2,
                    ).toStringAsFixed(2);
                  }),
                },
              ),
            ],
          ),
        ),
    );
  }

// function to calculate water intake
  double calculateWater(
    TextEditingController weightcontroller,
    String selectedvalue1,
    String selectedvalue2,
  ) {

    //default value for temperature and activity level 
    if (selectedvalue1 == 'Hot') {
      extraintake1 = 0.5;
    } else {
      extraintake1 = 0;
    }

    if (selectedvalue2 == 'Active') {
      extraintake2 = 0.5;
    } else {
      extraintake2 = 0;
    }

    double totalwaterintake =
        (0.035 * double.parse(weightcontroller.text)) +
        extraintake1 +
        extraintake2;
    return totalwaterintake;
  }

}
