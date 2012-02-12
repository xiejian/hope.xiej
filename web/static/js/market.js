/**
 * Created by PyCharm.
 * User: xiejian
 * Date: 1/13/12
 * Time: 5:24 PM
 * To change this template use File | Settings | File Templates.
 */

function parseTwitterDate(tdate) {
    var system_date = new Date(Date.parse(tdate));
    var user_date = new Date();
    if (K.ie) {
        system_date = Date.parse(tdate.replace(/( \+)/, ' UTC$1'))
    }
    var diff = Math.floor((user_date - system_date) / 1000);
    if (diff <= 1) {return "just now";}
    if (diff < 20) {return diff + " seconds ago";}
    if (diff < 40) {return "half a minute ago";}
    if (diff < 60) {return "less than a minute ago";}
    if (diff <= 90) {return "one minute ago";}
    if (diff <= 3540) {return Math.round(diff / 60) + " minutes ago";}
    if (diff <= 5400) {return "1 hour ago";}
    if (diff <= 86400) {return Math.round(diff / 3600) + " hours ago";}
    if (diff <= 129600) {return "1 day ago";}
    if (diff < 604800) {return Math.round(diff / 86400) + " days ago";}
    if (diff <= 777600) {return "1 week ago";}
    return "on " + system_date;
}

// from http://widgets.twimg.com/j/1/widget.js
var K = function () {
    var a = navigator.userAgent;
    return {
        ie: a.match(/MSIE\s([^;]*)/)
    }
}();

$(function () {
    activepage(0);

    $.getJSON("http://search.twitter.com/search.json?callback=?&q=BTCFE&include_entities=true",
        function(data){
            for (i=0; i<data.results.length; i++){
                $("#tweets").append("" +
                    "<a href='https://twitter.com/"+data.results[i].from_user +"'><img src='"+ data.results[i].profile_image_url+"'/></a>" +
                    "<span class='twt_text'>" + data.results[i].text + " </span><span class='twt_time'>" +
                    parseTwitterDate(data.results[i].created_at) +"</span>" +
                '<span class="twt_action"> <a href="https://twitter.com/intent/tweet?in_reply_to='+data.results[i].in_reply_to_status_id_str+
                    '">Reply</a>'+
                ' <a href="https://twitter.com/intent/retweet?tweet_id='+data.results[i].id_str+'">Retweet</a>'+
                ' <a href="https://twitter.com/intent/favorite?tweet_id='+data.results[i].id_str+'">Favorite</a></span>'+
                "<br />");
            }
        });


});

