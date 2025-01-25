import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/quran/cubit/cubit/quran_cubit.dart';
import 'package:quran_app/features/quran/cubit/cubit/quran_state.dart';
import 'package:quran_app/features/quran/views/details_screen.dart';

class QuranHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("القرآن الكريم"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "ابحث عن السورة...",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                context.read<QuranCubit>().searchSour(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<QuranCubit, QuranState>(
              builder: (context, state) {
                if (state is QuranLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is QuranNoResults) {
                  return Center(child: Text("لا توجد نتائج"));
                } else if (state is QuranLoaded) {
                  final sourList = state.sourList;

                  return ListView.builder(
                    itemCount: sourList.length,
                    itemBuilder: (context, index) {
                      final sura = sourList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          title: Text(
                            sura.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            "عدد الآيات: ${sura.ayat}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuranDetailScreen(sura),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("حدث خطأ"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
