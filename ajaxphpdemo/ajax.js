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
                xmlhttp.open("GET", "validate.php?type=" + q +"&" + q +"=" + str, true);
                xmlhttp.send();
            }
        }