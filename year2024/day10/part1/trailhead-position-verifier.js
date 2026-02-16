export default class TrailheadPositionVerifier {
  constructor(twoDimensionsMap, currentX, currentY) {
    this.twoDimensionsMap = twoDimensionsMap
    this.currentX = currentX;
    this.currentY = currentY;
  }

  async getScore() {
    let stack = [];
    let score = 0;

    this.getValidAdjacentPositions(this.currentX, this.currentY).forEach(k => {
      stack.push([[this.currentX, this.currentY], k])
    })

    if (stack.length === 0) {
      return 0
    }

    while(stack.length !== 0) {
      let currentHikingTrail = stack.pop();
      this.drawHikingTrail(currentHikingTrail);

      let lastPosition = currentHikingTrail[currentHikingTrail.length - 1];

      let validAdjacentPositions = this.getValidAdjacentPositions(lastPosition[0], lastPosition[1])

      console.log('---------------------------')
      console.log(`currentHikingTrail: ${currentHikingTrail.map(i => i.join(',')).join(' -> ')}`)


      validAdjacentPositions.forEach(p => {
        if (currentHikingTrail.length === 9) {
          console.log(`validAdjacentPositions.length: ${validAdjacentPositions.length}`);
          console.log(`lastPosition: ${p.join(',')}`)
          score = score + 1;
        } else {
          stack.push([...currentHikingTrail, p])
        }

        // this.drawCurrentPosition(p);
      })

      this.sleep(1000);
    }

    return score
  }

  drawHikingTrail(currentHikingTrail) {
    Array.from(document.querySelectorAll('.route')).forEach(function(el) {
      el.classList.remove('route');
    });
    // Array.from(document.querySelectorAll('.current')).forEach(function(el) {
    //   el.classList.remove('current');
    // });

    currentHikingTrail.forEach (p => {
      const element = document.getElementById(`cell-${p[1]}-${p[0]}`);
      if (element) {
        element.classList.add("route")
      }
    })

    // if (cellElement !== null) {
    //   cellElement.className += ' route'
    //   cellElement.classList.toggle('current')
    //   await this.sleep(10);
    //   cellElement.classList.toggle('current')
    // }
  }

  // async drawCurrentPosition(currentPosition) {
  //   await this.sleep(1000);
  //
  //   const element = document.getElementById(`cell-${currentPosition[1]}-${currentPosition[0]}`);
  //   if (element) {
  //     element.classList.add('current')
  //   }
  // }

  sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  getValidAdjacentPositions(currentX, currentY) {
    return this.getAdjacentPosition(currentX, currentY).filter(p => this.twoDimensionsMap[p[1]][p[0]] === this.twoDimensionsMap[currentY][currentX] + 1)
  }

  getAdjacentPosition(x, y) {
    let r = []

    if (x === 0) {
      r.push([x + 1, y])
    } else if (x === this.twoDimensionsMapWidth - 1) {
      r.push([x - 1, y])
    } else {
      r.push([x + 1, y])
      r.push([x - 1, y])
    }

    if (y === 0) {
      r.push([x, y + 1])
    } else if (y === this.twoDimensionsMapHeight - 1) {
      r.push([x, y - 1])
    } else {
      r.push([x, y + 1])
      r.push([x, y - 1])
    }

    return r;
  }
}
