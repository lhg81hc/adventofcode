export default class MyDrawer {
  constructor() {
  }

  sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  drawMap(twoDimensionsMap) {
    const wrapper = document.getElementById('wrapper')

    for (let rowIdx = 0; rowIdx < twoDimensionsMap.length; rowIdx++) {
      let rowElement = document.getElementById(`row-${rowIdx}`);

      if (rowElement === null) {
        rowElement = document.createElement('div');
        rowElement.id = `row-${rowIdx}`;
        rowElement.className = 'row';
      }

      wrapper.appendChild(rowElement);

      for (let charIdx = 0; charIdx < twoDimensionsMap[0].length; charIdx++) {
        const char = twoDimensionsMap[rowIdx][charIdx];
        let cellElement = document.getElementById(`cell-${rowIdx}-${charIdx}`);

        if (cellElement === null) {
          cellElement = document.createElement('div');
          cellElement.id = `cell-${rowIdx}-${charIdx}`;
        }

        cellElement.className = 'cell'

        if (char === '#') {
          cellElement.className += ' obstacle'
        } else {
          cellElement.className += ' ground'
        }

        rowElement.appendChild(cellElement);
      }
    }
  }

  drawSpecialObstacle(obstaclePosition) {
    let cellElement = document.getElementById(`cell-${obstaclePosition[0]}-${obstaclePosition[1]}`);
    if (cellElement) {
      if (!cellElement.classList.contains('special-obstacle')) {
        cellElement.className += ' special-obstacle'
      }
    }
  }

  async drawPath(path) {
    for (const position of path) {
      let cellElement = document.getElementById(`cell-${position[0]}-${position[1]}`);

      if (cellElement !== null) {
        cellElement.className += ' route'
        cellElement.classList.toggle('current')
        await this.sleep(1);
        cellElement.classList.toggle('current')
      }
    }
  }
}
