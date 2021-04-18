import 'package:flutter/material.dart';

import 'form_controller.dart';
import 'form.dart';
import 'main.dart';

class FeedbackListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Feedback Responses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FeedbackListPage(title: "Responses"));
  }
}

class FeedbackListPage extends StatefulWidget {
  FeedbackListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  List<FeedbackForm> feedbackItems = List<FeedbackForm>();
  bool isLoading = true;

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();

    _doGet();
  }

  Future _doGet() async {
    await Future.delayed(Duration(seconds: 1));
    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
        isLoading = false;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        title: 'Tambah Data',
                        total: feedbackItems.length,
                      )));
        },
        child: Icon(Icons.add),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _doGet,
              child: ListView.builder(
                itemCount: feedbackItems.length,
                itemBuilder: (context, index) {
                  var item = feedbackItems[index];
                  return ListTile(
                    onTap: () {
                      _deleteData(item.no);
                    },
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        Expanded(
                          child: Text("${feedbackItems[index].pekerjaan}"),
                        )
                      ],
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.message),
                        Expanded(
                          child: Text("${feedbackItems[index].teknisi}"),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }

  _deleteData(no) {
    FormController formController = FormController();

    formController.deleteData(no.toString(), (String response) {
      print(response);
    });
  }
}
