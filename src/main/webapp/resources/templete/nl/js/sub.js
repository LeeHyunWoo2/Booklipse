$(function(){
	$('.gotab').click(function() {
		$('.newsp-t').click();
	});
  //미디어 게시판 최근게시물
  var page=0;
  var total_page0 = $(".recent_media_wrap .recent_board_list>li").length/2;
  var total_page = Math.ceil(total_page0);
  $(".recent_board_control .page_total").text(total_page);
  function next_list(){
    page++;
    if(page == total_page){
      page = total_page - 1;
      return false;
    }
    $(".recent_media_wrap .recent_board_list").stop().animate({left:-100 * page + "%"},500);
    $(".recent_board_control .page_now").text(page + 1);
  };
  function prev_list(){
    page--;
    if(page == -1){
      page = 0;
      return false;
    }
    $(".recent_media_wrap .recent_board_list").stop().animate({left:-100 * page + "%"},500);
    $(".recent_board_control .page_now").text(page + 1);
  };
  $(".btn_recent").click(function(){
    if($(this).hasClass("btn_prev") === true){
      prev_list();
    }else{
      next_list();
    }
  });

  //동영상뉴스 자막
  $(".btn_subtitle").click(function(){
    $(this).toggleClass("is_open");
    if($(this).hasClass("is_open")) {
    	$(this).text("자막 접기");
    } else {
    	$(this).text("자막 펼치기");
    }
    $(".subtitle_content").toggleClass("is_open");
  })
     //상세검색
    $(".btn_detail_search2").click(function(){
      $(this).toggleClass("is_open");
      $(".detail_search_wrap2").toggleClass("is_open");
    });
     //제한검색
     $(".btn_limit_search").click(function(){
      $(this).toggleClass("is_open");
      $(".limit-search-wrap").toggleClass("is_open");
    });
    //초성검색
    $(".btn_all_view").click(function(){
      $(this).toggleClass("is_open")
      $(".search_type2_all").toggleClass("is_open");
      $(".paper_slider_top").toggleClass("is_open")
    });
    $(".search_type2_all .search_close").click(function(){
      $(this).parents().removeClass("is_open");
    });
    $('.m_btn_all_view').click(function(){
      if($(this).parents().hasClass('is_open')){
        $(this).text('전체 목록 보기');
        $(this).parents().removeClass('is_open');
        $('.search_type2_all').removeClass('is_open');
      }else{
        $(this).text('전체 목록 접기');
        $(this).parents().addClass('is_open');
        $('.search_type2_all').addClass('is_open');
      }
    })
    //드랍메뉴
    $(".btn_loddown").click(function(){
    $(this).toggleClass("is_open");
    $(".pop_dropmenu").toggleClass("is_open");
  });
  //검색방식선택
  $('.day_search_type .input_radio_wrap label').click(function(){
    var isNotMobile = commons.getDeviceType() !== DEVICE_TYPE_MOBILE;
    if($(this).hasClass('keyword_radio')){
      $('.day_search_type .search_case2_wrap').hide();
      $('.day_search_type .search_case1_wrap').show();
      $('.day_search_type .check_view_cal').show();
      $('.day_search_type+.calendar_wrap').show();
      if(isNotMobile){
        $('.day_search_type .search_case1_wrap').attr('style', 'display:inline-block');
      }else{
        $('.day_search_type .search_case1_wrap').attr('style', 'display:block');
      }

    }else if($(this).hasClass('date_radio')){
      $('.day_search_type .search_case2_wrap').show();
      if(isNotMobile){
        $('.day_search_type .search_case2_wrap').attr('style', 'display:inline-block');
      }else{
        $('.day_search_type .search_case2_wrap').attr('style', 'display:block');
      }
      $('.day_search_type .check_view_cal').hide();
      $('.day_search_type+.calendar_wrap').hide();
      $('.day_search_type .search_case1_wrap').hide();
    }
  })
  /*
  $('.chousn_search_wrap .input_radio_wrap label').click(function(){
    if($(this).hasClass('keyword_radio')){
      $('.chousn_search_wrap .search_case2_wrap').hide();
      $('.chousn_search_wrap .search_case1_wrap').show();
      $('.chousn_search_wrap .search_case1_wrap').attr('style', 'display:inline-block');
      $('.calendar_wrap').show();
    }else if($(this).hasClass('date_radio')){
      $('.chousn_search_wrap .search_case2_wrap').show();
      $('.chousn_search_wrap .search_case2_wrap').attr('style', 'display:inline-block');
      $('.chousn_search_wrap .search_case1_wrap').hide();
      $('.calendar_wrap').hide();
    }
  })
*/
  //달력보기
  $('input[type="checkbox"]').click(function(){
    var inputValue = $(this).attr("value");
    $("." + inputValue).toggle();
  });
  //slider
  $('.paper_slider').bxSlider({
    slideWidth: 100,
    minSlides: 1,
    pager:false,
    maxSlides: 7,
    controls:true,
    slideMargin: 20,
    nextText: '다음 슬라이드',
    prevText: '이전 슬라이드'
  });

//연도,월검색
    var slider = $('.year_vertical_slide').bxSlider({
      mode: 'vertical',
      slideWidth: 110,
      minSlides: 5,
      moveSlides: 1,
      centerMode: true,
      pager:false,
      slideMargin: 15,
      nextText: '다음 슬라이드',
      prevText: '이전 슬라이드',
      onSliderLoad: function () {
          $('.year_vertical_slide>div:not(.bx-clone)').eq(2).addClass('active-slide');
      },
      onSlideAfter: function ($slideElement, oldIndex, newIndex) {
        $('.slide').removeClass('active-slide');
        $($slideElement).next().addClass('active-slide');
      }
  });
  var slider = $('.month_vertical_slide').bxSlider({
    mode: 'vertical',
    slideWidth: 110,
    minSlides: 7,
    moveSlides: 1,
    centerMode: true,
    pager:false,
    slideMargin: 13,
    nextText: '다음 슬라이드',
    prevText: '이전 슬라이드',
    onSliderLoad: function () {
        $('.month_vertical_slide>div:not(.bx-clone)').eq(2).addClass('active-slide');
    },
    onSlideAfter: function ($slideElement, oldIndex, newIndex) {
      $('.slide').removeClass('active-slide');
      $($slideElement).next().addClass('active-slide');
    }
});
  //faq 슬라이드 토글 & 타이틀 변경
  $(".question_title").click(function(){
    if($(this).parents(".faq_item").hasClass("is_open") == true){
      $(this).parents(".faq_item").removeClass("is_open").find(".faq_answer").slideUp();
      $(this).attr('title','답변 열기');
      return false;
    }else if($(this).parents(".faq_item").hasClass("is_open") == false){
      $(".faq_answer").slideUp();
      $(".faq_item").removeClass("is_open");
      $(this).parents(".faq_item").addClass("is_open").find(".faq_answer").slideDown();
      $(".question_title").attr('title','답변 열기');
      $(this).attr('title','답변 접기');
      return false;
    }
  })

  //개인정보 처리방침 슬라이드 토글 & 타이틀 변경
  $(".privacy_title").click(function(){
    if($(this).parents(".privacy_item").hasClass("is_open") == true){
      $(this).parents(".privacy_item").removeClass("is_open").find(".privacy_cont").slideUp();
      $(this).attr('title','상세 보기');
      return false;
    }else if($(this).parents(".privacy_item").hasClass("is_open") == false){
      $(".privacy_cont").slideUp();
      $(".privacy_item").removeClass("is_open");
      $(this).parents(".privacy_item").addClass("is_open").find(".privacy_cont").slideDown();
      $(this).attr('title','상세 접기');
      return false;
    }
  })
  //사회봉사 주의사항
  $(".library_welfare_notice").addClass("is_opened");
  $(".library_welfare_notice .step_inside_title").click(function(){
    if($(this).parents(".library_welfare_notice").hasClass("is_opened") == true){
      $(this).parents(".library_welfare_notice").removeClass("is_opened").children(".welfare_notice_wrap").slideUp();
      return false;
    }else if($(this).parents(".library_welfare_notice").hasClass("is_opened") == false){
      $(this).parents(".library_welfare_notice").addClass("is_opened").children(".welfare_notice_wrap").slideDown();
      return false;
    }
  })

  // 사회봉사 신청자정보 상세
  $('.my_welfare_info_wrap').on('click', '.btn_my_welfare_info', function (e) {
      var $target = $(e.currentTarget).parents('.my_welfare_info_wrap');
      var isCollapsed = $target.hasClass('is_collapsed');

      if(isCollapsed) {
        $target.removeClass('is_collapsed');
        $target.find('.my_welfare_info').stop().slideDown(function () {
          $(this).removeAttr('style');
        });
      } else {
        $target.addClass('is_collapsed');
        $target.find('.my_welfare_info').stop().slideUp(function () {
          $(this).attr('style', 'display:none');
        });
      }
  });

  // 사서추천도서 상세보기
  $('.subtitle_inner').on('click', '.btn_book_info', function (e) {
    var $target = $(e.currentTarget).parents('.subtitle_inner');
    var isCollapsed = $target.hasClass('is_collapsed');

    if(isCollapsed) {
      $target.removeClass('is_collapsed');
      $target.find('.subtitle_content').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
	$(this)[0].title = "접기";
      $target.find('.btn_book_info').removeClass('btn_book_info1');
    } else {
      $target.addClass('is_collapsed');
      $target.find('.subtitle_content').stop().slideUp(function () {
        //$(this).attr('style', 'display:none');
      });
	$(this)[0].title = "펼치기";
console.log(3213121323);
      $target.find('.btn_book_info').addClass('btn_book_info1');
    }
  });

  //사서추천도서 소개 접고/펼치기
  $('.recommend_info_wrap').addClass('is_collapsed');
  $('.recommend_info_wrap .btn_recommend').text('내용열기');
  $('.recommend_info_wrap').find('.recommend_area').hide();
  $('.recommend_info_wrap').on('click', '.btn_recommend', function (e) {
    var $target = $(e.currentTarget).parents('.recommend_info_wrap');
    var $btnText = $('.btn_recommend').text('');
    var isCollapsed = $target.hasClass('is_collapsed');
    if(isCollapsed) {
      $target.removeClass('is_collapsed');
      $btnText.append('내용닫기');
      $target.find('.recommend_area').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
    } else {
      $target.addClass('is_collapsed');
      $btnText.append('내용열기');
      $target.find('.recommend_area').stop().slideUp(function () {
        //$(this).attr('style', 'display:none');
      });
    }
  });

  //신착자료 소장정보/상세정보 접고/펼치기
  $('.ucsrch3_wrap .btn_collect_item').click(function(){
    $('.ucsrch3_item').removeClass('is_opened');
    $(this).parents('.ucsrch3_item').siblings('.ucsrch3_item').find('.collect_item_box').slideUp();
    if($(this).hasClass('btn_collect_info')){
      if($(this).parents('.info_inner').find('.collect_info_box').css('display') == 'block'){
        $(this).parents('.ucsrch3_item').removeClass('is_opened');
        $(this).parents('.info_inner').find('.collect_info_box').slideUp();
      }else{
        $('.detail_info_box').hide();
        $(this).parents('.ucsrch3_item').addClass('is_opened');
        $(this).parents('.info_inner').find('.collect_info_box').slideDown();
      }
    }else if($(this).hasClass('btn_detail_info')){
      if($(this).parents('.info_inner').find('.detail_info_box').css('display') == 'block'){
        $(this).parents('.ucsrch3_item').removeClass('is_opened');
        $(this).parents('.info_inner').find('.detail_info_box').slideUp();
      }else{
        $('.collect_info_box').hide();
        $(this).parents('.ucsrch3_item').addClass('is_opened');
        $(this).parents('.info_inner').find('.detail_info_box').slideDown();
      }
    }
  });
  $('.ucsrch4_wrap .btn_collect_item').click(function(){
    $('.ucsrch4_item').removeClass('is_opened');
    $(this).parents('.ucsrch4_item').siblings('.ucsrch4_item').find('.collect_item_box').slideUp();
    if($(this).hasClass('btn_abstract_info')){
      if($(this).parents('.info_inner').find('.abstract_info_box').css('display') == 'block'){
        $(this).parents('.ucsrch4_item').removeClass('is_opened');
        $(this).parents('.info_inner').find('.abstract_info_box').slideUp();
      }else{
        $('.detail_info_box').hide();
        $(this).parents('.ucsrch4_item').addClass('is_opened');
        $(this).parents('.info_inner').find('.abstract_info_box').slideDown();
      }
    }else if($(this).hasClass('btn_detail_info')){
      if($(this).parents('.info_inner').find('.detail_info_box').css('display') == 'block'){
        $(this).parents('.ucsrch4_item').removeClass('is_opened');
        $(this).parents('.info_inner').find('.detail_info_box').slideUp();
      }else{
        $('.abstract_info_box').hide();
        $(this).parents('.ucsrch4_item').addClass('is_opened');
        $(this).parents('.info_inner').find('.detail_info_box').slideDown();
      }
    }
  });
  $('.collect_item_box .btn_close').click(function(){
    $(this).parents('.ucsrch3_item').removeClass('is_opened');
    $(this).parents('.collect_item_box').slideUp();
  })

  // 우편복사 신청 상세
  $('.copy_book').on('click', '.btn_book_detail', function (e) {
    var $target = $(e.currentTarget).parents('.copy_book');
    var isCollapsed = $target.hasClass('is_collapsed');

    if(isCollapsed) {
      $target.removeClass('is_collapsed');
      $target.find('.book_detail').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
    } else {
      $target.addClass('is_collapsed');
      $target.find('.book_detail').stop().slideUp(function () {
        $(this).attr('style', 'display:none');
      });
    }
  });

  //자료찾기 여러판본
  $('.paper_back_item').find('.other_editions').attr('style', 'display:none');
  $('.paper_back_item').on('click', '.btn_other_edition', function (e) {
    var $target = $(e.currentTarget).parents('.paper_back_item');
    var isOpend = $target.hasClass('is_opend');
    if(isOpend) {
      $target.removeClass('is_opend');
      $target.find('.other_editions').stop().slideUp(function () {
        $(this).attr('style', 'display:none');
      });
    } else {
      $target.addClass('is_opend');
      $target.find('.other_editions').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
    }
  });


  //자료찾기 상세/판권지/표지보기
  $('.ucsrch7_detail_wrap .btn_copyright').click(function(){
    if($(this).hasClass('btn_cover')){
      $(this).removeClass('btn_cover').text('판권지보기');
      $(this).parents('.board_book_contents').find('.thumb').fadeIn();
      $(this).parents('.board_book_contents').find('.thumb_copyright').hide();
    }else{
      $(this).addClass('btn_cover').text('표지보기');
      $(this).parents('.board_book_contents').find('.thumb_copyright').fadeIn();
      $(this).parents('.board_book_contents').find('.thumb').hide();
    }
  })

  //근대문학연표
  $(".year_range_bar").asRange({
	onChange : function(value){
		console.log( value );
		$("#sYear").val(value[0]);
		$("#eYear").val(value[1]);
	},
	range: true,
    limit: false,
    min: 1852,
    max: 2010,
    step:  1
  });

  //카테고리 디자인 a
  $('.category_form_wrap .label').click(function(){
    $(this).parents('.category_form_wrap').find('.category_form_link').slideToggle();
  })

  //brm학술지 분류 부처목록
  $('.select_department .label').click(function(){
    $(this).parents('.select_department').find('.department_list').slideToggle();
  })

  //조건별 학술지 자모순 목록
  if($(window).width() < 768){
    $('.select_character .label').click(function(){
      $(this).parents('.select_character').find('.character_list').slideToggle();
    })
  }else{
    $('.select_character .character_list').show();
  }
  $(window).resize(function() {
    var width = $(document).width();
    if (width > 767) {
      $('.select_character .character_list').show();
    }else{
      $('.select_character .character_list').hide();
    }
});
  //구한국관보 검색영역
  $('.old_search_wrap .input_radio_wrap label').click(function(){
    if($(this).hasClass('keyword_radio')){
      $('.old_search_wrap .date_search').hide();
      $('.old_search_wrap .keyword_search').show();
    }else if($(this).hasClass('date_radio')){
      $('.old_search_wrap .date_search').show();
      $('.old_search_wrap .keyword_search').hide();
    }
  })

  //조선총독부관보 인명별검색영역
  $('.personal_search_wrap .input_radio_wrap label').click(function(){
    if($(this).hasClass('alpha_radio')){
      $('.personal_search_wrap .korean_list,.personal_search_wrap .korean_search').hide();
      $('.personal_search_wrap .alpha_list,.personal_search_wrap .alpha_search').show();
    }else if($(this).hasClass('korean_radio')){
      $('.personal_search_wrap .korean_list,.personal_search_wrap .korean_search').show();
      $('.personal_search_wrap .alpha_list,.personal_search_wrap .alpha_search').hide();
    }
  })

  //주제별목록 호버
  $('.ucsrch12_wrap .ucsrch12_item a').on('mouseover focusin',function(){
    $(this).parents('.ucsrch12_item').addClass('is_active');
  });
  $('.ucsrch12_wrap .ucsrch12_item a').on('mouseout focusout',function(){
    $(this).parents('.ucsrch12_item').removeClass('is_active');
  });

  //문서군 검색 2계층목록
  $(".ucsrch13_wrap .title_inner").click(function(){
    if($(this).parents(".ucsrch13_1depth").hasClass("is_opened") == true){
      $(this).parents(".ucsrch13_1depth").removeClass("is_opened").next(".ucsrch13_2depth").slideUp();
      $(this).parents(".ucsrch13_1depth").find('.variable').text('보기');
      return false;
    }else if($(this).parents(".ucsrch13_1depth").hasClass("is_opened") == false){
      $(".ucsrch13_2depth").slideUp();
      $(".ucsrch13_1depth").removeClass("is_opened").find('.variable').text('보기');
      $(this).parents(".ucsrch13_1depth").addClass("is_opened").next(".ucsrch13_2depth").slideDown();
      $(this).parents(".ucsrch13_1depth").find('.variable').text('닫기');
      return false;
    }
  })

  //내서재 질문내역
  $(".ucmy7_detail_cont .btn_first_question").parents(".ucmy7_detail_cont").addClass("is_opened");
  $(".ucmy7_detail_cont .btn_first_question").click(function(){
    if($(this).parents(".ucmy7_detail_cont").hasClass("is_opened") == true){
      $(this).parents(".ucmy7_detail_cont").removeClass("is_opened").children(".ucmy7_question, .ucmy7_answer").slideUp();
      return false;
    }else if($(this).parents(".ucmy7_detail_cont").hasClass("is_opened") == false){
      $(this).parents(".ucmy7_detail_cont").addClass("is_opened").children(".ucmy7_question, .ucmy7_answer").slideDown();
      return false;
    }
  })

  //연표
   var slider_year = $('.literature__list').bxSlider({
      //mode: 'vertical',
	  slideWidth: 80,
	  minSlides: 3,
	  maxSlides: 10,
	  arrows: true,
	  moveSlides: 1,
	  slideMargin: 10,
	  arrows: true,
     // centerMode: true,
      pager:false,
      slideMargin: 15,
      //startSlide: 69,
      nextText: '다음 근대문학연표',
      prevText: '이전 근대문학연표',
      onSliderLoad: function () {
    	  $(".bx-clone").find("a").prop("tabIndex","-1");
          $('.literature__item:not(.bx-clone)').eq(2).addClass('active-slide');
          //slider.goToSlide(69);
      },
      onSlideAfter: function ($slideElement, oldIndex, newIndex) {
        $('.literature__item').removeClass('active-slide');
        $($slideElement).next().addClass('active-slide');

        $(".literature__list").children("li").each(function(){
			if($(this).attr("aria-hidden") == "false"){
				$(this).find("a").attr("tabIndex","0");
			} else{
				$(this).find("a").attr("tabIndex","-1");
			}
		});
      }
  });

  /*$('.literature__list a').focusin(function () {
	  slider_year.stopAuto();
	});*/

 // slider_year.goToSlide(69);
  //내서재 자료열람
  $(".mo_ucmy8_list .ucmy8_item .title").click(function(){
    if($(this).parents(".ucmy8_item").hasClass("is_opened") == true){
      $(this).parents(".ucmy8_item").removeClass("is_opened").children(".inner_info").slideUp();
      return false;
    }else if($(this).parents(".ucmy8_item").hasClass("is_opened") == false){
      $(".ucmy8_item").removeClass("is_opened").children(".inner_info").slideUp();
      $(this).parents(".ucmy8_item").addClass("is_opened").children(".inner_info").slideDown();
      return false;
    }
  });

  	// 바구니 상세
	$('.my11_wrap').on('click', '.btn_detail_view', function (e) {
		var $target = $(e.currentTarget).parents('.my11_detail_wrap');
		var is_opened = $target.hasClass('is_detail_opened');

		if(is_opened) {
			$(this).text('상세보기').css({"background-image":"url(/resource/templete/nl/common/img/common/bottom-arrow.png)"});
	  	$target.removeClass('is_detail_opened');

		} else {
      $(this).text('상세닫기').css({"background-image":"url(/resource/templete/nl/common/img/common/top-arrow.png)"});
	  	$target.addClass('is_detail_opened');
		}
	});
	//바구니 상세 전체 열기/닫기
	$('.cart_wrap').on('click','.all_detail_view', function () {
		var $container = $(this).parents('.cart_wrap');
		var $isDetailOpened = $container.find('.my11_detail_wrap').hasClass("is_detail_opened");
		if($isDetailOpened === true ){
			$(this).text('전체상세펼침').css({"background-image":"url(/resource/templete/nl/common/img/common/bottom-arrow.png)"});
			$container.find('.my11_detail_wrap').removeClass("is_detail_opened");
			return false;
		}else{
			$(this).text('전체상세닫기').css({"background-image":"url(/resource/templete/nl/common/img/common/top-arrow.png)"});
			$container.find('.my11_detail_wrap').addClass("is_detail_opened");
			return false;
		}
	});

  // 도서관 업무 > 도서관 협력 활동 > 국제 협력
  // 스크롤 테이블
  $(".open_all").next(".activities_status_table_1").addClass("active");
  $(".open_all").click(function(){
    if($(this).next(".activities_status_table_1").hasClass("active") == true){
      $(this).next(".activities_status_table_1").removeClass("active");
      return false;
    }else if($(this).next(".activities_status_table_1").hasClass("active") == false){
      $(this).next(".activities_status_table_1").addClass("active");
      return false;
    }
  })

  //테이블 숨겼다 나타내기
  $(".open_table").click(function(){
    if($(this).parents(".txt").hasClass("active") == true){
      $(this).parents(".txt").removeClass("active").children(".activities_status_table_2").slideUp();
      return false;
    }else if($(this).parents(".txt").hasClass("active") == false){
      $(this).parents(".txt").addClass("active").children(".activities_status_table_2").slideDown();
      return false;
    }
  })

  // 우편복사 신청 상세
  $('.post_copy_cont').on('click', '.btn_post_copy_info', function (e) {
    var $target = $(e.currentTarget).parents('.post_copy_cont');
    var isCollapsed = $target.hasClass('is_collapsed');

		if(isCollapsed) {
		$target.removeClass('is_collapsed').find('button').attr('title','내용 접기');
		$target.find('.post_copy_wrap').stop().slideDown(function () {
      $(this).removeAttr('style');
		});
		} else {
		$target.addClass('is_collapsed').find('button').attr('title','내용 펼치기');
		$target.find('.post_copy_wrap').stop().slideUp(function () {
			$(this).attr('style', 'display:none');
		});
		}
	});

  //정보활용능력교육 신청서 작성
  $(".ucreq7_detail_wrap .application").hide();
  $(".ucreq7_detail_wrap .btn_apply").click(function(){
      $(".ucreq7_detail_wrap .application").slideDown().find("input, select, button, a").first().focus();
  })

  //강연/세미나 신청서 작성 및 확인 폼
  $(".ucreq3_detail_wrap .application,.ucreq3_detail_wrap .my_application").hide();
  $(".ucreq3_detail_wrap .btn_apply").click(function(){
      $(".ucreq3_detail_wrap .my_application").hide();
      $(".ucreq3_detail_wrap .application").slideDown().find("input, select, button, a").first().focus();
  })
  $(".ucreq3_detail_wrap .btn_my_apply").click(function(){
      $(".ucreq3_detail_wrap .application").hide();
      $(".ucreq3_detail_wrap .my_application").slideDown().find("input, select, button, a").first().focus();
  })

  // 전시 상세보기
  $('.ucapi26_detail_wrap .subtitle_inner').on('click', '.btn_collect_info', function (e) {
    var $target = $(e.currentTarget).parents('.subtitle_inner');
    var isCollapsed = $target.hasClass('is_collapsed');

    if(isCollapsed) {
      $target.removeClass('is_collapsed');
      $target.find('.subtitle_content').stop().slideDown(function () {
          $(this).removeAttr('style');
          $('.ucapi26_detail_wrap').find('.photo_slide_wrap').show(0,function(){
            photo_slider.reloadSlider();
            photo_slider.stopAuto();
          });
      });
    } else {
      $target.addClass('is_collapsed');
      $target.find('.subtitle_content').stop().slideUp(function () {
        $(this).attr('style', 'display:none');
      });
    }
  });

  $('.api26_detail_bx').hide()
	$('.ucapi26_detail_wrap').on('click', '.btn_detail_view', function (e) {
		var $target = $(e.currentTarget).parents('.api26_detail_wrap');
		var is_opened = $target.hasClass('is_opened');

		if(is_opened) {
		$target.removeClass('is_opened');
        $target.find('.api26_detail_bx').slideUp()

		} else {
		$target.addClass('is_opened');
        $target.find('.api26_detail_bx').slideDown()
		}
	});

  $('.ucapi26_detail_wrap .detail_info_box').find('.btn_wrap').hide();
  $('.ucapi26_detail_wrap .btn_detail').on('click', function (e) {
		var $target = $(e.currentTarget).parents('.topic_item');
		var isCollapsed = $target.hasClass('is_opened');
		if(isCollapsed) {
		  $target.removeClass('is_opened');
      $(e.currentTarget).children('span').text('설명보기');
          $target.find('.detail_info_box').find('.btn_wrap').hide();
		  $target.find('.detail_info_box').stop().slideUp(function () {
			$(this).removeAttr('style');
		  });
		} else {
		  $target.addClass('is_opened');
		  $(e.currentTarget).children('span').text('설명접기');
		  $target.find('.detail_info_box').stop().slideDown(function () {
            $(this).find('.btn_wrap').show();
          });
        }
    $('.ucapi26_detail_wrap .btn_close').click(function(){
      $(this).parents('.topic_item').removeClass('is_opened');
      $(e.currentTarget).children('span').text('설명보기');
      $(this).parents('.topic_item').find('.detail_info_box').find('.btn_wrap').hide();
      $(this).parents('.topic_item').find('.detail_info_box').stop().slideUp(function () {
        $(this).removeAttr('style');
      });
    })
  });


  //전시 레이어팝업
  //레이어팝업
  function lypop_open(){
    $(".ucapi26_detail_wrap .btn_layer").click(function(){
      var layer = $(this).attr("data-layer");
      $(".ucapi26_detail_wrap .layer_popup_wrap"+ "[data-layer='" + layer + "']").fadeIn().attr('tabindex','0').focus();
      // $("body").addClass("no_scroll");
      $('.ucapi26_detail_wrap .layer_popup .photo_slide_wrap').show();
    });
  }
  function lypop_close(){
    $(".ucapi26_detail_wrap .layer_popup_wrap .btn_close,.layer_popup_wrap .btn_full_close").click(function(){
      // $("body").removeClass("no_scroll");
      var focus_item = $(this).parents(".layer_popup_wrap").attr('data-layer');
      $(this).parents(".layer_popup_wrap").fadeOut();
      //$(".btn_layer"+ "[data-layer='" + focus_item + "']").focus();
    });
  }
  lypop_open();
 // lypop_close();

  // 디지털도서관 시설 및 예약안내
  $('.floor_information .subtitle_content').hide();
  $('.floor_information .is_opened .subtitle_content').attr('style', 'display:block');
  $('.floor_information .subtitle_inner').on('click', '.btn_floor', function (e) {
    var $target = $(e.currentTarget).parents('.subtitle_inner');
    var isOpened = $target.hasClass('is_opened');

    if(isOpened) {
      $target.removeClass('is_opened');
      $(this).attr('title', '펼치기');
      $target.find('.subtitle_content').stop().slideUp(function () {
        $(this).attr('style', 'display:none');
      });
    } else {
      $('.floor_information .is_opened .subtitle_content').slideUp(function(){
        $(this).attr('style', 'display:none')
      });
      $('.floor_information .is_opened').removeClass('is_opened');
      $target.addClass('is_opened');
      $(this).attr('title', '접기');
      $target.find('.subtitle_content').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
    }
  });

	// 설문조사
	$('.ucpoll_editor_wrap .btn_detail').on('click', function (e) {
		var $target = $(e.currentTarget).parents('.ucpoll_editor_wrap');
		var $btnText = $('.btn_detail').text('');
		var isCollapsed = $target.hasClass('is_collapsed');

		if(isCollapsed) {
		  $target.removeClass('is_collapsed');
		  $btnText.append('상세내용 접기');
		  $target.find('.editor_wrap').stop().slideDown(function () {
			$(this).removeAttr('style');
		  });
		} else {
		  $target.addClass('is_collapsed');
		  $btnText.append('상세내용 보기');
		  $target.find('.editor_wrap').stop().slideUp(function () {
			$(this).attr('style', 'display:none');
		  });
    }
  });

	//  모바일에서만 전화연결
	$('.ucapi23_table_wrap').on('click','.tel_info', function (e) {
		var isNotMobile = commons.getDeviceType() !== DEVICE_TYPE_MOBILE;
        if(isNotMobile){
			e.preventDefault();
		}
  })

  /*
  $('.newspaper_release_wrap').on('click', '.btn_newspaper_detail', function (e) {
    var $target = $(e.currentTarget).parents('.newspaper_release_wrap');
    var $btnText = $('.btn_newspaper_detail').text('');
    var isCollapsed = $target.hasClass('is_collapsed');
    if(isCollapsed) {
      $target.removeClass('is_collapsed');
      $btnText.append('상세 닫기');
      $target.find('.release_wrap_head').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
    } else {
      $target.addClass('is_collapsed');
      $btnText.append('상세 열기');
      $target.find('.release_wrap_head').stop().slideUp(function () {
        $(this).attr('style', 'display:none');
      });
    }
  });
*/
  // 관보 인명 검색
  $('.name_search_wrap .name_radio_wrap label').click(function(){
    if($(this).hasClass('english_alphabet')){
      $('.name_search_wrap .korean_alphabet_wrap').hide();
      $('.name_search_wrap .english_alphabet_wrap').show();
    }else if($(this).hasClass('korean_alphabet')){
      $('.name_search_wrap .korean_alphabet_wrap').show();
      $('.name_search_wrap .english_alphabet_wrap').hide();
    }
  });
  $('.sort_wrap .sort_depth1_item').on('click', '.btn_depth1_search', function (e) {
    e.preventDefault();
    var $target = $(e.currentTarget).parents('.sort_depth1_item');
    $target.addClass('is_sort_opened').siblings().removeClass('is_sort_opened');
  });

  $('.scope_type_wrap .sort_depth1_item').on('click', '.btn_depth1_search', function (e) {
    e.preventDefault();
    var $target = $(e.currentTarget).parents('.sort_depth1_item');
    $target.addClass('is_sort_opened').parents('.scope_type_wrap').find('.sort_depth2_item').addClass('is_sort_opened').siblings().removeClass('is_sort_opened');
  });
  $('.scope_type_wrap .sort_depth2_item').on('click', 'a', function (e) {
    e.preventDefault();
    var $target = $(e.currentTarget).parents('.sort_depth2_item');
    $target.parents('.scope_type_wrap').find('.sort_depth3_list').attr('style','display:inline-block');
  });

  // 신문 상세
  $('.newspaper_release_wrap').on('click', '.btn_newspaper_detail', function (e) {
    var $target = $(e.currentTarget).parents('.subtitle_inner');
    var isCollapsed = $target.hasClass('is_collapsed');
    if(isCollapsed) {
      $target.removeClass('is_collapsed');
      $target.find('.release_wrap_head').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
      $target.find('.btn_newspaper_detail').removeClass('btn_newspaper_detail1');
    } else {
      $target.addClass('is_collapsed');
      $target.find('.release_wrap_head').stop().slideUp(function () {
        $(this).attr('style', 'display:none');
      });
      $target.find('.btn_newspaper_detail').addClass('btn_newspaper_detail1');
    }
  });

  //IOS 파일선택 disabled
  //일단 테스트를 위해 input[file] 공통으로 넣었음
  //이후 이미지 외 파일 첨부에는 특정 클래스 추가하는 방향으로 수정
  $('.trigger-file-input, div[data-uploaded-box]').click(function(){
    if(!!navigator.platform &&
      /iPad|iPhone|iPod/.test(navigator.platform)){
       // window.alert('IOS에서는 지원하지 않습니다.');
        var input_id = $(this).attr('for');
        $('#' + input_id).attr('disabled','disabled');
        $(this).find('input').attr('disabled','disabled');
        $('input[type="file"]').attr('disabled','disabled');
    }
  })

  // 우편복사 신청 팝업
  $('.post_info_wrap').on('click', 'button' , function (e) {
    var $target = $(e.currentTarget).parents('.post_info_wrap');
    var isCollapsed = $target.hasClass('is_collapsed');

		if(isCollapsed) {
		$target.removeClass('is_collapsed');
		$target.find('.inner').stop().slideDown(function () {
			$(this).removeAttr('style');
		});
		} else {
		$target.addClass('is_collapsed');
		$target.find('.inner').stop().slideUp(function () {
			$(this).attr('style', 'display:none');
		});
		}
  });

  // 비치희망자료
  $('.furnish_wrap').on('click', '.btn_furnish_apply', function (e) {
    var $target = $(e.currentTarget).parents('.subtitle_inner');
    var isCollapsed = $target.hasClass('is_collapsed');

    if(isCollapsed) {
      $target.removeClass('is_collapsed');
      $target.find('.subtitle_content').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
    } else {
      $target.addClass('is_collapsed');
      $target.find('.subtitle_content').stop().slideUp(function () {
        $(this).attr('style', 'display:none');
      });
    }
  });
  //관보 전체 분류표
  $('.all_categorize_wrap').on('click', '.btn_depth1', function (e) {
    var $target = $(e.currentTarget).parents('.all_categorize_list li');
    var isExpanded = $target.hasClass('dp1_expanded');
    if(isExpanded) {
      $target.removeClass('dp1_expanded');
      $target.find('.depth2').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
    } else {
      $target.addClass('dp1_expanded');
      $target.find('.depth2').stop().slideUp(function () {
        $(this).attr('style', 'display:block');
      });
    }
  });
  $('.all_categorize_wrap').on('click', '.btn_depth2', function (e) {
    var $target = $(e.currentTarget).parents('.depth2 li');
    var isExpanded = $target.hasClass('dp2_expanded');
    if(isExpanded) {
      $target.removeClass('dp2_expanded');
      $target.find('.depth3').stop().slideDown(function () {
        $(this).removeAttr('style');
      });
    } else {
      $target.addClass('dp2_expanded');
      $target.find('.depth3').stop().slideUp(function () {
        $(this).attr('style', 'display:block');
      });
    }
  });});

