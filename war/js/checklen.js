// checklen.js
// limits how many checkboxes can be checked

function checkLen(checkbox) {
	var boxes = document.getElementsByTagName('input');
	var count = 0;
	for (var i = 0; i < boxes.length; i++) {
		if (boxes[i].name === "tags[]") {
			count += (boxes[i].checked) ? 1 : 0;
			if (count > 3) {
				checkbox.checked=false;
	         }
		}
	}
}
