abstract class PaymentStrategy {
  void pay(double amount);
}

class CardPayment implements PaymentStrategy {
  @override
  void pay(double amount) {
    print('Paid $amount by card');
  }
}

class CashPayment implements PaymentStrategy {
  @override
  void pay(double amount) {
    print('Paid $amount in cash');
  }
}

void checkout(PaymentStrategy strategy) {
  strategy.pay(100);
}

void main() {
  checkout(CardPayment());
  checkout(CashPayment());
}