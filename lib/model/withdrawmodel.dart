class Withdrawlist {
  String text;
  String date;
  String tk;

  Withdrawlist({
    this.text,
    this.date,
    this.tk,
  });
}

List<Withdrawlist> withdrawlist = [
  Withdrawlist(
    text: 'Withdraw Completed Sucessfull',
    date: '10/12/12',
    tk: '200',
  ),
  Withdrawlist(
    text: 'Withdraw Initialted',
    date: '10/12/12',
    tk: '500',
  ),
  Withdrawlist(
    text: 'Withdraw Completed Sucessfull',
    date: '10/12/12',
    tk: '200',
  ),
];
