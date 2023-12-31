<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>

<%
	
		String code = request.getParameter("code");
	
	// Retrieve the 'session_state' parameter from the URL
		String sessionState = request.getParameter("session_state");
	

%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <script type="text/javascript">
        // Function to make a POST request
        function makePostRequest() {
            // Define the URL
            var url = 'https://api.asgardeo.io/t/orguja25/oauth2/token';

            var code = encodeURIComponent('<%= code %>');
            var sessionState = encodeURIComponent('<%= sessionState %>');
            var client_Id = 'tX93cTzfV89Mq91fkfJNDPgSaHEa';
            var client_secret = 'uwVoFzE6cRZfCnR896b5tWZdGPHvvIIIQfIEwugP6MMa';
            var redirect_uri = 'http://localhost:8080/FastTrack-VehicleService/authorize.jsp';

            // Define the request body parameters
            var bodyParams = new URLSearchParams();
            bodyParams.append('code', code);
            bodyParams.append('grant_type', 'authorization_code');
            bodyParams.append('client_id', client_Id);
            bodyParams.append('client_secret', client_secret);
            bodyParams.append('redirect_uri', redirect_uri);

            // Define the request options
            var requestOptions = {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                data: bodyParams.toString() // Convert bodyParams to a string
            };

            // Make the POST request using jQuery AJAX
            $.ajax(url, requestOptions)
                .done(function (data) {
                  	// Handle the response data here
                    console.log(data.access_token);
                    var access_token  = data.access_token;
                   	var id_token = data.id_token;
                   	localStorage.setItem('access_token', access_token);
                   	localStorage.setItem('id_token', id_token);
                   	
                   	
            	    window.location.href = "pages/home.jsp";
                })	
                .fail(function (error) {
                	// Handle any errors here
                	console.error('Error:', error);
                	window.location.href = "login.jsp";
                	});

                
        }

        // Call the function to make the POST request
        makePostRequest();
    </script>
</body>
</html>
