// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require_tree .
/*global $*/
/*global i*/

$(function() {
    $('.slider-favorite').slick({
      slidesToShow: 3,
      slidesToScroll: 3,
      dots: true,
      autoplay: true,
      autoplaySpeed: 5000,

      responsive: [{
    		breakpoint: 767,
    		settings: {
		    	arrows: false,
    		}
    	}]
    });
});

$(function() {
    $('.slider-new').slick({
      slidesToShow: 5,
      slidesToScroll: 5,
      dots: true,
      autoplay: true,
      autoplaySpeed: 2000,

      responsive: [{
    		breakpoint: 767,
    		settings: {
    			slidesToShow: 4,
		    	slidesToScroll: 4,
		    	arrows: false,
    		}
    	}]
    });
});

$(function() {
    $('.favorite-hashtag-lists').slick({
      slidesToShow: 5,
      slidesToScroll: 5,
      dots: true,
      autoplay: true,
      autoplaySpeed: 3000,

      responsive: [{
    		breakpoint: 767,
    		settings: {
    			slidesToShow: 2,
		    	slidesToScroll: 2,
		    	arrows: false,
    		}
    	}]
    });
});


// sp pc ボタン チャットボタンの変化
$(function() {
  if (window.matchMedia( "(max-width: 768px)" ).matches) {
    $('.sp-button').addClass('button').removeClass('white-button');
    $('.chat-button').html("<i class='fas fa-comments text-white h5'></i>");
  }
});

// flash-messageの削除
$(function() {
  setTimeout("$('#flash-message').fadeOut('slow')", 1500);
});

// preview

$(function() {
  $('#post_image_image').on('change', function(e) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('#preview').attr('src', e.target.result);
    };
    return reader.readAsDataURL(e.target.files[0]);
  });
});

$(function() {
  $('#request_request_images_complete_images').on('change', function(e){
    let reader = new Array(99);
    
    for(let i = 0; i < 99; i++) {
      $(`#request_preview_${i}`).attr('src', "");
    }
    
    for(let i = 0; i < e.target.files.length; i++) {
      reader[i] = new FileReader();
      reader[i].onload = finisher(i,e); 
      reader[i].readAsDataURL(e.target.files[i]);

      function finisher(i,e){
        return function(e){
          $(`#request_preview_${i}`).attr('src', e.target.result);
        };
      }
    }
  });
});