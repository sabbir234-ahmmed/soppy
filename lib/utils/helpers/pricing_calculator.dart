class UPricingCalculator{

  /// Calculate price based on tax and shipping
  static double calculateTotalPrice(double subTotal, String location){
  double taxRate=getTaxRateForLocation(location);
  double taxAmount=subTotal * taxRate;
    return taxAmount;
  }

  /// calculate shipping cost
  static String calculateShippingCost(double subTotal, String location){
    double shippingCost= getShippingCost(location);
    return shippingCost.toStringAsFixed(0);
  }

  /// calculate tax
  static String calculateTax(double subTotal, String location){
    double tax=getTaxRateForLocation(location);
    return tax.toString();
  }

  /// calculate tax based on location
  static double getTaxRateForLocation(String location){
    return 10.4;
  }

  /// calculate shipping cost
  static double getShippingCost(String location){
    return 20.00;
  }
}