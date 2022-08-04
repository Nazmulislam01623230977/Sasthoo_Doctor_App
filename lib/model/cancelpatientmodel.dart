class Cancelpatientlist {
  String text;
  String date;
  double tk;

  Cancelpatientlist({
    this.text,
    this.date,
    this.tk,
  });
}

List<Cancelpatientlist> cancelpatientlist = [
  Cancelpatientlist(
    text: 'Cancelled Payment Refounded by patient',
    date: '10/12/12',
    tk: -200,
  ),
  Cancelpatientlist(
    text: 'Reveune payment Cancelled ',
    date: '10/12/12',
    tk: -500,
  ),
  Cancelpatientlist(
    text: 'Cancelled Payment Refounded by patient',
    date: '10/12/12',
    tk: 200,
  ),
];
