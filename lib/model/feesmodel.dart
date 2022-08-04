class Feesmodel {
  String chambername;
  String newfees;
  String oldfees;
  String reportfess;
  String save;
  String delete;
  
  Feesmodel({
    this.chambername,
    this.newfees,
    this.oldfees,
    this.reportfess,
    this.save,
    this.delete,
  });
}

List<Feesmodel> feeslist = [
 Feesmodel(chambername: 'online',newfees: '500tk',oldfees: '500',reportfess: '500tk',save: 'Save',delete: 'Delete'),
 Feesmodel(chambername: 'online',newfees: '500tk',oldfees: '500',reportfess: '500tk',save: 'Save',delete: 'Delete'),
 Feesmodel(chambername: 'online',newfees: '500tk',oldfees: '500',reportfess: '500tk',save: 'Save',delete: 'Delete'),
 Feesmodel(chambername: 'online',newfees: '500tk',oldfees: '500',reportfess: '500tk',save: 'Save',delete: 'Delete'),
 Feesmodel(chambername: 'online',newfees: '500tk',oldfees: '500',reportfess: '500tk',save: 'Save',delete: 'Delete'),
];
