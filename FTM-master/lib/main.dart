import 'package:flutter/material.dart';
import 'feedback_list.dart';
import 'form_controller.dart';
import 'form.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi FTM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.total}) : super(key: key);

  final String title;
  final int total;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController teknisiController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  TextEditingController stoController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController oaksesController = TextEditingController();
  TextEditingController eaksesController = TextEditingController();
  TextEditingController gponController = TextEditingController();
  TextEditingController etransController = TextEditingController();
  TextEditingController lvlftmController = TextEditingController();
  TextEditingController lvlodcController = TextEditingController();
  TextEditingController basetrayController = TextEditingController();
  TextEditingController ketController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    print(_formKey.currentState.validate());
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      int number = widget.total + 1;
      FeedbackForm feedbackForm = FeedbackForm(
          no: number.toString(),
          tanggal: DateTime.now().toString(),
          teknisi: teknisiController.text,
          pekerjaan: pekerjaanController.text,
          sto: stoController.text,
          nama: namaController.text,
          oakses: oaksesController.text,
          eakses: eaksesController.text,
          gpon: gponController.text,
          etrans: etransController.text,
          lvlftm: lvlftmController.text,
          lvlodc: lvlodcController.text,
          basetray: basetrayController.text,
          ket: ketController.text);

      FormController formController = FormController();

      _showSnackbar("Submitting Data");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Data Submitted");
          Navigator.pop(context);
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: teknisiController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Teknisi';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Teknisi'),
                        ),
                        TextFormField(
                          controller: pekerjaanController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid pekerjaan';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Pekerjaan'),
                        ),
                        TextFormField(
                          controller: stoController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'STO',
                          ),
                        ),
                        TextFormField(
                          controller: namaController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Nama ODC',
                          ),
                        ),
                        TextFormField(
                          controller: oaksesController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(labelText: 'O-Akses'),
                        ),
                        TextFormField(
                          controller: eaksesController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'E-Akses'),
                        ),
                        TextFormField(
                          controller: gponController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Gpon & IP'),
                        ),
                        TextFormField(
                          controller: etransController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'E-Trans'),
                        ),
                        TextFormField(
                          controller: lvlftmController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Level FTM'),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          controller: lvlodcController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Level ODC'),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          controller: basetrayController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(labelText: 'Basetray / Port ODC'),
                        ),
                        TextFormField(
                          controller: ketController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(labelText: 'Keterangan Tambahan'),
                        ),
                      ],
                    ),
                  )),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: _submitForm,
                child: Text('Input Data'),
              ),
              RaisedButton(
                color: Colors.lightBlueAccent,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackListScreen(),
                      ));
                },
                child: Text('View Data'),
              ),
              SizedBox(
                height: 220.0,
              )
            ],
          ),
        ],
      ),
    );
  }
}
