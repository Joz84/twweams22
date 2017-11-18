var notice = document.querySelector("#twweams");
var popup = document.querySelector("#tutorial");
var close = document.querySelector("#close");

notice.addEventListener("click",function(){
  popup.style.display = "block";
});

close.addEventListener("click",function(){
  popup.style.display = "none";
});
