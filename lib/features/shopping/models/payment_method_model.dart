class PaymentMethodModel{
  String name;
  String image;

  PaymentMethodModel({
    required this.name,
    required this.image,
});

  /// method for implement empty payment method model
  static PaymentMethodModel empty()=> PaymentMethodModel(name: "", image: "");
}