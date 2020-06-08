tyrano.plugin.kag.loadcsv = {

    decleareArrays: function(pm,data){
        var that = this;
        var res = [];
        for (var i=0; i<data.length; i++) {
            if (data[i] == '') break;
            res[i] = data[i].split(',');
            for (var j=0; j<res[i].length; j++) {
                res[i][j] = res[i][j].replace(/(^\s+)|(\s+$)/g,"");
                if (pm.parse_float) res[i][j] = that.parseNum(res[i][j]);
                if (pm.lower_bool) res[i][j] = that.lowerBool(res[i][j]);
            }
        }
        return res;
    },

    boolean: function(val){
        if (val === 'true' || val === true) return true;
        else return false;
    },

    parseNum: function(val){
        if (typeof val === 'string' && !!val && !Number.isNaN(+val) && val.indexOf('0x') < 0) return parseFloat(val);
        else return val;
    },

    lowerBool: function(val){
        if(typeof val === 'string'){
            if (val == 'TRUE') return true;
            else if (val == 'FALSE') return false;
            else return val;
        } else {
            return val;
        }
    },

    debugLog: function(pm){
        var that = this;
        var f = TYRANO.kag.stat.f,
            tf = TYRANO.kag.variable.tf,
            sf = TYRANO.kag.variable.sf,
            mp = TYRANO.kag.stat.mp;
        if (pm.log) {
            console.log('variable: ' + pm.var);
            console.log(eval(pm.var));
        }
    }
}



tyrano.plugin.kag.tag.loadcsv = {

    vital: ['src'],

    pm: {
        var: 'tf.loaded_csv',
        time: '10',
        log: 'false',
        parse_float: 'true',
        lower_bool: 'true',
    },

    start: function(pm){

        var that = this.kag.loadcsv;
        var f = TYRANO.kag.stat.f,
            tf = TYRANO.kag.variable.tf,
            sf = TYRANO.kag.variable.sf,
            mp = TYRANO.kag.stat.mp;

        if (!pm.src) {
            console.error('[ERROR] The CSV file is not specified correctly');
            return false;
        }
        if (parseInt(pm.time) == 0) {
            console.warn('[WARNING] time cannot be a number less than or equal to 0 (re-set the time to 10)');
            pm.time = 10;
        }

        pm.parse_float = that.boolean(pm.parse_float);
        pm.lower_bool = that.boolean(pm.lower_bool);
        pm.log = that.boolean(pm.log);

        var url = './data/others/' + pm.src;
        $.get(url, function(data){
            data = data.split("\n");
            setTimeout(function(){
                var array = that.decleareArrays(pm,data);
                eval(pm.var + '= array');
                that.debugLog(pm);
                TYRANO.kag.ftag.nextOrder();
            }, parseInt(pm.time));
        });
    }
};



tyrano.plugin.kag.tag.loadcsv_xmlhttp = {

    vital: ['src'],

    pm: {
        var: 'tf.loaded_csv',
        time: '10',
        log: 'false',
        parse_float: 'true',
        lower_bool: 'true',
    },

    start: function(pm){

        var that = this.kag.loadcsv;
        var f = TYRANO.kag.stat.f,
            tf = TYRANO.kag.variable.tf,
            sf = TYRANO.kag.variable.sf,
            mp = TYRANO.kag.stat.mp;

        if (!pm.src) {
            console.error('[ERROR] The CSV file is not specified correctly');
            return false;
        }

        pm.parse_float = that.boolean(pm.parse_float);
        pm.lower_bool = that.boolean(pm.lower_bool);
        pm.log = that.boolean(pm.log);

        var array = (function(){
            var url = './data/others/' + pm.src;
            var a, arr = [];
            var txt = new XMLHttpRequest();
            txt.open('get', url, false);
            txt.send();
            arr = txt.responseText.split('\n');
            var res = [];
            for(var i=0; i<arr.length; i++){
                if(arr[i] == '') break;
                res[i] = arr[i].split(',');
                for(var j=0; j<res[i].length; j++){
                    res[i][j] = res[i][j].replace(/(^\s+)|(\s+$)/g,"");
                    if (pm.parse_float) res[i][j] = that.parseNum(res[i][j]);
                    if (pm.lower_bool) res[i][j] = that.lowerBool(res[i][j]);
                }
            }
            return res;
        }());

        eval(pm.var + '= array');
        that.debugLog(pm);

        this.kag.ftag.nextOrder();

    }

};



(function(tag_names){
    tag_names.forEach(function(tag_name){
        tyrano.plugin.kag.ftag.master_tag[tag_name] = object(tyrano.plugin.kag.tag[tag_name]);
        tyrano.plugin.kag.ftag.master_tag[tag_name].kag = TYRANO.kag;
    });
}(['loadcsv','loadcsv_xmlhttp']));
