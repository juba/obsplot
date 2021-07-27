import { Obsplot } from "../modules/plot";
import * as d3 from "d3";
import * as Plot from "@observablehq/plot";
import 'widgets';
import '../css/plot.css';

// Make libraries available to be used in JS()
window.d3 = d3;
window.Plot = Plot;

HTMLWidgets.widget({

  name: 'obsplot',

  type: 'output',

  factory: function(el, width, height) {

    let plot;

    el.width = width;
    el.height = height;

    return {

      renderValue: function(x) {

        plot = new Obsplot(el, x);
        plot.destroy();
        plot.plot();

      },

      resize: function(width, height) {

        el.width = width;
        el.height = height;
        plot.resize();

      }

    };
  }
});
