import 'package:flutter/material.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/generated/l10n.dart';
import 'package:planck/src/models/cart_summary_model.dart';

class DetailsProducts extends StatelessWidget {
  const DetailsProducts({
    Key? key,
    required this.cartSummary,
  }) : super(key: key);

  final CartSummaryModel cartSummary;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: 2,
      sortAscending: false,
      columnSpacing: 0,
      horizontalMargin: 20,
      columns: [
        DataColumn(label: Text(S.of(context).lNumber)),
        DataColumn(label: Text(S.of(context).lProduct)),
        DataColumn(label: Text(S.of(context).lTotal), numeric: true),
      ],
      rows: _dataRows(context),
    );
  }

  List<DataRow> _dataRows(BuildContext context) {
    List<DataRow> rows = [];
    late String nota;
    for (var pr in cartSummary.products) {
      nota = pr.note.isEmpty ? '' : ' (${pr.note})';
      rows.add(_dataRowElement(
          c1: '${pr.number}',
          c2: '${pr.name} $nota',
          c3: pr.total.toStringAsFixed(kCoinDecimals)));
    }

    rows.add(_dataRowElement(
        c1: S.of(context).lDeliveryFee,
        c3: cartSummary.fee.deliveryfee.toStringAsFixed(kCoinDecimals)));

    rows.add(_dataRowElement(
        selected: true,
        c1: S.of(context).lTotal,
        c3: cartSummary.total.toStringAsFixed(kCoinDecimals)));
    return rows;
  }

  DataRow _dataRowElement(
      {String c1 = '', String c2 = '', String c3 = '', bool selected = false}) {
    return DataRow(selected: selected, cells: [
      DataCell(Text(c1)),
      DataCell(Tooltip(
        message: c2,
        margin: const EdgeInsets.all(kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Text(c2),
      )),
      DataCell(Text(c3))
    ]);
  }
}
