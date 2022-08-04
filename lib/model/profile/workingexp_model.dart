class WirkingExp {
  int id;
  String instituteName;
  String designation;
  String department;
  String startTime;
  String endTime;
  String experienceCertificate;

  WirkingExp(
      {this.id,
      this.instituteName,
      this.department,
      this.startTime,
      this.endTime,
      this.experienceCertificate});

  factory WirkingExp.fromJSON(Map map) {
    return WirkingExp(
      id: map['title'],
      instituteName: map['description'],
      department: map['urlToImage'],
      startTime: map['urlToImage'],
      endTime: map['urlToImage'],
      experienceCertificate: map['urlToImage'],
    );
  }
}
