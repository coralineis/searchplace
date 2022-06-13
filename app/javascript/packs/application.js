// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import "jquery_ujs"
import "jquery-ui"
import "tag-it"


Rails.start()
Turbolinks.start()
ActiveStorage.start()


  $('#tab-contents .tab[id != "tab1"]').hide();

  $('#tab-menu a').on('click', function(event) {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });

// ページ更新でtag-it発火
$(document).ready(function() {
  $(".tag_form").tagit({  // 指定のセレクタ( 今回は、:tag_list の text_field )に、tag-itを反映
    tagLimit:10,         // タグの最大数
    singleField: true,   // タグの一意性
 // availableTags: ['ruby', 'rails', ..]  自動補完する一覧を設定できる(※ 配列ならok)。今回は、Ajax通信でDBの値を渡す(後述)。
  });
  let tag_count = 10 - $(".tagit-choice").length    // 登録済みのタグを数える
  $(".ui-widget-content.ui-autocomplete-input").attr(
    'placeholder','あと' + tag_count + '個登録できます');
})

// タグ入力で、placeholder を変更
$(document).on("keyup", '.tagit', function() {
  let tag_count = 10 - $(".tagit-choice").length    // ↑ と同じなので、まとめた方がいい。
  $(".ui-widget-content.ui-autocomplete-input").attr(
  'placeholder','あと' + tag_count + '個登録できます');
});

  // 参:placeholderの書き換え方法
    $(".input").attr('placeholder','書き換え後のテキスト');
  // 参:placeholderの削除方法
    $(".input").removeAttr('placeholder');