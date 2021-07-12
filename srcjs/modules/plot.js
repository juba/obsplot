import * as Plot from "@observablehq/plot";

export class Obsplot {

    constructor(el, x) {
        
        this.data = Obsplot.convert_data(x.data);
        this.marks = x.marks || [];
        this.opts = x.opts || {};
        this.facet = x.facet;

    }

    plot(el) {

        const opts = this.opts;
        opts.marks = this.build_marks();
        opts.facet = this.build_facet();
        // If "auto", use Shiny widget size
        if (opts.width == "auto") opts.width = el.width;
        if (opts.height == "auto") opts.height = el.height;

        let p = Plot.plot(opts);
        el.append(p)

    }

    build_marks() {

        return this.marks.map((mark) => {
            
            const mark_fun = Plot[mark.type];
            
            // Decorations mark
            if (["frame"].includes(mark.type)) {
                return mark_fun.call(null, mark.opts)
            }
            
            // Mark data
            const data = Obsplot.convert_data(mark.data) || this.data;
            
            // Check for and apply any transform
            if (mark.transform !== undefined && mark.transform !== null) {
                mark.opts = {...Obsplot.call_transform(mark.transform), ...mark.opts}
            }
            
            return mark_fun.call(null, data, mark.opts)
        })

    }

    build_facet() {

        if (this.facet === undefined) return {};
        // Get facet data
        const data = Obsplot.convert_data(this.facet.data) || this.data;
        // Build facet
        let facet = this.facet.opts;
        facet.data = data
        return facet;

    }

    static convert_data(data) {

        if (data === undefined || data === null) return(null)
        // Check if data is a literal object
        // See https://stackoverflow.com/a/16608074
        if (data.constructor === Object) {
            return HTMLWidgets.dataframeToD3(data)
        }
        // If data is a single number, convert to array
        if (!Array.isArray(data)) {
            return [data];
        }
        return data;

    }

    static call_transform(transform) {

        const trans_fun = Plot[transform.transform_type];
        let trans_result = {};
        // Recursive call to compose transforms : if options is a transform,
        // apply it first
        if (transform.options.transform_type) {
            transform.options = Obsplot.call_transform(transform.options)
        }
        if (transform.outputs === null) {
            // transform with options only
            trans_result = trans_fun.call(null, transform.options);
        } else {
            // transform with outputs and options
            trans_result = trans_fun.call(null, transform.outputs, transform.options);
        }
        return trans_result;

    }

}
