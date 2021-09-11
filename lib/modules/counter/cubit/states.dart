abstract class CounterStates {}

class counterinitial extends CounterStates{}


class counterMinusState extends CounterStates{
  final int counter;
  counterMinusState(this.counter);
}

class counterPlusState extends CounterStates{
  final int counter;
  counterPlusState(this.counter);
}
