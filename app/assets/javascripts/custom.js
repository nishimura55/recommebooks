window.onload = function() {
    var $target = document.querySelector('.target')
    var $button = document.querySelector('.button')
    if($target){
      $button.addEventListener('click', function() {
        $target.classList.toggle('is-hidden')
      })
    }
    var $target1 = document.querySelector('.target1')
    var $whatrep1 = document.querySelector('.whatrep1')
    if($target1){
      $whatrep1.addEventListener('click', function() {
        $target1.classList.toggle('is-hidden')
      })
    }
    var $target2 = document.querySelector('.target2')
    var $whatrep2 = document.querySelector('.whatrep2')
    if($target2){
      $whatrep2.addEventListener('click', function() {
        $target2.classList.toggle('is-hidden')
      })
    }
}
