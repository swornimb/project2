import 'dart:convert';

import 'package:http/http.dart' as http;

friendRequestpost(data) {
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/friend-requests.json');
  http.post(url, body: jsonEncode(data));
}

Future<Map> getfriendrequest(id) async {
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/friend-requests.json?orderBy="userid"&equalTo="${id}"');
  var datas = await http.get(url);

  Map payload = jsonDecode(datas.body);
  return payload;
}

putfriendrequestAccept(data) async {
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/friend-requests/${data['key']}/.json');
  await http.put(url,
      body: jsonEncode({
        'key': data['key'].toString(),
        'datakey': data['datakey'],
        'userid': data['userid'],
        'jobid': data['jobid'],
        'requesterId': data['requesterId'],
        'name': data['name'],
        'jobname': data['jobname'],
        'status': 'Accepted'
      }));
}

putfriendrequestReject(data) async {
  var url = Uri.parse(
      'https://jobfinder-c2051-default-rtdb.asia-southeast1.firebasedatabase.app/friend-requests/${data['key']}/.json?x-http-method-override=DELETE');
  await http.delete(url);
}
