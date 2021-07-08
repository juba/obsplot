import { Obsplot } from "../modules/plot";
import 'widgets';
import '../css/plot.css';

HTMLWidgets.widget({

  name: 'obsplot',

  type: 'output',

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {

        let plot = new Obsplot(el, x);
        
        plot.plot();

      },

      resize: function(width, height) {


      }

    };
  }
});
