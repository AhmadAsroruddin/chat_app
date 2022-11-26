import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: const Text("Your Profile")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('userid', isEqualTo: argument['user'])
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            final dataUser = snapshot.data!.docs;
            return Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  color: const Color.fromRGBO(18, 18, 18, .2),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(dataUser[0]['imageUrl']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Label(
                  nama: dataUser[0]['username'],
                  label: "Your Name",
                ),
                Label(nama: dataUser[0]['email'], label: "Your Email")
              ],
            );
          }
        },
      ),
    );
  }
}

class Label extends StatelessWidget {
  Label({required this.nama, required this.label});
  String nama;
  String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(nama, style: const TextStyle(fontSize: 20))
      ],
    );
  }
}
