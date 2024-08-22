<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
	<div class="row center">
		<h1>회원 검색</h1>
	</div>
	<div class="row right">	
		<h3>데이터개수 : ${list.size()}</h3>
	</div>
	<!-- 검색창 -->
	<div class="row">
		<form action="list" method="get" autocomplete="off" class="field">
			<select name="column">
				<option value="member_id"<c:if test="${column=='member_id'}">selected</c:if>>아이디</option>
				<option value="member_nickname"<c:if test="${column=='member_nickname'}">selected</c:if>>닉네임</option>
				<option value="member_rank"<c:if test="${column=='member_rank'}">selected</c:if>>등급</option>
			</select>
		</form>
	</div>
	
	<!-- 검색 결과 -->
	<div class="row center">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>아이디</th>
					<th>닉네임</th>
					<th>등급</th>
					<th>차단 상태</th>
					<th>가입일</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<%--검색 결과가 없을 때 --%>
					<c:when test="${list.isEmpty()}">
						<tr>
							<td>검색 결과가 존재하지 않습니다</td>
						</tr>
					</c:when>
					<%--검색 결과가 있을 때 --%>
					<c:otherwise>
						<c:forEach var="memberBlockVO" items="${list}">
							<tr>
								<td>
									<a href="detail?memberId=${memberBlockVO.memberId}" class="link">${memberBlockVO.memberId}</a>
								</td>
								<td>${memberBlockVO.memberNickname}</td>
								<td>${memberBlockVO.memberRank}</td>
								<td>${memberBlockVO.memberBlock}</td>
								<td>${memberBlockVO.memberJoin}</td>
								<td>
									<a href="update?memberId=${memberBlockVO.memberId}">수정</a>
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${memberBlockVO.blockType=='차단'}"> --%>
<%-- 											<a href="block?blockMemberId=${memberBlockVO.memberId}">해제</a> --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<%-- 											<a href="block?blockMemberId=${memberBlockVO.memberId}">차단</a> --%>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>