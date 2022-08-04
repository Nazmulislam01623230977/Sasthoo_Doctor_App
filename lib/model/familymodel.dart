class Familymodel {
  int id;
  String email;
  String userGenId;
  String firstname;
  String lastname;
  String nid;
  String gender;
  String phone;
  String title;
  String passport;
  String dateofbirth;
  String bmdcno;
  String regavater;
  String usertype;
  String onlinestatus;
  String bloodgroupid;
  String relation;

  Familymodel(
      {this.id,
      this.email,
      this.userGenId,
      this.firstname,
      this.lastname,
      this.nid,
      this.gender,
      this.phone,
      this.title,
      this.passport,
      this.dateofbirth,
      this.bmdcno,
      this.regavater,
      this.usertype,
      this.onlinestatus,
      this.bloodgroupid,
      this.relation});

  factory Familymodel.fromJSON(Map map) {
    return Familymodel(
      id: map['id'],
      email: map['email'],
      userGenId: map['user_gen_id'],
      firstname: map['first_name'],
      lastname: map['last_name'],
      gender: map['gender'],
      nid: map['nid'],
      passport: map['passport'],
      phone: map['phone'],
      dateofbirth: map['date_of_birth'],
      bmdcno: map[' bmdc_no'],
      regavater: map['reg_avater'],
      usertype: map['user_type'],
      onlinestatus: map["online_status"],
      bloodgroupid: map['blood_group_id'],
      relation: map['relation'],
    );
  }
}
