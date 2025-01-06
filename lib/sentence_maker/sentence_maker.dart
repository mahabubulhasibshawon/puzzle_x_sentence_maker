import 'package:flutter/material.dart';

class SentenceMaker extends StatefulWidget {
  const SentenceMaker({super.key});

  @override
  State<SentenceMaker> createState() => _SentenceMakerState();
}

class _SentenceMakerState extends State<SentenceMaker> {
  // Track words in the top row
  List<String> row1 = [];
  // Track words and placeholders in the bottom row
  List<String?> row2 = ['go', 'I', 'now', 'should'];

  // Pre-define a mapping for each word's fixed index in row2
  final Map<String, int> row2Indices = {
    'go':0,
    'I': 1,
    'now': 2,
    'should': 3,
  };

  // Move word from one row to another
  void moveWord(String word, int index, bool toRow1) {
    setState(() {
      if (toRow1) {
        // Move word from row2 to row1
        row1.add(word);
        row2[index] = null; // Replace with an empty container
      } else {
        // Move word from row1 to its fixed index in row2
        int fixedIndex = row2Indices[word]!;
        if (row2[fixedIndex] == null) {
          row1.remove(word);
          row2[fixedIndex] = word; // Place word back to its fixed index
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
      body: Padding(
        padding: EdgeInsets.all(height * .01),
        child: Column(
          children: [
            // top
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.keyboard_backspace, color:  Colors.white),
                Text('১/৪৭', style: TextStyle( color:  Colors.white),),
                Row(
                  children: [
                    Icon(Icons.diamond, color:  Colors.white),
                    Text('৫', style: TextStyle( color:  Colors.white),)
                  ],
                ),
              ],
            ),
            SizedBox(height: height * .1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('সঠিক ইংরেজি শব্দ দিয়ে অনুবাদ করুন', style: TextStyle(fontSize: height * .02, fontWeight: FontWeight.bold, color:  Colors.white),)
              ],),
            SizedBox(height: height * .05,),
            Text('আমার এখন যাওয়া উচিৎ', style: TextStyle(fontSize: height * .03, fontWeight: FontWeight.bold, color:  Colors.white )),
            SizedBox(height: height * .2,),
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
                        onTap: () =>
                            moveWord(word, -1, false), // Move to Row 2
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
            // Bottom Row (fixed structure with empty containers)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                row2.length,
                    (index) => row2[index] != null
                    ? GestureDetector(
                  onTap: () =>
                      moveWord(row2[index]!, index, true), // Move to Row 1
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: _wordContainer(height, width, row2[index]!),
                  ),
                )
                    : _emptyContainer(height, width * 0.7, ''),
              ),
            ),
            SizedBox(height: height * .3,),
          Container(
            height: height * .05,
            width: width * .7,
            decoration: BoxDecoration(
              color: row2.isEmpty? Colors.white : Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: row2.isEmpty ? Center(child: Text('চেক করুন', style: TextStyle(fontSize: height * 0.02, fontWeight: FontWeight.bold),)) : Center(child: Text('পরবর্তী', style: TextStyle(fontSize: height * 0.02, fontWeight: FontWeight.bold, color: Colors.white),)),
          ),
          ],
        ),
      ),
    );
  }
}

Widget _wordContainer(double height, double width , String word) {
  return  Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.all(8),
    height: height * .04,
    width: width * .15,
    decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(
            color: Colors.grey.shade300
        ),
        borderRadius: BorderRadius.circular(height * .01)
    ),
    child: Center(child: Text(word, style: const TextStyle(color: Colors.white),)),
  );

}
Widget _emptyContainer(double height, double width , String word) {
  return  Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.all(8),
    height: height * .04,
    width: width * .15,
    decoration: BoxDecoration(
        color: Colors.black,
        // border: Border.all(
        //     color: Colors.grey.shade300
        // ),
        borderRadius: BorderRadius.circular(height * .01)
    ),
    child: Center(child: Text(word)),
  );

}



