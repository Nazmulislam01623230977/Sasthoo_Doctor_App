class Appoinmentmodel {
  // int id;
  String day;
  String startTime;
  String endTime;
  String appoinmentId;
  String status;
  String fee;
  String pattientid;
  String reson;
  String debit;
  String firstName;
  String lastName;
  String phoneNumber;
  String dateOfBirth;
  String gender;

  Appoinmentmodel({
    // this.id,
    this.day,
    this.startTime,
    this.endTime,
    this.appoinmentId,
    this.status,
    this.fee,
    this.pattientid,
    this.reson,
    this.debit,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
  });

  factory Appoinmentmodel.fromJSON(Map map) {
    return Appoinmentmodel(
      // id: map['id'],
      day: map['day'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      appoinmentId: map['appoinment_id'],
      status: map['status'],
      fee: map['fee'],
      pattientid: map['patientAppId'],
      reson: map['reson'],
      debit: map['debit'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      dateOfBirth: map['dateOfBirth'],
      gender: map['gender'],
    );
  }
}








// class Appoinmentmodel {
//   String num;
//   String patientname;
//   String problem;
//   String schedule;
//   String chamber;
//   String paymentstatus;
//   String go;
//   Appoinmentmodel({
//     this.num,
//     this.patientname,
//     this.problem,
//     this.schedule,
//     this.chamber,
//     this.paymentstatus,
//     this.go,
//   });
// }

// List<Appoinmentmodel> appoinmentlist = [
//   Appoinmentmodel(
// num: '1',
// patientname: 'Nazmulislam',
// problem: 'heart ',
// schedule: '12.00pm',
// chamber: 'online',
// paymentstatus: 'done',
// go: 'GO'

// ),
// Appoinmentmodel(
// num: '2',
// patientname: 'Nazmulislam',
// problem: 'heart ',
// schedule: '12.00pm',
// chamber: 'online',
// paymentstatus: 'done',
// go: 'GO'

// ),
// Appoinmentmodel(
// num: '3',
// patientname: 'Nazmulislam',
// problem: 'heart ',
// schedule: '12.00pm',
// chamber: 'online',
// paymentstatus: 'done',
// go: 'GO'

// ),
// Appoinmentmodel(
// num: '4',
// patientname: 'Nazmulislam',
// problem: 'heart ',
// schedule: '12.00pm',
// chamber: 'online',
// paymentstatus: 'done',
// go: 'GO'

// ),
// ];
