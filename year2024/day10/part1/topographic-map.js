import Input from "./input.js";

export default class TopographicMap {
  constructor() {
    this.twoDimensionsMap = this.initTwoDimensionsMap();
    console.log(this.twoDimensionsMap[0]);
    this.twoDimensionsMapWidth = this.twoDimensionsMap[0].length;
    this.twoDimensionsMapHeight = this.twoDimensionsMap.length;
  }

  getTwoDimensionsMap() {
    return this.twoDimensionsMap;
  }

  getTwoDimensionsMapWidth() {
    return this.twoDimensionsMapWidth;
  }

  getTwoDimensionsMapHeight() {
    return this.twoDimensionsMapHeight;
  }

  initTwoDimensionsMap() {
    let r = [];

    Input.data.forEach(row => {
      r.push(row.trimEnd().split('').map(i => parseInt(i)))
    })

    return r
  }
}
