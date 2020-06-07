tyrano.plugin.kag.fall_mask = {





    shapes: [],





    addStar: function(cx, cy, viewRadius, points, outerRadius, innerRadius, options, draw){

        var that = tyrano.plugin.kag.fall_mask;

        var STAGE = document.getElementById('fall_mask_canvas');

        if (draw) that.drawStar(STAGE, cx, cy, viewRadius, points, outerRadius, innerRadius, options);

        var shape = { canvas:STAGE, cx:cx, cy:cy, points:points, outerRadius:outerRadius, innerRadius:innerRadius, options:options };
        that.shapes.push(shape);
        console.log(that.shapes);

    },





    drawStar: function(canvas, cx, cy, viewRadius, points, outerRadius, innerRadius, options) {

        var i, x, y, radians, halfRadians, angle, oneAngle, base, height;
        var ctx, strokeColor, strokeWidth, fillColor;

        var ctx = canvas.getContext('2d');

        outerRadius = (outerRadius) ? outerRadius : 0;
        innerRadius = (innerRadius) ? innerRadius : 0;

        var oneAngle = 360 / points;

        var strokeColor = (options && options.strokeColor) ? options.strokeColor : '#000';
        var strokeWidth = (options && options.strokeWidth) ? options.strokeWidth : 0;
        var fillColor   = (options && options.fillColor)   ? options.fillColor   : '#000';

        ctx.save();
        ctx.beginPath();

        for (i = 0; i < points; i++) {
            var angle       = -90 + (oneAngle * i);
            var radians     = angle * (Math.PI / 180);
            var halfRadians = (angle + (oneAngle / 2)) * (Math.PI / 180);

            var base   = (viewRadius + outerRadius) * Math.cos(radians);
            var height = (viewRadius + outerRadius) * Math.sin(radians);

            var x = cx + base;
            var y = cy + height;

            if (i === 0) {
                ctx.moveTo(x, y);
            } else {
                ctx.lineTo(x, y);
            }

            var base   = (viewRadius - innerRadius) * Math.cos(halfRadians);
            var height = (viewRadius - innerRadius) * Math.sin(halfRadians);

            var x = cx + base;
            var y = cy + height;

            ctx.lineTo(x, y);
        }

        ctx.closePath();

        if (fillColor !== 'transparent') {
            ctx.fillStyle = fillColor;
            ctx.fill();
        }

        if (strokeColor !== 'transparent' && strokeWidth > 0) {
            ctx.lineWidth   = strokeWidth;
            ctx.strokeStyle = strokeColor;
            ctx.stroke();
        }

        ctx.restore();

        return canvas;

    }





}
