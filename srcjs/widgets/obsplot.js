import { Obsplot } from "../modules/plot";
import * as d3 from "d3";
import * as Plot from "@observablehq/plot";
import 'widgets';
import '../css/plot.css';

window.d3 = d3;
window.Plot = Plot;

HTMLWidgets.widget({

  name: 'obsplot',

  type: 'output',

  factory: function(el, width, height) {

    el.width = width;
    el.height = height;

    return {

      renderValue: function(x) {

        const plot = new Obsplot(el, x);
        plot.plot(el);

      },

      resize: function(width, height) {
        el.width = width;
        el.height = height;
        plot.plot(el);
      }

    };
  }
});
