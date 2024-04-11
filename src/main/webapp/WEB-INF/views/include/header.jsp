<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<!DOCTYPE html>
<html>
 <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/qaCss.css">
	
  </head>
<body>
	<header class="p-3 text-bg-dark">
		<div class="container">
		  <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
		    <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
		      <img width="40" height="32" src="/images/logo2.png" alt="logo"/>
		  	</a>
		
		    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0"
		    	style="margin-left : 50px">
		        
		        <li><a href="#" class="nav-link px-2 text-white">소개</a></li>
		        <li><a href="#" class="nav-link px-2 text-white">경매</a></li>
		        <li><a href="#" class="nav-link px-2 text-white">게시판</a>
		        	<ul class="submenu">
                		<li><a href="/announcement/getList" class="nav-link px-2 text-white">공지사항</a></li>
                		<li><a href="/qa/getList" class="nav-link px-2 text-white">Q&A</a></li>
                	</ul>
            	</li>
		        
		      
		        
		        
		        <li><a href="#" class="nav-link px-2 text-white">??</a></li>
		      </ul>
		
		      <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
		        <input type="search" class="form-control form-control-dark text-bg-dark" placeholder="Search..." aria-label="Search">
		      </form>
		
		      <div class="text-end">
		        <button type="button" class="btn btn-outline-light me-2">Login</button>
		        <button type="button" class="btn btn-warning">Sign-up</button>
		      </div>
		    </div>
		</div>
	</header>