<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link rel="stylesheet" href="css/login.css">

<title>FastTrack</title>
</head>
<body class="body" style="background-image: url(images/background.jpg);" >
<h1 class="title">FastTrack</h1>
 <div class="container">
    <div class="box">
       <h1 >Welcome !!</h1><br>                                                                                                                                                                                                 
       <p> Sign in your account using  Asgardeo </p><br>
       <button type= "button" onclick = "window.location.href='https://api.asgardeo.io/t/orguja25/oauth2/authorize?scope=openid%20address%20email%20phone%20profile&response_type=code&redirect_uri=http://localhost:8080/FastTrack-VehicleService/authorize.jsp&client_id=tX93cTzfV89Mq91fkfJNDPgSaHEa&login_hint=abeykoo-se19021@stu.kln.ac.lk &prompt=login'">SignIn</button>
       <p>Don't have an account </p>
       <button type= "button" class="new-btn" onclick="window.location.href = 'https://console.asgardeo.io/'">create</button>
    
    </div>
 </div>
</body>
</html>