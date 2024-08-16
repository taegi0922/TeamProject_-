<%@page import="com.medicalInfo.project.model.MemberInfoDTO"%>
<%@page import="com.medicalInfo.project.model.PrescriptDTO"%>
<%@page import="com.medicalInfo.project.model.MemberDTO"%>
<%@page import="com.medicalInfo.project.model.MemberType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!doctype html>
<html class="no-js" lang="zxx">
    <head>

        <!-- Meta Tags -->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="keywords" content="Site keywords here">
		<meta name="description" content="">
		<meta name='copyright' content=''>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<!-- Title -->
        <title>약 쳐봥 - 당신의 모든 약 정보</title>
        
        <style type="text/css">
        	.pageBtn {width: 100%; margin:0 auto; box-sizing: border-box;}
        	.pagination {text-align: center; vertical-align: middle; }
			.paginate_button {display: inline-block; list-style: none; padding: 6px; text-align: center;}
			
			#rateform fieldset{
			    display: inline-block;
			    direction: rtl;
			    border:0;
			}
			#rateform fieldset legend{
			    text-align: right;
			}
			#rateform input[type=radio]{
			    display: none;
			}
			#rateform label{
			    font-size: 3em;
			    color: transparent;
			    text-shadow: 0 0 0 #f0f0f0;
			}
			#rateform label:hover{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			#rateform label:hover ~ label{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			#rateform input[type=radio]:checked ~ label{
			    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
			}
			#reviewContents {
			    width: 100%;
			    height: 150px;
			    padding: 10px;
			    box-sizing: border-box;
			    border: solid 1.5px #D3D3D3;
			    border-radius: 5px;
			    font-size: 16px;
			    resize: none;
			}
		</style>
		
		<!-- Favicon -->
        <link rel="icon" href="../resources/img/minicon.png">
		
		<!-- Google Fonts -->
		<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">

		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
		<!-- Nice Select CSS -->
		<link rel="stylesheet" href="../resources/css/nice-select.css">
		<!-- Font Awesome CSS -->
        <link rel="stylesheet" href="../resources/css/font-awesome.min.css">
		<!-- icofont CSS -->
        <link rel="stylesheet" href="../resources/css/icofont.css">
		<!-- Slicknav -->
		<link rel="stylesheet" href="../resources/css/slicknav.min.css">
		<!-- Owl Carousel CSS -->
        <link rel="stylesheet" href="../resources/css/owl-carousel.css">
		<!-- Datepicker CSS -->
		<link rel="stylesheet" href="../resources/css/datepicker.css">
		<!-- Animate CSS -->
        <link rel="stylesheet" href="../resources/css/animate.min.css">
		<!-- Magnific Popup CSS -->
        <link rel="stylesheet" href="../resources/css/magnific-popup.css">
		
		<!-- Medipro CSS -->
        <link rel="stylesheet" href="../resources/css/normalize.css">
        <link rel="stylesheet" href="../resources/style.css">
        <link rel="stylesheet" href="../resources/css/responsive.css">
        
        <link rel="stylesheet" href="../resources/css/table.css">
        <link rel="stylesheet" href="../resources/css/login.css">
        <link rel="stylesheet" href="../resources/css/paging.css">
      	<link rel="stylesheet" href="../resources/css/member-edit.css">
      
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
    <body>
	
		<!-- Preloader -->
        <div class="preloader">
            <div class="loader">
                <div class="loader-outter"></div>
                <div class="loader-inner"></div>

                <div class="indicator"> 
                    <svg width="16px" height="12px">
                        <polyline id="back" points="1 6 4 6 6 11 10 1 12 6 15 6"></polyline>
                        <polyline id="front" points="1 6 4 6 6 11 10 1 12 6 15 6"></polyline>
                    </svg>
                </div>
            </div>
        </div>
        <!-- End Preloader -->
		
		<!-- Get Pro Button -->
		<ul class="pro-features">
			<li class="big-title">Pro Version Available on Themeforest</li>
			<li class="title">Pro Version Features</li>
			<li>2+ premade home pages</li>
			<li>20+ html pages</li>
			<li>Color Plate With 12+ Colors</li>
			<li>Sticky Header / Sticky Filters</li>
			<li>Working Contact Form With Google Map</li>
			<div class="button">
				<a href="http://preview.themeforest.net/item/mediplus-medical-and-doctor-html-template/full_screen_preview/26665910?_ga=2.145092285.888558928.1591971968-344530658.1588061879" target="_blank" class="btn">Pro Version Demo</a>
				<a href="https://themeforest.net/item/mediplus-medical-and-doctor-html-template/26665910" target="_blank" class="btn">Buy Pro Version</a>
			</div>
		</ul>
	
		<!-- Header Area -->
		<header class="header" >

			<!-- Header Inner -->
			<div class="header-inner">
				<div class="container">
					<div class="inner">
						<div class="row">
							<div class="col-lg-3 col-md-3 col-12">
								<!-- Start Logo -->
								<div class="logo">
									<a href="../login"><img src="../resources/img/mainlogo.jpg" alt="#"></a>
								</div>
								<!-- End Logo -->
								<!-- Mobile Nav -->
								<div class="mobile-nav"></div>
								<!-- End Mobile Nav -->
							</div>
							<div class="col-lg-7 col-md-9 col-12">
                                <!-- Main Menu -->
                                <div class="main-menu">
                                    <nav class="navigation">
                                        <ul class="nav menu">                   
                                            <li><a href=../qa/list>QA 게시판 </a></li> <!-- 태기님 파트 -->
                                            <li><a href="/notice">공지사항 </a></li> <!-- 수연이 파트 -->
                                            <li><a href="../mypage/patientMypage">마이페이지 <i class="icofont-rounded-down"></i></a>
                                                <ul class="dropdown">
                                         
                                                    <li><a href="../mypage/memberEdit">회원정보 수정</a></li> <!-- PATIENT 정보 수정 -->
                                                    <li><a href="/applyExpert">전문가 신청하기</a></li>
                                                    <li><a href="/waitforexpert">전문가 승인(관리자만 접근가능)</a></li>
                                                </ul>
                                            </li>
											
											<%
												// Get the session attribute "membertype"
												
											    MemberType membertype = (MemberType) session.getAttribute("membertype");
												MemberDTO memberDTO = (MemberDTO) session.getAttribute("member_info");
												MemberInfoDTO memberInfoDTO = (MemberInfoDTO) session.getAttribute("member");
												PrescriptDTO prescriptDTO = (PrescriptDTO) session.getAttribute("prescript");
												String kakaoEmail = (String) session.getAttribute("kakaoEmail");
												
											%>	
											<%
											    if (membertype == MemberType.EXPERT) {
											%>
											<li><a href="../mypage/expertMypage">전문가 페이지<i class="icofont-rounded-down"></i></a>
												<ul class="dropdown">
													<li><a href="../prescriptwrite">처방전 작성</a></li> <!-- 장열님 파트 -->
													<li><a href="../mypage/searchPre">처방전 검색</a></li>
												</ul>
											</li>
											
											<%
											    }
											%>
											<li><a href=../bestRating>실시간 전문가 BEST3 </a></li>
										</ul>
									</nav>
								</div>
								<!--/ End Main Menu -->
							</div>
							<div class="col-lg-2 col-12">
								<div class="get-quote">
                                    <%
                                        if (membertype == null) {
                                    %>
                                    <c:choose>
                                        <c:when test="${empty isLogin || isLogin == false}">
                                            <a href="../login" class="btn">로그인</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="../loginidpw" class="btn">로그인</a>
                                        </c:otherwise>
                                    </c:choose>
                                    <%
                                        } else if (membertype != null) {
                                    %>
                                    <a href="https://kauth.kakao.com/oauth/logout?client_id=bc19ac7c0d184c8fbf994a386db912f2&logout_redirect_uri=http://localhost:8090/logout" class="btn">로그아웃</a>
                                    <%
                                        }
                                    %>
                                </div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--/ End Header Inner -->
		</header>