import 'package:flutter/material.dart';

import '../constant.dart';

class ConsultationHistory extends StatefulWidget {
  @override
  _ConsultationHistoryState createState() => _ConsultationHistoryState();
}

class _ConsultationHistoryState extends State<ConsultationHistory> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlueColor.withOpacity(0.5),
          title: Text("Appointments"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Open",
              ),
              Tab(
                text: "Closed",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //Open Apponitments
            ListView.builder(
              physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.calendar_view_day,
                          size: 25,
                        ),
                        title: Text("Consultation"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sunday 9am- 11am"),
                            Text("Dr. Baya Elias"),
                          ],
                        ),
                        trailing: TextButton(
                          onPressed: () {},
                          child: Text("Cancel"),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        indent: MediaQuery.of(context).size.width * 0.18,
                      ),
                    ],
                  );
                }),

            //Closed Appointments
            ListView.builder(
              physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.calendar_view_day,
                          size: 25,
                        ),
                        title: Text("Consultation"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Sunday 9am- 11am"),
                            Text("Dr. Baya Elias"),
                          ],
                        ),
                        trailing: TextButton(
                          onPressed: () {},
                          child: Text("12/08/2021"),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        indent: MediaQuery.of(context).size.width * 0.18,
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
