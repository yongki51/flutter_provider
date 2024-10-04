class News {
  final String coid;
  final String newscd;
  final String newsname;
  final String description;
  final String validFrom;
  final String validTo;
  final String imageFile;

  News({
    required this.coid,
    required this.newscd,
    required this.newsname,
    required this.description,
    required this.validFrom,
    required this.validTo,
    required this.imageFile,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      coid: json['coid'],
      newscd: json['newscd'],
      newsname: json['newsname'],
      description: json['description'],
      validFrom: json['valid_from'],
      validTo: json['valid_to'],
      imageFile: json['image_file'],
    );
  }
}
