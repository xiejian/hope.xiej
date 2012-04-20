/**
 * Created by PyCharm.
 * User: xiejian
 * Date: 1/13/12
 * Time: 3:47 PM
 * To change this template use File | Settings | File Templates.
 */

function getiploc(){
    $('.ip').each(function(i,td){
        $.get("http://api.hostip.info/get_html.php?ip="+$(td).html()+"&callback=?",function(data){
                $(td).next().html(data.replace(/^(.*)IP:.*$/m, '$1'));
            });
    });
}

function test(){
    return 'hi'
}

var v_gl;
function get_gl(){
    $.getJSON($SCRIPT_ROOT + '/data', {t: 'ua'}, function(data) {
        v_gl = data['trans'];
        v_gl['openbal']=data['openbal'];
        update_gl();
    });
    return false;
}
function update_gl(){
    var columns = [
        {id: "time", name: "Time", field: "t", sortable:true,formatter:function(row, cell, value){return parseDate(value);}},
        {id: "s", name: "Action", field: "s",width:80,formatter:function(row, cell, value, columnDef, dataContext){
            if(value =='T'){return '<img src="/static/img/_i_'+dataContext['ty']+'.png" title="'+_dec['t'][dataContext['ty']]+'"/><img src="/static/img/_i_'+dataContext['bs']+'.png" title="'+_dec['t'][dataContext['bs']]+'"/>';}
            else if(value=='H'){return '<img src="/static/img/logo.s.gif" title="BTCFE contract" style="height:20px;width: 34px;"/> ' +dataContext['ty'];}
            else if(value=='B'){return '<img src="/static/img/_i_BTC.png" title="Bitcoin"/> ' + dataContext['ty'];}
            else {return value;}
        }},
        {id: "name", name: "Name", field: "n", width:90, sortable:true,asyncPostRender: rendercontName},
        {id: "point", name: "Point", field: "pt", sortable:true},
        {id: "lt", name: "Lots", field: "lt", width:40,sortable:true},
        {id: "v", name: "Value", field: "v", width:90, sortable:true},
        {id: "pl", name: "P/L", field: "pl", width:90,sortable:true,formatter: function ( row, cell, value) {
            if(value > 0){return '<span class="up">'+value+'</span>'; }
            else if(value < 0){return '<span class="dn">'+value+'</span>'; }
            else{return '<span class="gr">'+value+'</span>';}}},
        {id: "bio", name: "BTC I/O", field: "b", width:90, sortable:true,formatter: function ( row, cell, value) {
            if(value > 0){return '<span class="up">'+value+'</span>'; }
            else if(value < 0){return '<span class="dn">'+value+'</span>'; }
            else{return '<span class="gr">'+value+'</span>';}}},
        {id: "fee", name: "FEE", field: "fee", width:90, sortable:true,formatter: function ( row, cell, value) {
        if(value > 0){return '<span class="up">'+value+'</span>'; }
        else if(value < 0){return '<span class="dn">'+value+'</span>'; }
        else{return '<span class="gr">'+value+'</span>';}}}
    ];
    var toptions = {
        enableCellNavigation: true,
        enableColumnReorder: false,
        enableAsyncPostRender: true
    };
    var vgrid = new Slick.Grid("#acc_his_grid", v_gl, columns, toptions);
    var openbal = 'Opening balence:' + v_gl['openbal']['balance_dt'] +v_gl['openbal']['bal_pl'] +v_gl['openbal']['bal_btc'] +v_gl['openbal']['bal_fee'] ;
    $('#acc_his_grid').prepend(openbal);
}

$(function(){
    activepage(2);
    //showtab(0);
    getiploc();
    get_gl();
    $(".edit_cont_form input[type='button']").click(function(){
        $(this).parent(".edit_cont_form").attr({action: this.name});
        $(this).parent(".edit_cont_form").submit();
    });


});
