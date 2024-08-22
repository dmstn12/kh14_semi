<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>oneTrillion</title>
    
    <meta charset="UTF-8">

    <!-- 내가 만든 스타일 시트를 불러오는 코드 -->
    <link rel="stylesheet" type="text/css" href="/css/commons.css">
    <link rel="stylesheet" type="text/css" href="/css/test.css">
    <!-- font awesome-->
    <link rel="stylesheet" type="text/css"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

</head>
<style>
    .menu {
        background-color: antiquewhite;
        font-size: 16px;
    }

    .menu :hover {
        filter: brightness(100%);
    }

    .menu ul {
        background-color: beige;
    }

    .menu ul :hover {
        background-color: antiquewhite;
    }

    .menu>li>ul ul {
        background-color: azure;
    }

    .top-menu {
        background-color: white;
        font-size: 12px;
    }

    .top-menu :hover {
        background-color: rgb(184, 184, 184);
    }

    .all-menu-ul {
        list-style-type: none;
        /* 기본 리스트 스타일 제거 */
        margin: 0;
        /* 기본 마진 제거 */
        padding: 0;
        /* 기본 패딩 제거 */
        display: flex;
        /* flexbox를 사용하여 가로 배치 */
        font-size: 12px;
    }

    

        /* .ul-horizon{

        }
        .li-horizon{
            display: inline-block;
            margin-right: 20px;
        }  */
</style>
    <link rel="stylesheet" type="text/css" href="/css/checkbox.js">

<body> <!-- 문서의 출력 내용을 담는 태그 -->
    <!-- 		<h1>내가 만든 홈페이지</h1> -->
    <!-- 		<a href=""></a> -->
    <!-- 상단(Header) -->
    <div class="container w-1200">
        <div class="row">
            <ul class="menu top-menu">
                <!-- 구분선 -->
                <li>
                    <a href="#">고객센터</a>
                </li>
                <li>
                    <a href="#">즐겨찾기</a>
                </li>
                <li>
                    <a href="#">바로가기</a>
                </li>
                <li class="right-menu">
                    <a href="#">로그인</a>
                </li>
                <li>
                    <a href="#">회원가입</a>
                </li>
                <li>
                    <a href="#">주문 / 배송조회</a>
                </li>
                <li>
                    <a href="#">1:1문의</a>
                </li>
                <li>
                    <a href="#">커뮤니티</a>
                    <ul>
                        <li>
                            <a href="#">항목1</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#"><i class="fa-solid fa-cart-shopping"></i></a> <!-- 장바구니 -->
                </li>
            </ul>

            <!-- 구분선 -->

        </div>
        <div class="row center">
            <a href="/">
                <img src="http://via.placeholder.com/300x100.png">
            </a>
        </div>

        <!-- 정보 확인용 공간 나중에 삭제 -->
        <!-- <div>
			session id = ${pageContext.session.id} , 
			createdUser = ${sessionScope.createdUser} ,
			createdLevel = ${sessionScope.createdLevel}
		</div> -->

        <!-- 
			메뉴(Navbar) 
			- (중요) 템플릿 페이지의 모든 경호는 전부 다 절대경로로 사용
			- 로그인 상태일 때와 비로그인 상태일 때 다르게 표시
			- 로그인 상태 : sessionScope.createdUser != null
			
			-->


        <ul class="menu">
            <!-- 구분선 -->
            <li class="flex-core all-menu">
                <i class="fa-solid fa-bars"></i>
                전체메뉴
                    <ul class="all-menu-ul ul-horizon">
                            <li class="li-horizon"><a href="#">상의 상세항목1</a></li>
                            <li class="li-horizon"><a href="#">상의 상세항목1</a></li>
                            <li class="li-horizon"><a href="#">상의 상세항목1</a></li>
                            <li class="li-horizon"><a href="#">상의 상세항목1</a></li>
                    </ul>
                        <ul class="all-menu-ul ul-horizon">
                            <li class="li-horizon"><a href="#">상의 상세항목1</a></li>
                            <li class="li-horizon"><a href="#">상의 상세항목1</a></li>
                            <li class="li-horizon"><a href="#">상의 상세항목1</a></li>
                            <li class="li-horizon"><a href="#">상의 상세항목1</a></li>
                        </ul>

            </li>
            <li>
                <a href="#">상의</a>
                <ul>
                    <li>
                        <a href="#">항목1</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">항목2</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li><a href="#">항목3</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li><a href="#">항목4</a>
                        <ul>
                            <li><a href="#">상세항목1</a>
                        </ul>
                    </li>
                </ul>
            </li>
            <!-- 구분선 -->
            <li>
                <a href="#">하의</a>
                <ul>
                    <li>
                        <a href="#">항목1</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">항목2</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li><a href="#">항목3</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li><a href="#">항목4</a>
                        <ul>
                            <li><a href="#">상세항목1</a>
                        </ul>
                    </li>
                </ul>
            </li>
            <!-- 구분선 -->
            <li>
                <a href="#">슈즈</a>
                <ul>
                    <li>
                        <a href="#">항목1</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">항목2</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li><a href="#">항목3</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li><a href="#">항목4</a>
                        <ul>
                            <li><a href="#">상세항목1</a>
                        </ul>
                    </li>
                </ul>
            </li>
            <!-- 구분선 -->
            <li class="right-menu">
                <a href="#">문의</a>
                <ul>
                    <li>
                        <a href="#">항목1</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">항목2</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">항목3</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                    <li><a href="#">항목4</a>
                        <ul>
                            <li><a href="#">상세항목1</a></li>
                        </ul>
                    </li>
                </ul>
            </li>
            <!-- 구분선 -->
        </ul>
    </div>

    <!-- 중단(Container) -->