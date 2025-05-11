import 'package:flutter/material.dart';
import 'package:tm/models/tasks_model.dart';

class SubtaskScreen extends StatelessWidget {
  final Map<String, dynamic> task;
  const SubtaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF00695c);
    final Color secondaryColor = Color(0xFFFFFFFF);
    final Color teritaoryColor = Color(0xFF212121);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: teritaoryColor),
        title: Text('Task Details', style: TextStyle(color: teritaoryColor)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.15,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [teritaoryColor, primaryColor],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  task['name'],
                  style: TextStyle(color: secondaryColor, fontSize: 28),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 2, color: primaryColor),
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text('Task', style: TextStyle(color: teritaoryColor),),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 2, color: primaryColor),
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text('description', style: TextStyle(color: teritaoryColor),),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 2, color: primaryColor),
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text('Due Date', style: TextStyle(color: teritaoryColor),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          // Divider(thickness: 2, color: primaryColor,),
          Text(
            'Sub Tasks', 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: teritaoryColor),
            ),
          const SizedBox(height: 15,),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor.withAlpha(480), primaryColor.withAlpha(480)])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [teritaoryColor, primaryColor])
                    ),
                  ),
                ],
              ),
            ),
            ),
        ],
      ),
    );
  }
}
