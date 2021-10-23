import 'package:flutter/material.dart';

import '../util/size_config.dart';
import '../model/biodata_model.dart';
import '../widget/settings_widget.dart';

class BiodataScreen extends StatefulWidget {
  final BiodataModel biodata;
  BiodataScreen({Key key, this.biodata}) : super(key: key);

  @override
  _BiodataScreenState createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [SettingsWidget()],
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blokVertical * 4),
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).buttonColor,
                    size: SizeConfig.blokVertical * 10,
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("${widget.biodata.biodata.nama}"),
                      SizedBox(
                        height: 12,
                      ),
                      Text("${widget.biodata.biodata.nim}")
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: SizeConfig.blokHorizontal * 3,
                      left: SizeConfig.blokHorizontal * 3,
                      right: SizeConfig.blokHorizontal * 3,
                      bottom: SizeConfig.blokVertical * 2),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        title: Text("Program Studi"),
                        subtitle: Text("${widget.biodata.biodata.prodi}"),
                      ),
                      ListTile(
                        title: Text("Konsentrasi"),
                        subtitle: Text((widget.biodata.biodata.jurusan == null)
                            ? "-"
                            : "${widget.biodata.biodata.jurusan}"),
                      ),
                      ListTile(
                        title: Text("Dosen Wali"),
                        subtitle: Text("${widget.biodata.biodata.dosenWali}"),
                      ),
                      ListTile(
                        title: Text("Tempat / Tanggal lahir"),
                        subtitle: Text(
                            "${widget.biodata.biodata.tempatLahir} / ${widget.biodata.biodata.tanggalLahir}"),
                      ),
                      ListTile(
                        title: Text("Alamat"),
                        subtitle: Text("${widget.biodata.biodata.alamat} \n"
                            "Ds. ${widget.biodata.biodata.desa.trimRight()} "
                            "${widget.biodata.biodata.kecamatan.trimRight()} "
                            "${widget.biodata.biodata.kabupaten.trimRight()} "
                            "${widget.biodata.biodata.provinsi.trimRight()}"),
                      ),
                      ListTile(
                        title: Text("Ponsel"),
                        subtitle: Text("${widget.biodata.biodata.ponsel}"),
                      ),
                      ListTile(
                        title: Text("Telepon"),
                        subtitle: Text("${widget.biodata.biodata.telpon}"),
                      ),
                      ListTile(
                        title: Text("Gmail"),
                        subtitle: Text("${widget.biodata.biodata.email}"),
                      ),
                      ListTile(
                        title: Text("Facebook"),
                        subtitle: Text("${widget.biodata.biodata.facebook}"),
                      ),
                      ListTile(
                        title: Text("Twitter"),
                        subtitle: Text("${widget.biodata.biodata.twitter}"),
                      ),
                      ListTile(
                        title: Text("Agama"),
                        subtitle: Text("${widget.biodata.biodata.agama}"),
                      ),
                      ListTile(
                        title: Text("Nama Ayah"),
                        subtitle: Text("${widget.biodata.biodata.nmAyah}"),
                      ),
                      ListTile(
                        title: Text("Nama Ibu"),
                        subtitle: Text("${widget.biodata.biodata.nmIbu}"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
