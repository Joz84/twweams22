var number = document.querySelector('#nbr-twweams');

var x = 0;

setInterval(function(){
  x += 0.441;
  number.innerHTML = Math.round(x);
},100)
