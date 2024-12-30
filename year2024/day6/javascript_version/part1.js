import ManufacturingLabBlueprint from "./manufacturing_lab_blueprint.js";
import PathPrediction from "./path_prediction.js";
import MyDrawer from "./my_drawer.js";

const labBlueprint = new ManufacturingLabBlueprint();
const twoDimensionsMap = labBlueprint.getTwoDimensionsMap();
const currentPositionAndDirection = labBlueprint.getCurrentGuardPositionAndDirection();

const pathPrediction = new PathPrediction(twoDimensionsMap, currentPositionAndDirection[0], currentPositionAndDirection[1])

const drawer = new MyDrawer();
drawer.drawMap(twoDimensionsMap);
const path = pathPrediction.predict();

let visitedPosition = {}
let totalVisitedPosition = 0
let secondaryElement = document.getElementById('secondary');

for (const position of path) {
  const positionStr = position.join(',');

  if (visitedPosition[positionStr] === undefined) {
    visitedPosition[positionStr] = true
    totalVisitedPosition += 1;
  }
}

secondaryElement.innerHTML = `Total distinct positions that the guard will visit before leaving the mapped area: ${totalVisitedPosition}`;
