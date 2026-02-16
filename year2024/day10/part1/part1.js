import TopographicMap from "./topographic-map.js";
import TopographicMapDrawer from "./topographic-map-drawer.js";
import TrailheadFinder from "./trailhead-finder.js";

const topographicMap = new TopographicMap();
const twoDimensionsMap = topographicMap.getTwoDimensionsMap();

const mapDrawer = new TopographicMapDrawer();
mapDrawer.draw(twoDimensionsMap);

const trailheadFinder = new TrailheadFinder(twoDimensionsMap);
trailheadFinder.collect();
