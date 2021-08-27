import * as d3 from "d3";

// Add menu to chart
export function create_menu(el) {

    // Menu div
    const menu = d3.select(el)
        .style("display", "flex")
        .style("align-items", "flex-start")
        .append("div")
        .attr("class", "obsplot-menu");

    // Gear icon
    const gear = menu
        .append("svg")
        .attr("class", "obsplot-gear")
        .append("g");
    gear.append("rect")
        .attr("width", "25")
        .attr("height", "25");
    gear.append("path")
        .attr("d", gear_path());

    // Menu body
    const menu_body = menu
        .append("ul")
        .attr("class", "obsplot-menu-body")
    // Export to SVG entry
    menu_body.append("li")
        .append("a")
        .on("click", function () { export_svg(this, el.querySelector("svg.plot")); })
        .html("Export to SVG");

    gear.on("click", (event, d, i) => {
        if (!menu_body.classed("open")) {
            menu_body.transition().duration(300)
                .style("opacity", "0.95")
                .style("width", "165px");
            gear.classed("selected", true);
            menu_body.classed("open", true);
        } else {
            menu_body.transition().duration(300)
                .style("opacity", "0")
                .style("width", "0px");
            gear.classed("selected", false);
            menu_body.classed("open", false);
        }
    });
}

// Export to SVG function
export function export_svg(sel, svg) {

    var svg_content = svg.outerHTML;

    var svg_data = "data:image/octet-stream;base64," + window.btoa(unescape(encodeURIComponent(svg_content)));

    d3.select(sel)
        .attr("download", "chart.svg")
        .attr("href", svg_data);
}

// Gear icon path
export function gear_path() {
    return "m 24.28,7.2087374 -1.307796,0 c -0.17052,-0.655338 -0.433486,-1.286349 -0.772208,-1.858846 l 0.927566,-0.929797 c 0.281273,-0.281188 0.281273,-0.738139 0,-1.019312 L 21.600185,1.8728727 C 21.319088,1.591685 20.863146,1.5914219 20.582048,1.8726096 L 19.650069,2.8001358 C 19.077606,2.4614173 18.446602,2.1982296 17.791262,2.0278389 l 0,-1.30783846 c 0,-0.39762 -0.313645,-0.72 -0.711262,-0.72 l -2.16,0 c -0.397618,0 -0.711262,0.32238 -0.711262,0.72 l 0,1.30783846 c -0.65534,0.1703907 -1.286345,0.43344 -1.858849,0.7722138 L 11.420092,1.8724435 c -0.281185,-0.2812846 -0.738131,-0.2812846 -1.019315,0 L 8.8728737,3.3998124 C 8.5916888,3.6809174 8.591427,4.1368574 8.872612,4.4179484 l 0.9275234,0.931984 c -0.3388099,0.572456 -0.6019076,1.203467 -0.7722956,1.858805 l -1.3078398,0 c -0.3976159,0 -0.72,0.313643 -0.72,0.711263 L 7,10.08 c 0,0.397661 0.3223841,0.711263 0.72,0.711263 l 1.3078398,0 c 0.170388,0.655338 0.4334414,1.286349 0.7722084,1.858846 L 8.872349,13.579906 c -0.2811836,0.281105 -0.2811836,0.738139 0,1.019188 l 1.527378,1.527951 c 0.281185,0.28127 0.737041,0.281533 1.018224,3.04e-4 l 0.931981,-0.927484 c 0.572461,0.338718 1.203466,0.601823 1.858806,0.772338 l 0,1.307797 c 0,0.397662 0.313644,0.72 0.711262,0.72 l 2.16,0 c 0.39766,0 0.711262,-0.32238 0.711262,-0.72 l 0,-1.307797 c 0.65534,-0.170515 1.286344,-0.433481 1.858849,-0.772214 l 0.929797,0.927568 c 0.281098,0.281271 0.738131,0.281271 1.019184,0 l 1.527947,-1.527369 c 0.281273,-0.281105 0.281534,-0.737045 3.06e-4,-1.018136 l -0.92748,-0.931984 c 0.338723,-0.572456 0.601819,-1.203467 0.772339,-1.858805 l 1.307796,0 c 0.39766,0 0.72,-0.313643 0.72,-0.711263 l 0,-2.1599996 c 0,-0.39762 -0.322384,-0.711263 -0.72,-0.711263 z M 16,12.6 c -1.988258,0 -3.6,-1.611789 -3.6,-3.5999996 0,-1.988252 1.611742,-3.6 3.6,-3.6 1.988258,0 3.6,1.611748 3.6,3.6 C 19.6,10.988252 17.988258,12.6 16,12.6 Z";
}