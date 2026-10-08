//problem 1.3
void main(List<String>arguments){
  print('Total number of arguments: ${arguments.length}');

  if(arguments.isEmpty){
    print('Command line arguments passed: ${arguments.join(", ")}');
  }

}
