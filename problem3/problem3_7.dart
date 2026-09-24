//problem 3.7
void main() {
  String state = 'start';

  while (state != 'done') {
    switch (state) {
      case 'start':
        print('Starting...');
        state = 'running';
        break;

      case 'running':
        print('Running...');
        state = 'done';
        break;
    }
  }

  print('Finished');
}