import { Obsplot } from "../modules/plot";
import 'widgets';
import '../css/plot.css';

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
