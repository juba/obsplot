import * as Plot from "@observablehq/plot";

class Obsplot {

    constructor(el, x) {
        
        this.el = el;
        this.data = Obsplot.convert_data(x.data);
        this.marks = x.marks === null ? [] : x.marks;
        this.opts = x.opts === undefined ? {} : x.opts;
        this.facet = x.facet;
    }

    plot() {
        const opts = this.opts;
        opts.marks = this.build_marks();
        opts.facet = this.build_facet();
        const p = Plot.plot(opts);
        this.el.append(p)
    }

    build_marks() {
        return this.marks.map((mark) => {
            const mark_fun = Plot[mark.type];
            // Decorations
            if (["frame"].includes(mark.type)) {
                return mark_fun.call(null, mark.opts)
            }
            // Data marks
            const data = Obsplot.convert_data(mark.data);
            // Transform
            if (mark.opts.transform !== undefined) {
                const transform = mark.opts.transform;
                const trans_fun = Plot[transform.transform_type];
                if (transform.outputs === null) {
                    // transform with options only
                    mark.opts = trans_fun.call(null, transform.options);
                } else {
                    // transform with outputs and options
                    mark.opts = trans_fun.call(null, transform.outputs, transform.options);
                }
            }
            return mark_fun.call(null, data, mark.opts)
        })
    }

    build_facet() {
        if (this.facet === undefined) return {};
        const data = this.facet.data === null ? this.data : HTMLWidgets.dataframeToD3(this.facet.data);
        let facet = this.facet.opts;
        facet.data = data
        return facet;
    }

    static convert_data(data) {
        if (data === undefined || data === null) return(null)
        if (typeof(data[0]) == "object") {
            return HTMLWidgets.dataframeToD3(data)
        }
        return(data)
    }
    

}

export { Obsplot }