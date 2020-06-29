import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:api/models/commentmodels.dart';
import 'dart:convert';

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {

  Dio _dio;
  List<CommentModel> _list = List<CommentModel>();


  void initState(){
    super.initState();
    fetchData().then((value){
      setState((){
        _list.addAll(value);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text('API test'),
      ),
      body:ListView.builder(
        itemBuilder: (context, index){
          return Card(
            child : Padding(
              padding: EdgeInsets.all(16.0),
              child :Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _list[index].email,
                  style : TextStyle(
                    fontSize : 20,
                    fontWeight: FontWeight.bold,                
                  )
                ),
                SizedBox(height: 5,),
                Text(
                  _list[index].name,
                  style : TextStyle(
                    fontSize : 18,
                    fontWeight: FontWeight.bold,
                    color : Colors.pink
                  )
                ),
                SizedBox(height: 5,),
                Text(
                  _list[index].body,
                  style : TextStyle(
                    fontSize : 16,
                    fontWeight: FontWeight.bold,
                    color : Colors.blue
                  )
                ),
              ],
            ),
            ),
          );
        },
        itemCount: _list.length,
      ),
    );
  }

  Future<List<CommentModel>> fetchData() async{
    _dio = Dio();
    Response response =  await _dio.get('https://jsonplaceholder.typicode.com/comments');

    final List comment = json.decode(jsonEncode(response.data));
    List<CommentModel> listCommentModel= comment.map((f) => CommentModel.fromJson(f)).toList();

    return listCommentModel;

  }

 

}