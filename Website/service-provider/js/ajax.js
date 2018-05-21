function showHint(q, str, elementId) {
    if (str.length == 0) {
        document.getElementById(elementId).innerHTML = "";
        return;
    } else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById(elementId).innerHTML = this.responseText;
            }
        };
        xmlhttp.open("GET", "php/validate.php?type=" + q + "&" + q + "=" + str, true);
        xmlhttp.send();
    }
}

function confirmPass(q, str, passElementId, elementId){
    var pass = document.getElementById(passElementId).value;
    if (str.length == 0) {
        document.getElementById(elementId).innerHTML = "";
        return;
    } else {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById(elementId).innerHTML = this.responseText;
            }
        };
        console.log("php/validate.php?type=" + q + "&" + q + "=" + str + "&password=" + pass);
        xmlhttp.open("GET", "php/validate.php?type=" + q + "&" + q + "=" + str + "&password=" + pass, true);
        xmlhttp.send();
    }
}
z
document.getElementById("submitClient").disabled = true;
document.getElementById("submitProvider").disabled = true;