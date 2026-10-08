//problem 1.4
void main(List<String>arguments){
    if(arguments.isEmpty){
    print('Please provide some numbers');
    return;
  }
  List<int> nums = arguments.map(int.parse).toList();

  double average = nums.reduce((a,b) => a+b)/nums.length;
  print('Average: ${average}');

}