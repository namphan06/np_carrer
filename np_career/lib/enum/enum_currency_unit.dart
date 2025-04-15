enum EnumCurrencyUnit {
  vnd("triệu (VND)"),
  usd("\$ (USD)"),
  eur("€ (EUR)"),
  jpy("¥ (JPY)"),
  gbp("£ (GBP)"),
  cny("¥ (CNY)"),
  krw("₩ (KRW)"),
  inr("₹ (INR)"),
  aud("\$ (AUD)"),
  cad("\$ (CAD)");

  final String label;

  const EnumCurrencyUnit(this.label);
}
