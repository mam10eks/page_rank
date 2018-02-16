var _mam10eks$page_rank$Native_NativeModule = function() {
    var svg;
    
    function svgMetrics() {
        var width = 0;
        var height = 0;
        var top = 0;
        var left = 0;

        if(svg === undefined) {
            var tmp = document.querySelectorAll("svg");

            if(tmp !== undefined && 1 === tmp.length) {
                svg = tmp[0];
            }
        }

        if(svg !== undefined) {
            var dim = svg.getBoundingClientRect();
            width = dim.width;
            height = dim.height;
            left = dim.left;
            top = dim.top;
        }
    
        return {width: width, height: height, top: top, left: left};
    }

    return { svgMetrics: svgMetrics };
}();