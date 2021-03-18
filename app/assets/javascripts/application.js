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


// sp pc ボタンの変化
$(window).resize(function(){
  var screenWidth = $(window).width()
  var spWidth = 767
  if (screenWidth <= 767) {
    $('.sp-button').addClass('button').removeClass('white-button')
  }
});