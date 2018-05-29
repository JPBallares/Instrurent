var bttn = document.getElementById('searchBttn');
bttn.addEventListener('click', searchItem);

var itemsContainer = document.getElementById('items_container');
var items = itemsContainer.querySelectorAll('li');


function searchItem() {
    document.getElementById('itemA').style.display = 'none';
    document.getElementById('itemB').style.display = 'none';

    var txt = document.getElementById('searchTxt').value;
    var flag = 0;
    for (i = 0; i < items.length; i++) {
        var currItem = items[i].attributes['data-con'].value + "";
       
        if (currItem.toLocaleLowerCase().search(txt.toLocaleLowerCase()) == -1) {
            items[i].style.display = 'none';
        } else {
            items[i].style.display = 'block';
            flag++;
        }
    }

    if (flag == 0) {
        document.getElementById('itemB').style.display = 'block';
    } else {
        document.getElementById('itemA').style.display = 'block';
    }
}