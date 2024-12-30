export default class PathPrediction {
  constructor(twoDimensionsMap, startingPosition, startingDirection) {
    this.twoDimensionsMap = twoDimensionsMap;
    this.startingPosition = startingPosition;
    this.startingDirection = startingDirection;
    this.isPredicting = false;
  }

  setTwoDimensionsMap(value) {
    this.twoDimensionsMap = value;
  }

  setIsPredicting(value) {
    this.isPredicting = value;
  }

  sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async predict() {
    let currentGuardPosition = this.startingPosition
    let currentGuardDirection = this.startingDirection
    this.isPredicting = true;
    let path = []

    while(!this.isOutOfMappedArea(currentGuardPosition) && this.isPredicting) {
      path.push(currentGuardPosition)

      const nextPositionAndDirection = this.getNextPositionAndDirection(currentGuardPosition, currentGuardDirection)

      currentGuardPosition = nextPositionAndDirection[0]
      currentGuardDirection = nextPositionAndDirection[1]

      let cellElement = document.getElementById(`cell-${currentGuardPosition[0]}-${currentGuardPosition[1]}`);

      if (cellElement !== null) {
        cellElement.className += ' route'
        cellElement.classList.toggle('current')
        await this.sleep(10);
        cellElement.classList.toggle('current')
      }
    }

    this.isPredicting = false;
    return path
  }

  isOutOfMappedArea(currentPosition) {
    return currentPosition[0] < 0 ||
      currentPosition[1] < 0 ||
      this.twoDimensionsMap[currentPosition[0]] === undefined ||
      this.twoDimensionsMap[currentPosition[0]][currentPosition[1]] === undefined
  }

  getNextPositionAndDirection(currentPosition, currentDirection) {
    const objectDirectlyInFront = this.getObjectDirectlyInFront(currentPosition, currentDirection)

    let nextDirection = null;

    if (objectDirectlyInFront === '#') {
      switch (currentDirection) {
        case '^':
          nextDirection = '>';
          break;
        case '>':
          nextDirection = 'v';
          break;
        case 'v':
          nextDirection = '<';
          break;
        default: // case '<'
          nextDirection = '^';
      }

      return [this.getPositionDirectlyInFront(currentPosition, nextDirection), nextDirection]
    } else {
      return [this.getPositionDirectlyInFront(currentPosition, currentDirection), currentDirection]
    }
  }

  getPositionDirectlyInFront(currentPosition, currentDirection) {
    if (currentDirection === '^') {
      return [currentPosition[0] - 1, currentPosition[1]]
    }

    if (currentDirection === 'v') {
      return [currentPosition[0] + 1, currentPosition[1]]
    }

    if (currentDirection === '>') {
      return [currentPosition[0], currentPosition[1] + 1]
    }

    if (currentDirection === '<') {
      return [currentPosition[0], currentPosition[1] - 1]
    }

    throw 'Invalid direction'
  }

  getObjectDirectlyInFront(currentPosition, currentDirection) {
    const nextPosition = this.getPositionDirectlyInFront(currentPosition, currentDirection)

    if (this.isOutOfMappedArea(currentPosition)) {
      return null;
    }

    if (this.twoDimensionsMap[nextPosition[0]] === undefined) {
      return null;
    }

    return this.twoDimensionsMap[nextPosition[0]][nextPosition[1]]
  }
}
