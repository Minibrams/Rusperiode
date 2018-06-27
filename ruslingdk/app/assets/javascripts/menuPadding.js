function addPadding() {
  var dropdownItemCount = document.querySelectorAll('.dropdown-item').length;
  var toggleElement = document.getElementsByClassName("nav-link")[0]
  var divHeight = document.getElementsByClassName("nav-item")[0].clientHeight;



	if (toggleElement.getAttribute("aria-expanded") == "true") {
  	document.getElementsByClassName("color-base")[0].style.paddingBottom = 0 + "px";
  } else {
  	document.getElementsByClassName("color-base")[0].style.paddingBottom = (divHeight * dropdownItemCount) + "px";
  }
}
