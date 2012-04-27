/**
 * Created by PyCharm.
 * User: xiejian
 * Date: 1/13/12
 * Time: 5:24 PM
 * To change this template use File | Settings | File Templates.

 */

var v_contlist;
function get_contlist(){
    $.getJSON($SCRIPT_ROOT + '/data', {t: 'cl'}, function(data) {
        v_contlist = data;
        update_conttop();
        update_contlist();
    });
    return false;
}

function update_conttop(){
    var tcolumns = [
        {id: "name", name: "Name", field: "n",width:65, asyncPostRender: rendercontName},
        {id: "latestpt", name: "Latest PT", field: "lp",width:50},
        {id: "change", name: "Change", field: "ch",width:53, formatter: updn_percent}
    ];
    var toptions = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        enableAsyncPostRender: true,
        rowHeight: 28
    };

    v_contv = v_contlist['O'].sort(function(x,y){return y['vl']-x['vl'];});
    var vgrid = new Slick.Grid("#top_v_grid", v_contv, tcolumns, toptions);
    v_contu = v_contlist['O'].sort(function(x,y){return y['ch']-x['ch'];});
    var ugrid = new Slick.Grid("#top_u_grid", v_contu, tcolumns, toptions);
    v_contd = v_contlist['O'].sort(function(x,y){return x['ch']-y['ch'];});
    var dgrid = new Slick.Grid("#top_d_grid", v_contd, tcolumns, toptions);

    $(".scrollable[title=top]").scrollable({circular: true}).navigator({navi: '.scrollnavi', naviItem: 'a'}).autoscroll({ autoplay: true });
}

function update_contlist(){
    var cl = {
        st:{id: "status", name: "Status", field: "st",width:60, sortable:true, formatter:function(row, cell, value){return _dec['st'][value];}},
        n:{id: "name", name: "Name", field: "n", sortable:true,asyncPostRender: rendercontName},
        fn:{id: "fullname", name: "Fullname", field: "fn",width:100, sortable:true},
        od:{id: "opendt", name: "Open DT", field: "od", sortable:true,formatter:function(row, cell, value){return parseDate(value);}},
        sd:{id: "settledt", name: "Settle DT", field: "sd", sortable:true,formatter:function(row, cell, value){return parseDate(value);}},
        r:{id: "region", name: "Region", field: "r", width:100,sortable:true, formatter:function(row, cell, value){return _dec['r'][value];}},
        s:{id: "sector", name: "Sector", field: "s", width:100,sortable:true, formatter:function(row, cell, value){return _dec['s'][value];}},
        lp:{id: "latestpt", name: "Latest PT", field: "lp", sortable:true},
        ch:{id: "change", name: "Change", field: "ch",width:70, sortable:true,formatter: updn_percent},
        sp:{id: "settlept", name: "Settle PT", field: "sp", sortable:true},
        vl:{id: "volume", name: "Volume", field: "vl", sortable:true},
        o:{id: "owner", name: "Author", field: "o", width:120, sortable:true},
        a:{id: "trade", name: "", field: "c",width:70,formatter: function ( row, cell, value, columnDef, dataContext ) {
            return '<a href="'+$SCRIPT_ROOT + '/trade?c=' + dataContext['c'] + '"> TRADE </a>';}
        }
    };
    var options = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        multiColumnSort: true,
        enableAsyncPostRender: true,
        rowHeight: 28
    };
    //var data = [];
    var ocolumns=[cl.n,cl.fn,cl.sd,cl.r,cl.s,cl.lp,cl.ch,cl.vl,cl.a];
    var ncolumns=[cl.st,cl.n,cl.fn,cl.od,cl.sd,cl.r,cl.s,cl.o];
    var ccolumns=[cl.st,cl.n,cl.fn,cl.sd,cl.r,cl.s,cl.sp,cl.o];
    var ogrid = new Slick.Grid("#o_cont_grid", v_contlist['O'], ocolumns, options);
    var ngrid = new Slick.Grid("#n_cont_grid", v_contlist['N'], ncolumns, options);
    var cgrid = new Slick.Grid("#c_cont_grid", v_contlist['C'], ccolumns, options);

    ogrid.onSort.subscribe(multi_sort);
    ngrid.onSort.subscribe(multi_sort);
    cgrid.onSort.subscribe(multi_sort);
}

$(function () {
    activepage(0);
    showtab(0);
    get_contlist();
});

