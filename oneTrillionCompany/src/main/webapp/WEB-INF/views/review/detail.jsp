<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>

<script>

(function ($) {
    const merge = (target, source) => {
        for (let key of Object.keys(source)) {
            if (source[key] instanceof Object) Object.assign(source[key], merge(target[key], source[key]))
        }
        Object.assign(target || {}, source)
        return target
    }
    $.fn.score = function (options) {
        options = options || {};
        
        const settings = merge({
            starColor: "gold", //별 색상
            backgroundColor: "transparent", //배경 색상
            editable: false, //점수 변경 가능 여부
            integerOnly: false, //정수만 설정 가능 여부
            zeroAvailable:false,//0 설정 가능 여부
            send: {
                sendable:false,
            },
            display: {
                showNumber: false, //설정된 숫자 표시 가능 여부
                placeLimit: 1, //소수점 자리수 표시 길이
                textColor:"gold",//텍스트 색상
            },
            point: {
                max: 5,//최대 점수(data-max로 대체 가능)
                rate: 0,//실제 점수(data-rate로 대체 가능)
            }
        }, options);

        //유틸리티 : 점수 <---> 퍼센트
        const getPercentFromPoint = function (max, rate) {
            return rate / max * 100;
        };
        const getPercentFromPointInteger = function (max, rate) {
            const segment = 100 / max;
            return Math.floor((getPercentFromPoint(max, rate) + segment / 2) / segment) * segment;
        };
        const getPointFromPercent = function (max, percent, limit) {
            const value = max * percent / 100;
            return value.toFixed(limit || settings.display.placeLimit);
        };
        const getFillStarText = function(size){
            return "★".repeat(size);
        };
        const getEmptyStarText = function(size){
            return "☆".repeat(size);
        };

        //이벤트 핸들러
        function pointHandler (e) {
            //퍼센트 계산
            const data = this.parentNode._data;
            const width = parseInt(window.getComputedStyle(this, null).width);
            let percent = e.offsetX / width * 100;
            if(!settings.zeroAvailable) {
                percent = percent == 0 ? 0.1 : percent;
            }
            
            //퍼센트 표시
            $(this).find(".foreground").css("width", percent + "%");

            //평점 표시
            if (settings.display.showNumber) {
                $(this).parent().find(".display-panel").text(getPointFromPercent(data.max, percent));
            }

            if (settings.send && settings.send.sendable) {
                $(this).parent().find(".point-input").val(getPointFromPercent(data.max, percent));
            }

        };
        function pointIntegerHandler (e) {
            //퍼센트 계산
            const data = this.parentNode._data;
            const width = parseInt(window.getComputedStyle(this, null).width);
            const segment = 100 / data.max;
            let percent = e.offsetX / width * 100;
            percent = (Math.floor((percent-0.001) / segment) + 1) * segment
            if(!settings.zeroAvailable) {//0 설정 불가일 경우
                if(percent == 0){//0이면 segment로 설정
                    percent = segment;
                }
            }

            //퍼센트 표시
            $(this).find(".foreground").css("width", percent + "%");

            //평점 표시
            if (settings.display.showNumber) {
                $(this).parent().find(".display-panel").text(getPointFromPercent(data.max, percent));
            }

            if (settings.send && settings.send.sendable) {
                $(this).parent().find(".point-input").val(getPointFromPercent(data.max, percent));
            }

           
        };

        return this.each(function () {
            //기본 디자인
            $(this).css({
                'display': "inline-flex",
                'color': settings.starColor,
                'background-color': settings.backgroundColor,
                'white-space':'nowrap',
            });
            
            //별점 설정
            this._data = {
                max:$(this).data("max") || settings.point.max,
                rate:$(this).data("rate") || settings.point.rate,
            };
            const percent = settings.integerOnly ? 
                        getPercentFromPointInteger(this._data.max, this._data.rate) 
                        : getPercentFromPoint(this._data.max, this._data.rate);
                                                
            //영역 생성
            const star = $("<div>").addClass("star")
                                                .css({
                                                    "color":"inherit",
                                                    "background-color":"inherit",
                                                    "position":"relative",
                                                    "display":"inline-flex"
                                                });
            const foreground = $("<div>").addClass("foreground")
                                                    .css({
                                                        "overflow":"hidden",
                                                        "width":percent+"%",
                                                        "color":"inherit",
                                                        "background-color":"inherit"
                                                    })
                                                    .text(getFillStarText(this._data.max));
            const background = $("<div>").addClass("background")
                                                        .css({
                                                            "position":"absolute",
                                                            "color":"inherit",
                                                            "background-color":"inherit"
                                                        })
                                                        .text(getEmptyStarText(this._data.max));

            star.append(foreground).append(background).appendTo(this);

            if (settings.display.showNumber) {
                const displayPanel = $("<div>").addClass("display-panel").css("color", settings.display.textColor).text(this._data.rate.toFixed(settings.display.placeLimit));
                displayPanel.appendTo(this);
            }

            if (settings.send && settings.send.sendable) {
                const input = $("<input>").attr("type", "hidden").attr("name", settings.send.name).addClass("point-input");
                if(settings.integerOnly){
                    input.val(getPointFromPercent(settings.point.max, percent));
                }
                else {
                    input.val(getPointFromPercent(settings.point.max, percent));
                }
                input.appendTo(this);
            }

            if (settings.editable) {
                if (settings.integerOnly) {
                    star.click(pointIntegerHandler);
                } else {
                    star.click(pointHandler);
                }
            }

        });
    };
})(jQuery);
</script>
<script type="text/javascript">
    $(function() {
        $(".test-score").score({
            starColor: "orange", // 별 색상
            editable: false, // 점수 변경 가능 여부
            integerOnly: true, // 정수만 설정 가능 여부
            
            display: {
                showNumber: false, // 설정된 숫자 표시 가능 여부
                placeLimit: 0, // 소수점 자리수 표시 길이
                textColor: "#0984e3", // 텍스트 색상
            },
            point: {
                max: 5, // 최대 점수
                rate: 5, // 기본 점수
            },
            onChange: function(score) {
                console.log("score : " + score);
                $('input[name="reviewScore"]').val(score);
            }
        });

   
    });
</script>

<form action="delete?reviewNo=${reviewDto.reviewNo}" method="post" enctype="multipart/form-data" autocomplete="off" id="checkForm">
	<div class="container w-1200">
		<div class="row center">
		
			<div class="row left">
				<span>작성자 : ${reviewDto.reviewWriter}</span>
			</div>
			
			<div class="row left">
				<span>별점
				 <div class="test-score" data-max="5" data-rate="${reviewDto.reviewScore}"></div>
				 ${reviewDto.reviewScore}점
				 </span>
			</div>
			
			<div class="row">
				<span>${reviewDto.reviewContent}</span>
			</div>
			<div class="center">
	        	<img src="image?reviewNo=${reviewDto.reviewNo}" width="150" height="150">
	        </div>			
		</div>
		<div class="row right">
			<a href="delete?reviewNo=${reviewDto.reviewNo}" class="btn btn-delete">삭제</a>
		</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>