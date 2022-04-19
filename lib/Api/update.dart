import 'package:api_rdbms/Api/api_services.dart';
import 'package:flutter/material.dart';

import 'package:api_rdbms/Api/modle.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:velocity_x/velocity_x.dart';

class Update extends StatefulWidget {
  const Update({Key? key, required this.doc}) : super(key: key);

  final dynamic doc;

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      phoneController.text = widget.doc.phone;
      nameController.text = widget.doc.name;
    });
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  ContactApi contactApi = ContactApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Card(
              elevation: 5,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      "Enter Details".text.size(20).bold.make(),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: RequiredValidator(errorText: "*Required"),
                        decoration: InputDecoration(
                          labelText: "Name",
                          hintText: "Enter Name",
                          labelStyle: const TextStyle(color: Colors.black),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: RequiredValidator(errorText: "*Required"),
                        decoration: InputDecoration(
                          labelText: "Phone",
                          hintText: "Enter Phone No",
                          labelStyle: const TextStyle(color: Colors.black),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await update();
                            Navigator.pop(context);
                          }
                        },
                        child: "Update Contact ".text.make(),
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  update() async {
    Contact contact = Contact(
        id: widget.doc.id,
        name: nameController.text,
        phone: phoneController.text);
    await contactApi.update(contact);
  }
}