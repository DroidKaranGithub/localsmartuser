class ResponseDetails {
  String? shop_name, owner_name, category, address, website_url, description;

  ResponseDetails(
      {this.shop_name,
      this.owner_name,
      this.category,
      this.address,
      this.website_url,
      this.description});

  factory ResponseDetails.fromJson(Map<String, dynamic> jsonData) {
    return ResponseDetails(
        description: jsonData['response']['response'],
        shop_name: jsonData['shop']['sho_name'],
        owner_name: jsonData['shop']['owner_name'],
        category: jsonData['shop']['category'],
        address: jsonData['shop']['address'],
        website_url: jsonData['shop']['website_url']);
  }
}
