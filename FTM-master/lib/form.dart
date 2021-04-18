/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  dynamic no;
  String tanggal;
  String teknisi;
  String pekerjaan;
  String sto;
  String nama;
  String oakses;
  String eakses;
  String gpon;
  String etrans;
  String lvlftm;
  String lvlodc;
  String basetray;
  String ket;

  FeedbackForm(
      {this.no,
      this.tanggal,
      this.teknisi,
      this.pekerjaan,
      this.sto,
      this.nama,
      this.oakses,
      this.eakses,
      this.gpon,
      this.etrans,
      this.lvlftm,
      this.lvlodc,
      this.basetray,
      this.ket});

  FeedbackForm.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    tanggal = json['tanggal'];
    teknisi = json['teknisi'];
    pekerjaan = json['pekerjaan'];
    sto = json['sto'];
    nama = json['nama'];
    oakses = json['oakses'];
    eakses = json['eakses'];
    gpon = json['gpon'];
    etrans = json['etrans'];
    lvlftm = json['lvlftm'];
    lvlodc = json['lvlodc'];
    basetray = json['basetray'];
    ket = json['ket'];
  }

  // Method to make GET parameters.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['tanggal'] = this.tanggal;
    data['teknisi'] = this.teknisi;
    data['pekerjaan'] = this.pekerjaan;
    data['sto'] = this.sto;
    data['nama'] = this.nama;
    data['oakses'] = this.oakses;
    data['eakses'] = this.eakses;
    data['gpon'] = this.gpon;
    data['etrans'] = this.etrans;
    data['lvlftm'] = this.lvlftm;
    data['lvlodc'] = this.lvlodc;
    data['basetray'] = this.basetray;
    data['ket'] = this.ket;
    // data['req'] = "add";
    return data;
  }
}
