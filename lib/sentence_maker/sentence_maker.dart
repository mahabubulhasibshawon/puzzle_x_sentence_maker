import 'package:flutter/material.dart';

class SentenceMaker extends StatefulWidget {
  const SentenceMaker({super.key});

  @override
  State<SentenceMaker> createState() => _SentenceMakerState();
}

class _SentenceMakerState extends State<SentenceMaker> {
  List<String> row1 = [];
  List<String?> row2 = ['go', 'I', 'now', 'should'];

  final Map<String, int> row2Indices = {
    'go': 0,
    'I': 1,
    'now': 2,
    'should': 3,
  };

  final List<String> correctSentence = ['I', 'should', 'go', 'now'];

  bool isChecked = false;
  bool isCorrect = false;

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

  void checkSentence() {
    setState(() {
      isChecked = true;
      isCorrect = row1.join(' ') == correctSentence.join(' ');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
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
                    Text('৫', style: TextStyle(color: Colors.white))
                  ],
                ),
              ],
            ),
            SizedBox(height: height * .1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('সঠিক ইংরেজি শব্দ দিয়ে অনুবাদ করুন',
                    style: TextStyle(
                        fontSize: height * .02,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))
              ],
            ),
            SizedBox(height: height * .05),
            Text('আমার এখন যাওয়া উচিৎ',
                style: TextStyle(
                    fontSize: height * .03,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: height * .15),

            // Top Row
            SizedBox(
              height: height * 0.1,
              child: Row(
                children: row1
                    .asMap()
                    .map((index, word) {
                  return MapEntry(
                    index,
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                      child: GestureDetector(
                        onTap: () => moveWord(word, -1, false),
                        child: _wordContainer(height, width, word),
                      ),
                    ),
                  );
                })
                    .values
                    .toList(),
              ),
            ),
            const Divider(),

            // Bottom Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                row2.length,
                    (index) => row2[index] != null
                    ? GestureDetector(
                  onTap: () => moveWord(row2[index]!, index, true),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: _wordContainer(height, width, row2[index]!),
                  ),
                )
                    : _emptyContainer(height, width * 0.7, ''),
              ),
            ),
            Spacer(),
            // Button and Animated Feedback Container
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Animated Feedback Container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: isChecked ? isCorrect? 300 : 397 : 0,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFF27312f),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: isCorrect ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      ],
                    ) : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'সঠিক হয়নি',
                                style: TextStyle(
                                    fontSize: height * .03, fontWeight: FontWeight.bold, color: Color(0xFFb4413d)),
                              ),
                              Image.network('https://media.tenor.com/8QPpKnJQiS4AAAAj/spongebob-flip.gif', height: height * .15,)
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.all(10),
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFF404947),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF65c748),
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Text('সমাধান',style: TextStyle(fontWeight: FontWeight.bold),)),
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                ),
                                Spacer(),
                                Text('I should go now', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff9aa3a1)),),
                                Text('ব্যাখ্যা', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color:  Color(
                                    0xffd9dedc))),
                                Spacer(),
                                Text('I অর্থ আমি/আমার should অর্থ উচিৎ go অর্থ \nযাওয়া Now অর্থ এখন', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color:  Color(0xff9aa3a1)),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Check/Next Button (Position remains fixed)
                Container(
                  height: height * .05,
                  width: width * .7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: checkSentence,
                    child: Text(
                      isChecked ? 'পরবর্তী' : 'চেক করুন',
                      style: TextStyle(
                        fontSize: height * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
