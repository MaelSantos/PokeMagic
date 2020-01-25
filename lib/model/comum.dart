class Comum {
  
  int id = 1;//gambiarra
  String name;
  String url;

  Comum({this.name, this.url});

  Comum.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
