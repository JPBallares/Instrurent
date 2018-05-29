var itemsFullList = document.getElementById('items_container').querySelectorAll('li');

var searhForm = document.getElementById('item_search').querySelector('input');

searhForm.addEventListener('clik', findItem);
var searchTxt = searhForm.value;



function findItem() {
    console.log(searchTxt);
    for (i = 0; i < itemsFullList.length; i++) {
        if (searchTxt.toLocaleLowerCase() === itemsFullList[i].attributes['data-con'].value) {
            itemsFullList[i].style.display = 'block';
        } else {
            itemsFullList[i].style.display = 'none';
        }
    }
}

