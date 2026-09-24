//problem 1.7
void main(List<String>arguments){
  for(String argument in arguments){
    List<String> parts = argument.split('=');

    String key = parts[0].replaceFirst('--', '');
    String value = parts[1];

    print('$key = $value');
  }
}