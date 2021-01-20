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
	<meta charset="UTF-8">
	<title>Welcome</title>
</head>
<body>
	<div class="container">
		<div class="row my-5">
			<div class="col-10">
				<h1>Welcome, <c:out value="${user.fName}" /></h1>
			</div>
			<div class="col-2 mt-3">
				<a href="/logout">Logout</a>
			</div>
		</div>
		<div class="row">
			<h3>Here are some of the events in your state.</h3>
			<table class="table table-hover">
			    <thead>
			      <tr>
			        <th>Name</th>
			        <th>Date</th>
			        <th>Location</th>
			        <th>Host</th>
			        <th>Action/Status</th>
			      </tr>
			    </thead>
			    <tbody>
			    <c:forEach items="${inLocation}" var="e">
			      <tr>
			        <td><a href="/events/${e.id}">${e.name}</a></td>
			        <td><fmt:formatDate type="date" value="${e.date}" pattern="MMMMM dd, yyyy" /></td>
			        <td>${e.location}</td>
			        <td>${e.planner.fName}</td>
			        <td>
			        	<c:if test="${user.id == e.planner.id}">
							<a href="/events/${e.id}/edit" class="btn btn-sm btn-outline-dark">Edit</a>
							<a href="/events/${e.id}/delete" class="btn btn-sm btn-outline-danger">Cancel</a>
						</c:if>
						<c:if test="${user.id != e.planner.id}">
							<c:if test="${e.isOnEvent(user.id)}">
								<a href="/events/${e.id}/leave" class="btn btn-sm btn-outline-info">Leave</a>
							</c:if>
							<c:if test="${!e.isOnEvent(user.id)}">
								<a href="/events/${e.id}/join" class="btn btn-sm btn-outline-primary">Join</a>
							</c:if>
						</c:if>
					</td>
			      </tr>
			    </c:forEach>
			    </tbody>
			  </table>
		</div>
		<div class="row mt-5">
		<h3>Here are some of the events in other states.</h3>
		<table class="table table-hover">
			    <thead>
			      <tr>
			        <th>Name</th>
			        <th>Date</th>
			        <th>Location</th>
			        <th>Host</th>
			        <th>Action/Status</th>
			      </tr>
			    </thead>
			    <tbody>
			    <c:forEach items="${notInLocation}" var="e">
			      <tr>
			        <td><a href="/events/${e.id}">${e.name}</a></td>
			        <td><fmt:formatDate type="date" value="${e.date}" pattern="MMMMM dd, yyyy" /></td>
			        <td>${e.location}</td>
			        <td>${e.planner.fName}</td>
			        <td>
						<c:if test="${user.id != e.planner.id}">
							<c:if test="${e.isOnEvent(user.id)}">
								<a href="/events/${e.id}/leave" class="btn btn-sm btn-outline-info">Leave</a>
							</c:if>
							<c:if test="${!e.isOnEvent(user.id)}">
								<a href="/events/${e.id}/join" class="btn btn-sm btn-outline-primary">Join</a>
							</c:if>
						</c:if>
					</td>
			      </tr>
			    </c:forEach>
			    </tbody>
			  </table>
		</div>
		<div class="row mt-5">
		<form:form action="/events" method="post" modelAttribute="newEvent">
			<div class="form-group">
				<label>Name:</label>
				<form:input path="name" class="form-control" />
				<form:errors path="name" class="text-danger" />
			</div>
			<div class="form-group">
				<label>Date:</label>
				<form:input type="date" path="date" class="form-control" />
				<form:errors path="date" class="text-danger" />
			</div>
			<div class="form-group">
				<label>Location:</label>
				<form:input path="location" class="form-control" />
				<form:errors path="location" class="text-danger" />
			</div>
			<input type="submit" value="Plan Event" class="btn btn-primary" />
		</form:form>
		</div>
	</div>
</body>
</html>