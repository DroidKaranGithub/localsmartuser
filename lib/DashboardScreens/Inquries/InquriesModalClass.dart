class InquriesModalClass {
  List<InquriesData>? data;
  String? totalCount;
  String? perPage;
  bool? status;

  InquriesModalClass({this.data, this.totalCount, this.perPage, this.status});

  InquriesModalClass.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InquriesData>[];
      json['data'].forEach((v) {
        data!.add(new InquriesData.fromJson(v));
      });
    }
    totalCount = json['total_count'].toString();
    perPage = json['per_page'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount.toString();
    data['per_page'] = this.perPage.toString();
    data['status'] = this.status.toString();
    return data;
  }
}

class InquriesData {
  String? id;
  //int? responseCount;
  String? title;
  String? productUrl;

  String? userId;
  String? status;
  String? is_vegue;
  String? audioFile;
  String? fileUpload;
  String? description;
  String? category_id;

  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? response_count;
  String? date;
  String? category;
  InquriesFile? file;

  InquriesData(
      {this.id,
      this.title,
      this.productUrl,
      this.userId,
      this.status,
      this.is_vegue,
      this.audioFile,
      this.fileUpload,
      this.description,
      this.category_id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.response_count,
      this.date,
      this.category,
      this.file});

  InquriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    productUrl = json['product_url'].toString();
    userId = json['user_id'].toString();
    status = json['status'].toString();
    is_vegue = json['is_vegue'].toString();
    audioFile = json['audio_file'].toString();
    fileUpload = json['file_upload'].toString();
    description = json['description'].toString();
    category_id = json['category_id'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    deletedAt = json['deleted_at'].toString();
    response_count = json['response_count'].toString();
    date = json['date'].toString();

    file =
        json['file'] != null ? new InquriesFile.fromJson(json['file']) : null;
    category = json['category'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['title'] = this.title.toString();
    data['product_url'] = this.productUrl.toString();
    data['user_id'] = this.userId.toString();
    data['status'] = this.status.toString();
    data['audio_file'] = this.audioFile.toString();
    data['file_upload'] = this.fileUpload.toString();
    data['description'] = this.description.toString();
    data['date'] = this.date.toString();
    data['created_at'] = this.createdAt.toString();
    data['updated_at'] = this.updatedAt.toString();
    data['deleted_at'] = this.deletedAt.toString();
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    data['category'] = category.toString();
    return data;
  }
}

class InquriesFile {
  String? id;
  String? userId;
  String? name;
  String? description;
  String? fileName;
  String? fileSize;
  String? fileType;
  String? filePath;
  String? createdAt;
  String? updatedAt;

  InquriesFile(
      {this.id,
      this.userId,
      this.name,
      this.description,
      this.fileName,
      this.fileSize,
      this.fileType,
      this.filePath,
      this.createdAt,
      this.updatedAt});

  InquriesFile.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    fileName = json['file_name'].toString();
    fileSize = json['file_size'].toString();
    fileType = json['file_type'].toString();
    filePath = json['file_path'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['file_name'] = this.fileName;
    data['file_size'] = this.fileSize;
    data['file_type'] = this.fileType;
    data['file_path'] = this.filePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
