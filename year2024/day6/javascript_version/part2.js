import ManufacturingLabBlueprint from "./manufacturing_lab_blueprint.js";
import PathPrediction from "./path_prediction.js";
import MyDrawer from "./my_drawer.js";

const labBlueprint = new ManufacturingLabBlueprint();
const currentPositionAndDirection = labBlueprint.getCurrentGuardPositionAndDirection();
const twoDimensionsMap = labBlueprint.getTwoDimensionsMap();

const drawer = new MyDrawer();

drawer.drawMap(twoDimensionsMap);
const pathPrediction = new PathPrediction([], currentPositionAndDirection[0], currentPositionAndDirection[1])

function handleFormSubmitted(event) {
  const data = Object.fromEntries(new FormData(event.target).entries());

  const obstaclePosition = data['position'].split(',');
  let newTwoDimensionsMap = []
  for (var i = 0; i < twoDimensionsMap.length; i++) {
    newTwoDimensionsMap[i] = twoDimensionsMap[i].slice();
  }
  newTwoDimensionsMap[parseInt(obstaclePosition[0])][parseInt(obstaclePosition[1])] = '#'

  if (pathPrediction.isPredicting) {
    pathPrediction.setIsPredicting(false);
  } else {
    drawer.drawMap(newTwoDimensionsMap);
    drawer.drawSpecialObstacle(obstaclePosition);
    pathPrediction.setTwoDimensionsMap(newTwoDimensionsMap);
    pathPrediction.predict();
  }

  event.preventDefault();
}

const form = document.getElementById("form");
form.addEventListener('submit', handleFormSubmitted)
