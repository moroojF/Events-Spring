<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register/Login</title>
<link rel="stylesheet"
	href="/webjars/bootstrap/4.5.0/css/bootstrap.min.css" />
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row my-5">
			<div class="col text-center">
				<h3 class="text-danger"><c:out value="${error}"></c:out></h3>
			</div>
		</div>
		<div class="row my-5">
			<div class="col-sm-8">
				<div class="card">
					<div class="card-header bg-dark text-light">Register</div>
					<div class="card-body">
						<form:form action="/register" method="post" modelAttribute="newUser">
							<div class="form-group">
								<label>First Name:</label>
								<form:input path="fName" class="form-control" />
								<form:errors path="fName" class="text-danger" /> 
							</div>
							<div class="form-group">
								<label>Last Name:</label>
								<form:input path="lName" class="form-control" />
								<form:errors path="lName" class="text-danger" /> 
							</div>
							<div class="form-group">
								<label>Email:</label>
								<form:input path="email" class="form-control" />
								<form:errors path="email" class="text-danger" /> 
							</div>
							<div class="form-group">
								<label>Location:</label>
								<form:input path="location" class="form-control" />
								<form:errors path="location" class="text-danger" /> 
							</div>
							<div class="form-group">
								<label>Password:</label>
								<form:password path="password" class="form-control" />
								<form:errors path="password" class="text-danger" /> 
							</div>
							<div class="form-group">
								<label>Confirm Password:</label>
								<form:password path="confirm" class="form-control" />
								<form:errors path="confirm" class="text-danger" /> 
							</div>
							<input type="submit" value="Register" class="btn btn-block btn-primary" />
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="card">
					<div class="card-header bg-dark text-light">Login</div>
					<div class="card-body">
						<form:form action="/login" method="post" modelAttribute="newLogin">
							<div class="form-group">
								<label>Email:</label>
								<form:input path="email" class="form-control" />
								<form:errors path="email" class="text-danger" /> 
							</div>
							<div class="form-group">
								<label>Password:</label>
								<form:password path="password" class="form-control" />
								<form:errors path="password" class="text-danger" /> 
							</div>
							<input type="submit" value="Login" class="btn btn-block btn-info" />
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>