import 'package:api_rdbms/Api/update.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:velocity_x/velocity_x.dart';

import 'api_services.dart';
import 'modle.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  List<Contact> contactList =[];

  ContactApi contactApi = ContactApi();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Card(
                  elevation: 5,
                  child: Form(
                    key: Api.formKey,
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
                            validator:
                                RequiredValidator(errorText: "*Required"),
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
                            validator:
                                RequiredValidator(errorText: "*Required"),
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
                              if (Api.formKey.currentState!.validate()) {
                                await insert();
                                nameController.clear();
                                phoneController.clear();
                                await getContact();
                              }
                            },
                            child: "Add Contact ".text.make(),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async{
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Update(
                                      doc: contactList[index],
                                    )));
                            await getContact();
                          },
                          child: Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              leading: const CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 20,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  await delete(contactList[index].id);
                                  await getContact();
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                              title: contactList[index]
                                  .name
                                  .toString()
                                  .text
                                  .make(),
                              subtitle: contactList[index]
                                  .phone
                                  .toString()
                                  .text
                                  .make(),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  insert() async {
    Contact contact =
    Contact(name: nameController.text, phone: phoneController.text);
    await contactApi.save(contact);
  }
  delete(int? id) async {
    await contactApi.delete(id);
  }

  getContact()async{
    contactList = await contactApi.getData();
    setState(() {
    });
  }
}

//

// }
