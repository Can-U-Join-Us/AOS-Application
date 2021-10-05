import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool pressExpanded = false;
  bool _scaleCheckBox = false;
  List<String> category = ['여기에', '뭐 들어가?', '안녕'];
  List<String> part = ['Front-End', 'Back-End', 'Android', 'IOS', 'DevOps'];
  List<String> scaleRanges = ["토이", "시/도", "전국", "국제"];
  List<String> termRanges = ["1개월", "6개월", "1년", "미정"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor, width: 5),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 8),
        width: double.infinity,
        child: pressExpanded
            ? Column(
                children: <Widget>[
                  defaultSearchBox(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "프로젝트\n규모",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: 50,
                        child: buildListViewCheckBox(scaleRanges),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "제작 기간",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: 50,
                        child: buildListViewCheckBox(termRanges),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("카테고리"),
                      buildDropDownButton(category),
                      Text("모집 부분"),
                      buildDropDownButton(part),
                    ],
                  ),
                ],
              )
            : defaultSearchBox(),
      ),
    );
  }

  Widget defaultSearchBox() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "검색어를 입력해주세요."),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                pressExpanded = !pressExpanded;
              });
            },
            child: pressExpanded ? Text("접기") : Text("펼치기"),
          ),
        ],
      ),
    );
  }

  Widget buildListViewCheckBox(List<String> listItems) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return buildCheckBox(listItems[index]);
      },
      itemCount: 4,
    );
  }

  Widget buildCheckBox(String keyword) {
    return Container(
      height: 30,
      child: Row(
        children: <Widget>[
          Checkbox(
            value: _scaleCheckBox,
            onChanged: (value) {
              setState(
                () {
                  _scaleCheckBox = value!;
                },
              );
            },
          ),
          Text(keyword),
        ],
      ),
    );
  }

  Widget buildDropDownButton(List<String> listItems) {
    late String _dropdownValue = listItems[0];
    return DropdownButton(
      value: _dropdownValue,
      items: listItems
          .map((value) =>
              DropdownMenuItem(value: value, child: Text(value.toString())))
          .toList(),
      onChanged: (value) {
        setState(
          () {
            _dropdownValue = value as String;
          },
        );
      },
    );
  }
}
