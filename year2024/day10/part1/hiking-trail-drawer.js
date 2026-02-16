export default class HikingTrailDrawer {
  constructor() {}

  draw(hikingTrail) {
    for(const position of hikingTrail) {
      let cellElement = documnet.getElementById(`cell-${position[0]}-${position[1]}`);

      if (cellElement !== null) {
        cellElement.className += ' route'
        // cellElement.classList.toggle('current')
        // await this.sleep(1);
        // cellElement.classList.toggle('current')
      }
    }
  }
}
