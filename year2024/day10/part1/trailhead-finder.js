import TrailheadPositionVerifier from "./trailhead-position-verifier.js";

export default class TrailheadFinder {
  constructor(twoDimensionsMap) {
    this.twoDimensionsMap = twoDimensionsMap
  }

  collect() {
    // this.getZeroHeightPositions().forEach(i => console.log(`[${i[0]}, ${i[1]}]`));

    // this.getValidAdjacentPositions(15, 0, 0)
    // this.getValidAdjacentPositions(15, 0, 0).forEach(i => console.log(`[${i[0]}, ${i[1]}]`));
    // const zeroHeightPositions = this.getZeroHeightPositions();
    const trailheadPositionVerifier = new TrailheadPositionVerifier(this.twoDimensionsMap, 2, 0);

    console.log(trailheadPositionVerifier.getScore());
    // zeroHeightPositions.forEach(p => {
    //   const stack = [];
    //
    //   this.getValidAdjacentPositions(p[0], p[1], this.twoDimensionsMap[p[1]][p[0]]).forEach(k => {
    //     stack.push(k)
    //   })
    //
    //
    // })
  }

  getZeroHeightPositions() {
    let r = [];

    this.twoDimensionsMap.forEach((row, rowIdx) => {
      row.forEach((char, charIdx) => {
        if (char === 0) {
          r.push([charIdx, rowIdx])
        }
      })
    })

    return r;
  }
}
