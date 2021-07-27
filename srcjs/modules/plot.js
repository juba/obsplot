import * as Plot from "@observablehq/plot";

export class Obsplot {

    constructor(el, x) {

        this.data = Obsplot.convert_data(x.data);
        this.marks = x.marks || [];
        this.facet = x.facet;
        
        this.opts = x.opts || {};
        // Store original width and height values
        this.opts.orig_width = this.opts.width;
        this.opts.orig_height = this.opts.height;
        
        this.el = el;

    }

    plot() {

        const opts = this.opts;
        let p;
        // If "auto", use Shiny widget size
        if (opts.orig_width == "auto") opts.width = this.el.width;
        if (opts.orig_height == "auto") opts.height = this.el.height;
        try {
            // Build plot
            opts.marks = this.build_marks();
            opts.facet = this.build_facet();
            p = Plot.plot(opts);
        } catch(error) {
            p = document.createElement("div");
            p.className = "obsplot-error";
            p.append(error);
            console.log(p);
        } 
        this.el.append(p)

    }

    destroy() {

        let range = document.createRange();
        range.selectNodeContents(this.el);
        range.deleteContents();

    }

    resize() {  

        if (this.opts.orig_width !== null && this.opts.orig_width != "auto" &&
            this.opts.orig_height !== null && this.opts.orig_height != "auto") return;
        this.destroy();
        this.plot();

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
            // Data channels
            if (mark.data_channels) {
                if (!Array.isArray(mark.data_channels)) mark.data_channels = [mark.data_channels];
                mark.data_channels.forEach(chan => 
                    mark.opts[chan] = Obsplot.convert_data(mark.opts[chan])
                )
            }
        
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

        if (data.data === undefined || data.data === null) return(null)
        
        // If data is a data frame
        if (data.type == "data.frame") {
            let date_columns = data.dates;
            data =  HTMLWidgets.dataframeToD3(data.data)
            // Convert date columns to Date
            if (!Array.isArray(date_columns)) date_columns = [date_columns]    
            data = data.map(d => {
                date_columns.forEach(col => d[col] = new Date(d[col]));
                return d;
            })
            return data;
        }

        // If data is an array (an R vector)
        if (data.type == "vector") {
            if (data.dates) {
                data.data = data.data.map(d => new Date(d));
            };
            return data.data;
        }

        // If data is a single number or string (an R scalar)
        if (data.type == "scalar") {
            if (data.dates) data.data = new Date(data.data);
            return [data.data];
        }

        // If data is a list
        if (data.type == "list") {
            return data.data;
        }

        return data.data;

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
