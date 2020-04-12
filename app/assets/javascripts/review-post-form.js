//今現在このファイルに記載のjavascriptは機能していない。ビューファイル記載のjavascriptで動いている
var $target = document.querySelector('.target')
var $button = document.querySelector('.button')
$button.addEventListener('click', function() {
  $target.classList.toggle('is-hidden')
})