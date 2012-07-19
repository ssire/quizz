/* Initial version by Oppidoc SARL, <contact@oppidoc.fr>
 *
 * author      : Stéphane Sire
 * contact     : s.sire@oppidoc.fr
 *
 * Script that runs the Quizz gadget
 *
 * Prerequisites: jQuery + AXEL (https://github.com/ssire/axel)
 */
 
(function (GLOBAL) {

  // function _init () {
  //   $("input").each(
  //     function (index, elt) {
  //       elt.disabled = false;
  //       elt.checked = false;
  //     }
  //     );
  //   $('#ui-prev').hide();
  // }

  function _reset() {
    $('#ui-next > button').text('Play');
    $('body').removeClass('correction');
    $("input").each(
      function (index, elt) {
        var tmp = $(elt).closest('li');
        if (elt.checked) {
          if (! tmp.hasClass('x-Correct')) {
            $(elt).closest('.x-Item').removeClass('failed');
          }
          tmp.removeClass('checked');
        } else {
          if (tmp.hasClass('x-Correct')) {
            $(elt).closest('.x-Item').removeClass('failed');
          }
          tmp.removeClass('unchecked');
        }
        elt.disabled = false;
        elt.checked = false;
      }
      );
    $('#ui-next').show();
    $('#ui-prev').hide();
  };
  
  // Done before _showCorrection for browsers without animations
  // FIXME: take into account items with multiple right answers
  function _showScore() {
    var good = 0;
    $("input").each(
      function (index, elt) {
        var tmp = $(elt).closest('li');
        if (elt.checked) {
          if (tmp.hasClass('x-Correct')) {
            good += 1;
          }
        }
      }
      )
   $('#total').text($(".x-Choices").length);
   $('#good').text(good);
  };  

  // To be done after the last item animation
  function _showCorrection() {
    $('body').addClass('correction');
    $("input").each(
      function (index, elt) {
        var tmp = $(elt).closest('li');
        if (elt.checked) {
          if (tmp.hasClass('x-Correct')) {
          } else {
            $(elt).closest('.x-Item').addClass('failed');
          }
          tmp.addClass('checked');
        } else {
          if (tmp.hasClass('x-Correct')) {
            $(elt).closest('.x-Item').addClass('failed');
          }
          tmp.addClass('unchecked');
        }
        elt.disabled = true;
      }
      )
   $('#ui-prev').css('display','block')
  };

  function _nextItem() {
    var cur = $('.cur');
    var next = cur.next('.x-Item');
    if (cur.prev('.x-Item').length === 0) {
      $('#ui-next > button').text('Next question');
    }
    if (next.length > 0) {
      cur.removeClass('cur');
      cur.addClass('done');
      next.addClass('cur');
      if (next.next('.x-Item').length === 0) {
        $('#ui-next').hide();
        _showScore();
        setTimeout(_showCorrection, 1000); // wait animation end
      }
    }
  };

  function _prevItem() {
    var cur = $('.cur');
    var next = cur.prev('.x-Item');
    if (next.length > 0) {
       cur.removeClass('cur');
      next.removeClass('done');
      next.addClass('cur');
      if (! next.hasClass('failed')) {
       _prevItem();
      }
      if (next.prev('.x-Item').length === 0) {
        setTimeout(_reset, 1000);
      }
    }
  };
  
  GLOBAL.$quizz = {
      // init : _init,
      nextItem : _nextItem,
      prevItem : _prevItem
  };
  
  // onDOMReady
  // jQuery(function() { _init(); });
  
}(window));