/* 도서관 소개 > 국립중앙도서관 > 연혁 버튼 (/NL/contents/N50102010100.do)*/
$(function(){
  $('.btn_history_more').click(function(){
      $('.prev_history').addClass('is_open');
      $(this).hide();
      $('.btn_history_top').show();
  });
  $('.btn_history_top').click(function(){
      $("html,body").stop().animate({"scrollTop":"0"},400);
      return false;
  })
});

$(document).mouseup(function (e){
	if($( window ).width() <= 767){
	    var sch_cont = $(".cust_sel_wrap");
	    var sub_cont = $(".subUtill");
	    if(sch_cont.has(e.target).length == 0){
			$(".sel_btn_wrap").hide();
	    }
	    if(sub_cont.has(e.target).length == 0){
			$(".board_util_menu").hide();
	    }
	}
});
$(window).scroll(function(){
	if($( window ).width() <= 767){
		$(".sel_btn_wrap, .board_util_menu").hide();
	}
});
$( document ).ready(function() {
	var oasis_vid_elem = document.getElementById("oasis_video");

    $('#oasis_video').click(function() {
    	if(oasis_vid_elem.paused || oasis_vid_elem.ended){
    		oasis_vid_elem.play();
        }else{
        	oasis_vid_elem.pause();
        }
   	});

    $('#oasis_video').dblclick(function() {
		if (oasis_vid_elem.requestFullscreen) {
			oasis_vid_elem.requestFullscreen();
		} else if (oasis_vid_elem.mozRequestFullScreen) {
			oasis_vid_elem.mozRequestFullScreen();
		} else if (oasis_vid_elem.webkitRequestFullscreen) {
			oasis_vid_elem.webkitRequestFullscreen();
		} else if (oasis_vid_elem.msRequestFullscreen) {
			oasis_vid_elem.msRequestFullscreen();
		}
   	});

	 //$('#oasis_video').click();
});