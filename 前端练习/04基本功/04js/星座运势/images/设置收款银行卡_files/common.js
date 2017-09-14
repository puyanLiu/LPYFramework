var rootUrl = "http://192.168.1.123:8080/api/app/v3/";

function getId(id) {
    return document.getElementById(id);
}

function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}

function removeSelection() {
    window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty();
}