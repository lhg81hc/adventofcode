import Input from './input.js';

export default class ManufacturingLabBlueprint {
  constructor() {
    this.twoDimensionsMap = this.initTwoDimensionsMap()
  }

  getTwoDimensionsMap() {
    return this.twoDimensionsMap;
  }

  setTwoDimensionsMap(value) {
    this.twoDimensionsMap = value;
  }

  getCurrentGuardPositionAndDirection() {
    const height = this.twoDimensionsMap.length
    const width = this.twoDimensionsMap.length

    for (let rowIdx = 0; rowIdx < height; rowIdx++) {
      for (let charIdx = 0; charIdx < width; charIdx++) {
        const currentChar = this.twoDimensionsMap[rowIdx][charIdx];
        if (currentChar === '^' || currentChar === '>' || currentChar === '<' || currentChar === 'v') {
          return [[rowIdx, charIdx], currentChar]
        }
      }
    }

    return [[null, null], null];
  }

  initTwoDimensionsMap() {
    let r = [];

    Input.data.forEach(row => {
      r.push(row.trimEnd().split(''))
    })

    return r;
  }
}
