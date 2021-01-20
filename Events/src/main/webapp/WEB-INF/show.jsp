<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.0/css/bootstrap.min.css" />
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row mt-5">
			<div class="col-10">
				<h2 class="mb-5">${event.name}</h2>
			</div>
			<div class="col-2 mt-3">
				<a href="/logout">Logout</a> / 
				<a href="/home">Back</a>
			</div>
		</div>
		<div class="row">
			<div class="col-6">
				<h4>Host: ${event.planner.fName} ${event.planner.lName}</h4>
				<h4>Date: <fmt:formatDate type="date" value="${event.date}" pattern="MMMMM dd, yyyy" /></h4>
				<h4>Location: ${event.location}</h4>
				<h4>People who are attending this event: ${event.attendance.size()}</h4>
				<table class="table table-hover">
			    <thead>
			      <tr>
			        <th>Name</th>
			        <th>Location</th>
			      </tr>
			    </thead>
			    <tbody>
			    <c:forEach items="${event.attendance}" var="a">
			      <tr>
			        <td>${a.fName} ${a.lName}</td>
			        <td>${a.location}</td>
			      </tr>
			    </c:forEach>
			    </tbody>
			  </table>
			</div>
			<div class="col-6">
				<h3>Message Wall</h3>
				<div style="height: 300px; overflow: auto; border: solid black 1px" class="ml-2 mt-4">
				<c:if test="${messages.size() > 0}">
					<c:forEach items="${messages}" var="m">
						<p class="mx-3 pb-3" style="border-bottom: dashed black 1px">${m.writer.fName} says: ${m.message}</p>
					</c:forEach>
				</c:if>
				<c:if test="${messages.size() <= 0}">
					<p class="ml-3">No messages posted yet.</p>
				</c:if>
				</div>
				<div class="row mt-4 ml-2">
					<form:form action="/events/${event.id}/messages" method="post" modelAttribute="newMessage">
						<div class="form-group">
							<label>Add Comment:</label>
							<form:textarea placeholder="Remember, be nice!" cols="63" rows="2" path="message" class="form-control"/>
							<form:errors path="message" class="text-danger" />
						</div>
						<input type="submit" value="Submit" class="btn btn-primary" />
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>