/// transaction : [{"webinar_id":6147,"title":"Debt Forgiveness and Section 108","amount":"0","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-debt-forgiveness-and-section-108-1611776820-561252728.pdf","webinar_type":"live","payment_date":"Feb 10, 2021","webinar_date":"Feb 10, 2021 09:30 AM EST","transaction_id":"txn_wMtdzCtlun48nCpPtsyFgQPQ"},{"webinar_id":5963,"title":"Guide to Depreciation Under The TCJA (Latest)","amount":"0","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-guide-to-depreciation-under-the-tcja-2020-1611349370-561250283.pdf","webinar_type":"live","payment_date":"Feb 05, 2021","webinar_date":"Feb 05, 2021 12:30 PM EST","transaction_id":"txn_wyM12KkCLG9yY0E1aT9PtS0u"},{"webinar_id":5963,"title":"Guide to Depreciation Under The TCJA (Latest)","amount":"0","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-guide-to-depreciation-under-the-tcja-2020-1611349370-561250279.pdf","webinar_type":"live","payment_date":"Feb 05, 2021","webinar_date":"Feb 05, 2021 12:30 PM EST","transaction_id":"txn_wfhlLhnMpKmQxgA6aRuuK6Ta"},{"webinar_id":5892,"title":"Adding Financial Planning to your practice","amount":"0","receipt":"https://my-cpe.com/front_side/selfstudy_paid_receipt/MyCpe-self-study-adding-financial-planning-to-your-practice-1611229775326.pdf","webinar_type":"self_study","payment_date":"Jan 29, 2021","webinar_date":"","transaction_id":"txn_wfcJ3iYh3TKYTS3ktDJwdPYW"},{"webinar_id":5326,"title":"Excel Accountant: Payroll Analysis","amount":"0","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-excel-accountant-payroll-analysis-1608664977-lCuedd1fRjSNeCUJv0Z6fQ.pdf","webinar_type":"live","payment_date":"Jan 26, 2021","webinar_date":"Jan 26, 2021 09:30 AM EST","transaction_id":"txn_wkxOpc99SJc4bNkk9rlEasFQ"},{"webinar_id":5511,"title":"Yellow Book Boot Camp - NFP and Governmental Accounting & Auditing Update","amount":"40","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-yellow-book-boot-camp---nfp-and-governmental-accounting-and-auditing-update-1609188962-gsPXMyhvTtSAUD8ztU_IwQ.pdf","webinar_type":"live","payment_date":"Jan 08, 2021","webinar_date":"Jan 08, 2021 10:00 AM EST","transaction_id":"txn_1I7G2VLuyvTTvdwTokS7rafc"},{"webinar_id":5514,"title":"Internal Controls for Businesses","amount":"70","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-internal-controls-for-businesses-1609189411-7eSEfLUTSRGTpJh4x6udpg.pdf","webinar_type":"live","payment_date":"Jan 08, 2021","webinar_date":"Jan 08, 2021 10:00 AM EST","transaction_id":"txn_1I7FvMLuyvTTvdwTlnbbUtkv"},{"webinar_id":5590,"title":"The new $900 billion Covid-19 stimulus package overview & impact","amount":"0","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-the-new-900-billion-covid-19-stimulus-package-overview-and-impact-1609425445-BmSO8n2aQSOoRIqfFg5rpw.pdf","webinar_type":"live","payment_date":"Jan 05, 2021","webinar_date":"Jan 05, 2021 10:30 AM EST","transaction_id":"txn_wyYORLiUDUhmlCoRyKC7w8Ha"},{"webinar_id":5590,"title":"The new $900 billion Covid-19 stimulus package overview & impact","amount":"0","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-the-new-900-billion-covid-19-stimulus-package-overview-and-impact-1609425445-BmSO8n2aQSOoRIqfFg5rpw.pdf","webinar_type":"live","payment_date":"Jan 05, 2021","webinar_date":"Jan 05, 2021 10:30 AM EST","transaction_id":"txn_w3WCmK2oMocvwQizNrV5Rkwg"},{"webinar_id":5590,"title":"The new $900 billion Covid-19 stimulus package overview & impact","amount":"10","receipt":"https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-the-new-900-billion-covid-19-stimulus-package-overview-and-impact-1609425445-BmSO8n2aQSOoRIqfFg5rpw.pdf","webinar_type":"live","payment_date":"Jan 05, 2021","webinar_date":"Jan 05, 2021 10:30 AM EST","transaction_id":"txn_1I3PxhBTdan3juv1xkUMtest"}]

class My_transaction_list {
  List<Transaction> _transaction;

  List<Transaction> get transaction => _transaction;

  My_transaction_list({List<Transaction> transaction}) {
    _transaction = transaction;
  }

  My_transaction_list.fromJson(dynamic json) {
    if (json["transaction"] != null) {
      _transaction = [];
      json["transaction"].forEach((v) {
        _transaction.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_transaction != null) {
      map["transaction"] = _transaction.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// webinar_id : 6147
/// title : "Debt Forgiveness and Section 108"
/// amount : "0"
/// receipt : "https://my-cpe.com/front_side/live_paid_receipt/MyCpe-live-webinars-debt-forgiveness-and-section-108-1611776820-561252728.pdf"
/// webinar_type : "live"
/// payment_date : "Feb 10, 2021"
/// webinar_date : "Feb 10, 2021 09:30 AM EST"
/// transaction_id : "txn_wMtdzCtlun48nCpPtsyFgQPQ"

class Transaction {
  int _webinarId;
  String _title;
  String _amount;
  String _receipt;
  String _webinarType;
  String _paymentDate;
  String _webinarDate;
  String _transactionId;

  int get webinarId => _webinarId;
  String get title => _title;
  String get amount => _amount;
  String get receipt => _receipt;
  String get webinarType => _webinarType;
  String get paymentDate => _paymentDate;
  String get webinarDate => _webinarDate;
  String get transactionId => _transactionId;

  Transaction(
      {int webinarId,
      String title,
      String amount,
      String receipt,
      String webinarType,
      String paymentDate,
      String webinarDate,
      String transactionId}) {
    _webinarId = webinarId;
    _title = title;
    _amount = amount;
    _receipt = receipt;
    _webinarType = webinarType;
    _paymentDate = paymentDate;
    _webinarDate = webinarDate;
    _transactionId = transactionId;
  }

  Transaction.fromJson(dynamic json) {
    _webinarId = json["webinar_id"];
    _title = json["title"];
    _amount = json["amount"];
    _receipt = json["receipt"];
    _webinarType = json["webinar_type"];
    _paymentDate = json["payment_date"];
    _webinarDate = json["webinar_date"];
    _transactionId = json["transaction_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["webinar_id"] = _webinarId;
    map["title"] = _title;
    map["amount"] = _amount;
    map["receipt"] = _receipt;
    map["webinar_type"] = _webinarType;
    map["payment_date"] = _paymentDate;
    map["webinar_date"] = _webinarDate;
    map["transaction_id"] = _transactionId;
    return map;
  }
}
