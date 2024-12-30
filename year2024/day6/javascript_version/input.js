export default class Input {
  constructor() {}

  static data = [
    '..........................#.#........................................#..........................................#.............#...',
    '....................#...............................#.......#...............................#..........................#...#......',
    '.....#.......#...................................................#..#....................##.........#...#...........#.....#..#.#..',
    '............#...#....#..............##...#.#....#........................#...................................................#....',
    '....#......##........................................................................#..#..##...................##.........#......',
    '.............##.........#..##..............#...............#....................#..................#......#...................#...',
    '...........#.....................#.......#.................#....#.#..............#...........#.........................#..........',
    '.#............#..............................................................#........#................#........#.................',
    '..........................#..#.......................................................#.........#..................................',
    '.........#....#................#...........#...................##............#..........#.........................................',
    '....#...................................#....#.........#..........#.......................#..............................#........',
    '.............................#.....##.............................................................#..#...........................#',
    '....#................#...#.#..........#.#....#..................#..........#......#.............................#.................',
    '......................#............#......................................##................#..........#..#.............#.........',
    '..#........#............#.....###....##...........................#..............................#.....#..........................',
    '.....#...........#..#.........#...................#.#.................#........#............#.....#........#......................',
    '..........................................................................................................................#.......',
    '..#...................#.....................................................................#....................#................',
    '...............#............................#....#..........#...................#............#...............#..#.................',
    '................#...........................#...........................................#.........................#...............',
    '..........#.......#.........................##.................................................#...................##..#..........',
    '.#.........#...#..#............................................#........................#.......................................#.',
    '........#...........###..................#...........#..............#.....................#................#......................',
    '.............#....#............................#.#..............................#..#................................#.............',
    '...#.....#..........#...........#..................................................#........#...........#..#..........##.....#....',
    '...............................................................................#...................#........................##....',
    '......#.#...........................#.................#.................................................................#.........',
    '..................................#............................................................................#.#................',
    '........................#.......#.....#..........#..#.............##.................#..............#............##...............',
    '......#........................#........................................#......#..................................................',
    '...............##.......#..............................................................................................#..........',
    '....#...................................................................................#.........#..........#..............#.....',
    '.....#.............#.........................#.........#........#................#.#.........................#..........#.........',
    '.............#......##...........#................#...#.#.....#......................................#..........#.................',
    '...........................#............#................#................#...........................#.....#.....................',
    '.......#.................#..#..............#................................#....#........#.......#.............#....#....##......',
    '........................................................#........................................................................#',
    '.................#.........................................#.......#.......#......#...#.#.................##......................',
    '..........#............#..............................................#........................................#..........#..#....',
    '..............#......................................................#......#................................#....................',
    '...#........#.............#.................#......#.......................#..............................##........#.............',
    '.....................#............................................................#............#...............................#..',
    '......#.....#..............................................................#...............#...#..................................',
    '.......................................#..#.......#...#..............#.................................................#..........',
    '...................................................................................................#........................#.....',
    '....#.....#.......................................................#.....#......#...................#............#.................',
    '..............#....#.....................#........................................##....#...#.....................................',
    '.....#...............................................................#............#............................#..................',
    '........................#..........................#..............................................................................',
    '#..............#...........................................................................#......................................',
    '...................................#...#....................................................................#.....................',
    '................#......#.........#.................#...........................#..................................................',
    '......#...#................#...............#..................................................#...................................',
    '.......................#.............#..#....................#............#.......................................................',
    '.....................#.#.....................................#................................##.............#.#..#..............#',
    '.....................................#...#...........................#....................................................##...#..',
    '.................#..#............#.............................#..#................................................##.............',
    '...#...........................................#.................................................#.............#.............##...',
    '..................#....#....#.#..........................#.............#................#............................#............',
    '.........................#................#.#..#.#............^.........................................................#.........',
    '.....#...............#............................................................................................................',
    '.#.......................................................................................#...............#....#.............#.....',
    '......#................................#............#............................................................#................',
    '.#.....................#..............#.............#.......................#.....#....#.#.#...................#....#.............',
    '..................................................................#........#............................#..#.#...............#....',
    '.#.....................#......#........#.......#.................#.......................#..#.....................................',
    '..............#..#..#.............................................#....................#......#...................................',
    '.................##.#............................##..#...............................................................#....#.......',
    '...........#..#........................#.#..........#.................##.....#...#.........................#.#...#............#...',
    '.....................#..........#..#..............................................................................................',
    '.......#...............................#..#.........#.....................................#......#...................#............',
    '..............................##.#........#.......#..#.....#......................................................................',
    '..................#......................#.....................................###...#............................##..............',
    '...................................#...................................#...........................#....##..#.....................',
    '.....................#.....#.#.........#.........................#.....#.......#..........#.......................#...............',
    '...........#..................................................................................................#...................',
    '......#............................#.............................#..........................................#.....##..............',
    '...........................#...........................................................#.............................#..........#.',
    '..........................................#..........................................#......#...............#.....................',
    '..............##.........#........................................................................................................',
    '.....................#............#..#......#..#......................................................................#...........',
    '........#.........#.....................#.................................#...#.#....#....#......................#.#..............',
    '......#...........#............................................................#..............#......................#............',
    '.....#.....................#.....#.........#.............................#....#............................#......................',
    '..#..............................................................................................................#...#............',
    '..............#.......................#........#............................................#.......................#.............',
    '........................................#....................................................................................##...',
    '.......#..#.......#.................#.#.................#...........#............#........#.#.........#...........#.#..........#..',
    '.....##.......................#.........................#.........................#...........#.........#.....#...........#.......',
    '..........................#.....................#...............................#.............................#...................',
    '.....#..........#.............#...#..........................#.#...................#...........................#......#...........',
    '......................................#.......#.........#......................................#..................................',
    '......#...#....................#................#...#.......#.............#............#...........#.....#........................',
    '........................................#............#......................................................#............#........',
    '..#.......#....#..........................................................................#......................##..#.......#....',
    '................#...................................................#..........................................#..................',
    '...........#........................................................................................#.............................',
    '..................#........................................#.....#...........................#..................#.................',
    '........#.......#.....#...........#.......................................................#.........#.............................',
    '.............#.....#.#............................#...................................................................#...........',
    '...............#...................................#...........................#.............#..#..................#..##..........',
    '.#...............................#....#.....................#...................................#...................#...#.........',
    '..................#..#.#..................................................................................................#.......',
    '.........#.....#...#.........#........#...........................................#..................#.#.#......#.................',
    '.........#......#.......................#........#.............................#...#................#...........................#.',
    '...#.........................................................................................##........................#..........',
    '.....................................#...........................................................#.#...#......#...............#...',
    '#.....................#.........#.................................................#.....................................#.........',
    '............##.............................#...............................................#......................................',
    '.#.................#........................#.................................................................#.....#.............',
    '.....#.......................#......................#.................#....#....................................................#.',
    '.............................#..................................................................#.#...............................',
    '........#.......#.....##..........................................#...................#.........#...........#...#...#...#.........',
    '..........#.#...#.....................#............................................................##.........##..................',
    '...................#..............##.....#...........#.#.......#................................................#...............#.',
    '............................................................#....#.............#....##.......#...#...#................#...........',
    '......#...............................#.........#...................#....#..............#.................#.......................',
    '....................................#.....................#....#....#.................#...............#...........................',
    '.................................#.............#.#...................................#..............#...#.....#.............#.....',
    '......................#..................#.............#.................#................................................#.......',
    '.....................##.......................#.............#...#........#..........#.....#............................##...#.....',
    '..........................#.....................#...........#.....................................................#...............',
    '................#.....................................................................................................#...........',
    '........#......#.......................#....................................#................................#....................',
    '.....................................#............................................................................................',
    '........#..........#.........#.#................##................#...#..........................#.........#......##.......#......',
    '.......#...................#................................#..#.......................#..............................#...........',
    '............#.....................................#......#........................#..........#.............................#......',
    '..#...........#...........#...................................#............#...#.....#......................................#.....',
    '................................................................#...........#.......##.......#..........#............#............'
  ]
}