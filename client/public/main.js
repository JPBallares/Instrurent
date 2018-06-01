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

var itemsContainerUL = itemsContainer.querySelector('ul');

var az = document.getElementById('AZBttn');
az.addEventListener('click', sortAZ);

var az = document.getElementById('ZABttn');
az.addEventListener('click', sortZA);

function sortAZ() {
    var switching = true;
    var temp, shouldSwitch;

    while (switching) {
        switching = false;
        temp = itemsContainerUL.getElementsByTagName('li');
        
        for (i = 0; i < (temp.length - 1); i++) {

            shouldSwitch = false;
            
            if (temp[i].innerHTML.toLowerCase() > temp[i + 1].innerHTML.toLowerCase()) {
             
              shouldSwitch = true;
              break;
            }
        }

          if (shouldSwitch) {
            temp[i].parentNode.insertBefore(temp[i + 1], temp[i]);
            switching = true;
          }
    }
}

function sortZA() {
    var switching = true;
    var temp, shouldSwitch;

    while (switching) {
        switching = false;
        temp = itemsContainerUL.getElementsByTagName('li');
        
        for (i = 0; i < (temp.length - 1); i++) {

            shouldSwitch = false;
            
            if (temp[i].innerHTML.toLowerCase() < temp[i + 1].innerHTML.toLowerCase()) {
             
              shouldSwitch = true;
              break;
            }
        }

          if (shouldSwitch) {
            temp[i].parentNode.insertBefore(temp[i + 1], temp[i]);
            switching = true;
          }
    }
}