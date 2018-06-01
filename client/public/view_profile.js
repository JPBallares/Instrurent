var fn = document.getElementById('edit_firstname');
fn.addEventListener('click', editFN);

function editFN() {
    fn.style.display = 'none';
    document.getElementById('first_name').style.display = 'none';
    document.getElementById('client_first_name').style.display = 'block';
}

var ln = document.getElementById('edit_lastname');
ln.addEventListener('click', editLN);

function editLN() {
    ln.style.display = 'none';
    document.getElementById('last_name').style.display = 'none';
    document.getElementById('client_last_name').style.display = 'block';
}

var email = document.getElementById('edit_emailaddress');
email.addEventListener('click', editEMAIL);

function editEMAIL() {
    email.style.display = 'none';
    document.getElementById('email').style.display = 'none';
    document.getElementById('client_email').style.display = 'block';
}

var address = document.getElementById('edit_address');
address.addEventListener('click', editADDRESS);

function editADDRESS() {
    address.style.display = 'none';
    document.getElementById('address').style.display = 'none';
    document.getElementById('client_address').style.display = 'block';
}

var cn = document.getElementById('edit_contactnumber');
cn.addEventListener('click', editCN);

function editCN() {
    cn.style.display = 'none';
    document.getElementById('number').style.display = 'none';
    document.getElementById('client_contact').style.display = 'block';
}

var pass = document.getElementById('edit_pass');
pass.addEventListener('click', editPASS);

function editPASS() {
    pass.style.display = 'none';
    document.getElementById('edit_passwordcon').style.display = 'block';
    document.getElementById('client_oldpass').style.display = 'block';
    document.getElementById('client_newpass').style.display = 'block';
    document.getElementById('client_renewpass').style.display = 'block';
}