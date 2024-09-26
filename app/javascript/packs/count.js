// 警告文が気になるためimport〜を追記↓
import $ from 'jquery';

// 文字数がオーバー(40文字以上)すると表示が赤くなる

$(document).on('turbolinks:load', function() {
  var count = $(".js-text").val().length;
  var now_count = 40 - count;

  if (count > 40) {
    $(".js-text-count").css("color","red");
  }
  
  $(".js-text-count").text("残り" + now_count + "文字");

  $(".js-text").on("keyup", function() {
    var count = $(this).val().length;
    var now_count = 40 - count;

    if (count > 40) {
      $(".js-text-count").css("color","red");
    } else {
      $(".js-text-count").css("color","black");
    }
    $(".js-text-count").text("残り" + now_count + "文字");
  });
});