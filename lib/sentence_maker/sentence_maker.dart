import 'package:flutter/material.dart';

class SentenceMaker extends StatefulWidget {
  const SentenceMaker({super.key});

  @override
  State<SentenceMaker> createState() => _SentenceMakerState();
}

class _SentenceMakerState extends State<SentenceMaker> {
  List<String> row1 = [];
  List<String?> row2 = ['go', 'I', 'now', 'should'];
  final Map<String, int> row2Indices = {'go': 0, 'I': 1, 'now': 2, 'should': 3};
  bool showResult = false;

  void moveWord(String word, int index, bool toRow1) {
    setState(() {
      if (toRow1) {
        row1.add(word);
        row2[index] = null;
      } else {
        int fixedIndex = row2Indices[word]!;
        if (row2[fixedIndex] == null) {
          row1.remove(word);
          row2[fixedIndex] = word;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(height * .01),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.keyboard_backspace, color: Colors.white),
                    Text('১/৪৭', style: TextStyle(color: Colors.white)),
                    Row(
                      children: [
                        Icon(Icons.diamond, color: Colors.white),
                        Text('৫', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * .1),
                Text('সঠিক ইংরেজি শব্দ দিয়ে অনুবাদ করুন',
                    style: TextStyle(
                        fontSize: height * .02,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: height * .05),
                Text('আমার এখন যাওয়া উচিৎ',
                    style: TextStyle(
                        fontSize: height * .03,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: height * .2),
                SizedBox(
                  height: height * 0.1,
                  child: Row(
                    children: row1
                        .asMap()
                        .map((index, word) => MapEntry(
                      index,
                      GestureDetector(
                        onTap: () => moveWord(word, -1, false),
                        child: _wordContainer(height, width, word),
                      ),
                    ))
                        .values
                        .toList(),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    row2.length,
                        (index) => row2[index] != null
                        ? GestureDetector(
                        onTap: () => moveWord(row2[index]!, index, true),
                        child: _wordContainer(height, width, row2[index]!))
                        : _emptyContainer(height, width, ''),
                  ),
                ),
                SizedBox(height: height * .3),
                GestureDetector(
                  onTap: () {
                    if (row1.length == 4) {
                      setState(() {
                        showResult = true;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: height * .05,
                    width: width * .7,
                    decoration: BoxDecoration(
                      color: row1.length == 4 ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        row1.length == 4 ? 'চেক করুন' : 'পরবর্তী',
                        style: TextStyle(
                          fontSize: height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: row1.length == 4 ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showResult)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: 0,
              left: 0,
              right: 0,
              height: height / 3,
              child: AnimatedContainer(
                curve: Curves.linearToEaseOut,
                margin: EdgeInsets.all(20),
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: Color(0xFF27312f),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'খুব দুর্দান্ত হয়েছে',
                                    style: TextStyle(
                                        fontSize: height * .03, fontWeight: FontWeight.bold, color: Color(0xFF61b946)),
                                  ),
                                  Text('আপনি অনেক ভাল করেছেন,\nচালিয়ে যান', style: TextStyle(color: Colors.white),)
                                ],
                              ),
                              Image.network('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/dbd379ee-ee4c-4b99-aadb-1652b005ea15/db1x93d-b1725e16-4570-4be4-957d-c15d5be424e1.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2RiZDM3OWVlLWVlNGMtNGI5OS1hYWRiLTE2NTJiMDA1ZWExNVwvZGIxeDkzZC1iMTcyNWUxNi00NTcwLTRiZTQtOTU3ZC1jMTVkNWJlNDI0ZTEuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.Ub2IFm0RK4UF9belo0KR9BAECgVWuVuRrwuW7XxFuB0', height: height * .15,)
                            ],
                          ),
                        ),
                        Spacer(),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: height * .05,
                          width: width * .7,
                          decoration: BoxDecoration(
                            color: row1.length == 4 ? Colors.white : Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'পরবর্তী',
                              style: TextStyle(
                                fontSize: height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: row1.length == 4 ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _wordContainer(double height, double width, String word) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.all(8),
    height: height * .04,
    width: width * .15,
    decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(height * .01)),
    child: Center(
        child: Text(
          word,
          style: const TextStyle(color: Colors.white),
        )),
  );
}

Widget _emptyContainer(double height, double width, String word) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.all(8),
    height: height * .04,
    width: width * .15,
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(height * .01)),
    child: Center(child: Text(word)),
  );
}
