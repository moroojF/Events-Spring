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
<title>Edit Event</title>
</head>
<body>
	<div class="container">
		<div class="row my-5">
			<div class="col-10">
				<h2 class="mb-5">${event.name}</h2>
				<h4>Edit Event</h4>
			</div>
			<div class="col-2 mt-3">
				<a href="/logout">Logout</a> / 
				<a href="/home">Back</a>
			</div>
		</div>
		<div class="row mt-5 ml-1">
			<form:form action="/events/${event.id}/edit" method="post" modelAttribute="event">
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