var sp_images = [
	"<img class='sp-image' src='images/sp-top-image-1.jpeg'>",
	"<img class='sp-image' src='images/sp-top-image-2.jpeg'>",
	"<img class='sp-image' src='images/sp-top-image-3.jpeg'>"
]

var sp_image_index = Math.floor(Math.random()*3); 


function random_sp_image() {
	document.getElementById("sp-top-images").innerHTML = sp_images[sp_image_index];
}

window.onload = random_sp_image;