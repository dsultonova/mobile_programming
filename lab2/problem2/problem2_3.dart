void main(){
  final currentTime = DateTime.now() ;
  const pi = 3.14159;

  print(currentTime);
  print(pi);

}
// The difference is that final type of variable can be declared during runtime, it is not 
//necessary to declare it before runtime, const type of variable must be declared before runtime.
// const means: value must be known as a compile-time constant