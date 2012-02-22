/**
 * Created by PyCharm.
 * User: xiejian
 * Date: 1/13/12
 * Time: 5:24 PM
 * To change this template use File | Settings | File Templates.
 */
$(function () {
    var triggers = $(".modalInput").overlay({
        // some mask tweaks suitable for modal dialogs
        mask: {
            color: '#dadbee',
            loadSpeed: 200,
            opacity: 0.8
        },
        effect: 'apple',
        closeOnClick: false
    });
});