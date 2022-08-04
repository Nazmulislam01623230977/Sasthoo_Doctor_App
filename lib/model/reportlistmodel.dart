class ReportListModel {
  String apid;
  String patientname;
  String reportname;
  String reportdate;
  String show;
  ReportListModel({
    this.apid,
    this.patientname,
    this.reportname,
    this.reportdate,
    this.show,
  });
}

List<ReportListModel> reportlist = [
  ReportListModel(
      apid: '1',
      patientname: 'Nazmul Islam',
      reportname: 'eye problem',
      reportdate: '12.15.98',
      show: 'Show Report'
      ),
  ReportListModel(
      apid: '2',
      patientname: 'Nazmul Islam',
      reportname: 'eye problem',
      reportdate: '12.15.98',  show: 'Show Report'),
  ReportListModel(
      apid: '3',
      patientname: 'Nazmul Islam',
      reportname: 'eye problem',
      reportdate: '12.15.98',  show: 'Show Report'),
  ReportListModel(
      apid: '4',
      patientname: 'Nazmul Islam',
      reportname: 'eye problem',
      reportdate: '12.15.98',  show: 'Show Report'),
];
