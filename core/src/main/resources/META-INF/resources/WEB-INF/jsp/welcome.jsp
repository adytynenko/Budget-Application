<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description"
	content="Budgetly is a robust budgeting application allowing you create, update, and 
      delete budgets and expenses." />
<title>Welcome</title>
</head>
<h1 class="text-center mt-3">Budget Application</h1>
<body>
	<div class="container">
		<div class="row">
			<div class="col">
			</div>
		</div>
		<div class="row">
			<div class="col-3">
				<jsp:include page="vertical-navigation.jsp" /><form>
					
				</form>
			</div>
			<div class="col-9">page content</div>
		</div>
	</div>
</body>
</html>