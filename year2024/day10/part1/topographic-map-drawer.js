export default class TopographicMapDrawer {
  constructor() {}

  draw(twoDimensionsMap) {
    const wrapper = document.getElementById('wrapper');

    for(let rowId = 0; rowId < twoDimensionsMap.length; rowId++) {
      let rowElement = document.getElementById(`row-${rowId}`)

      if (rowElement === null) {
        rowElement = document.createElement('div');
        rowElement.id = `row-${rowId}`;
      }

      rowElement.className = 'row';
      wrapper.appendChild(rowElement);

      for(let charId = 0; charId < twoDimensionsMap[0].length; charId++) {
        const char = twoDimensionsMap[rowId][charId];
        let cellElement = document.getElementById(`cell-${rowId}-${charId}`);

        if (cellElement === null) {
          cellElement = document.createElement('div');
          cellElement.id = `cell-${rowId}-${charId}`;
        }

        cellElement.className = 'cell ground';
        cellElement.innerHTML = char;

        rowElement.appendChild(cellElement);
      }
    }
  }
}
