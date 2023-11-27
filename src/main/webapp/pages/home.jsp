<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.services.jsp.*" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>
<%@ page import="java.util.Properties" %>
<%
		String dbUrl = "jdbc:mysql://172.187.178.153:3306/isec_assessment2";
		String dbUser = "isec";
		String dbPassword = "EUHHaYAmtzbv";
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			 // Load the MySQL JDBC driver
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		    System.out.println("Connected to the database!");
		
		    if (request.getMethod().equalsIgnoreCase("POST")) {
		        String date = request.getParameter("date");
		        String time = request.getParameter("time");
		        String location = request.getParameter("location");
		        String vehicle_no = request.getParameter("vehicle_no");
		        String mileage = request.getParameter("mileage");
		        String message = request.getParameter("message");
				String username = request.getParameter("usernameField");
		        
		        int mile = Integer.parseInt(mileage);
		        SimpleDateFormat inputFormat = new SimpleDateFormat("hh:mm a");

		        Date parsedDate = inputFormat.parse(time);

		        // Convert parsedDate to java.sql.Time
		        Time sqlTime = new Time(parsedDate.getTime());
		        
		        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		 	    Date sqlDate = dateFormat.parse(date);
		        
		        String insertQuery = "INSERT INTO vehicle_service (date, time, location, vehicle_no, mileage, message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";
		        preparedStatement = connection.prepareStatement(insertQuery);
		        preparedStatement.setDate(1, new java.sql.Date(sqlDate.getTime()));
		        preparedStatement.setTime(2, sqlTime);
		        preparedStatement.setString(3, location);
		        preparedStatement.setString(4, vehicle_no);
		        preparedStatement.setInt(5, mile);
		        preparedStatement.setString(6, message);
		        preparedStatement.setString(7, username);
		        preparedStatement.executeUpdate();
		    }
		    else {
		        System.out.println("Database query failed!");
		    }
		} catch (Exception e) {
			 System.out.println("Database coonection faild!");
		    e.printStackTrace();
		} finally {
		    if (preparedStatement != null) {
		        preparedStatement.close();
		    }
		    if (connection != null) {
		        connection.close();
		    }
		}
		
		
		%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<link rel="stylesheet" href="../css/nav.css">
<link rel="stylesheet" href="../css/home.css">
 
 <style>
 .invisible-row.hovered {
    display: table-row;
}n
 
 
 </style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<title>Home page</title>

<script type="text/javascript">
 
 
        const introspectionEndpointUrl = 'https://api.asgardeo.io/t/orguja25/oauth2/introspect';
        const accessToken = localStorage.getItem('access_token');
        const idToken = localStorage.getItem('id_token');
        
        if(accessToken && idToken){
        	
        var settings = {
            "url": "https://api.asgardeo.io/t/orguja25/oauth2/userinfo",
            "method": "GET",
            "timeout": 0,
            "headers": { 
                "Authorization": "Bearer " + accessToken
            },
        };

        $.ajax(settings)
            .done(function (response) {
                console.log(response);
                var username =  response.username;
                var given_name = response.given_name;
                var phone = response.phone_number;
                var email = response.email;
                
                document.getElementById('given_name').textContent = given_name;
                document.getElementById('email').textContent = email;
                document.getElementById('phone').textContent = phone;
                document.getElementById('usernameField').value = username;
                document.getElementById('usernameField2').value = username;
                
                document.getElementById('submit').addEventListener('click', function () {
                    // Set the username as a hidden field value in the form
                    document.getElementById('usernameField2').value = username;
                });
                
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                // Handle any errors here
                console.error('Error:', errorThrown);
                alert("Error in the authorization. Login again!");
                window.location.href = "../login.jsp";
            });
        }
        else{
        	window.location.href = "../login.jsp";	
        }
    </script>


</head>

<body class="home-body"  style="background-color: black;">

<div class="nav-body">
	<nav>
	        <ul>
	            <li><a href="#">Home</a></li>
	            <li><a href="#user-card">User</a></li>
	            <li><a href="#">About</a></li>
	            <li><a href="#">Contact</a></li>
	        </ul>
	 </nav>

</div>
 
 <div class="welcome">
     <h1 style="font-size:60px; margin-top:10px;">Hi...............!!</h1>
     <h2>Welcome to the site</h2>
     <h3>Make your Reservation here</h3>
 
 </div>
 
 <section id="user-card">
                <div class="title">User Information</div>
        <div class="user-box">
           
            <div class="title-total">
                
                <h1>Hello.....</h1>
                <h6 id="given_name"></h6><br><br>
                <div class="desc">
                    <ul>
                        <li style="white-space: nowrap;">Email : <span id="email" style="color: blue; font-weight:700;"></span></li>
                        <li style="white-space: nowrap;">Contact: <span id="phone" style="color: blue; font-weight:700;"></span></li>
                    </ul>
                </div>
                <br><br>
                <div class="actions">
                    <button type="button" onclick="window.location.href='../login.jsp'">Log Out</button>
                </div>
            </div>
        </div>
    </section>
<br><br><br>
 
 <section class="service-section">
    
   <div class="service-box">
      <h1>Make your reservation</h1>
        <form action="home.jsp" method="post">

            <label for="date">Date:</label>
            <input type="date" id="date" name="date" required>

            <label for="time">Time:</label>
            <select id="time" name="time" required>
                <option value="10:00 AM">10:00 AM</option>
                <option value="11:00 AM">11:00 AM</option>
                <option value="12:00 AM">12:00 AM</option>
            </select>

            <label for="location">Location:</label>
            <select id="location" name="location" required>
                            <option selected>Choose...</option>
						    <option value="Colombo">Colombo</option>
				            <option value="Gampaha">Gampaha</option>
				            <option value="Kalutara">Kalutara</option>
				            <option value="Kandy">Kandy</option>
				            <option value="Matale">Matale</option>
				            <option value="Nuwara Eliya">Nuwara Eliya</option>
				            <option value="Galle">Galle</option>
				            <option value="Matara">Matara</option>
				            <option value="Hambantota">Hambantota</option>
				            <option value="Jaffna">Jaffna</option>
				            <option value="Kilinochchi">Kilinochchi</option>
				            <option value="Mannar">Mannar</option>
				            <option value="Vavuniya">Vavuniya</option>
				            <option value="Mullaitivu">Mullaitivu</option>
				            <option value="Batticaloa">Batticaloa</option>
				            <option value="Ampara">Ampara</option>
				            <option value="Trincomalee">Trincomalee</option>
				            <option value="Kurunegala">Kurunegala</option>
				            <option value="Puttalam">Puttalam</option>
				            <option value="Anuradhapura">Anuradhapura</option>
				            <option value="Polonnaruwa">Polonnaruwa</option>
				            <option value="Badulla">Badulla</option>
				            <option value="Monaragala">Monaragala</option>
				            <option value="Ratnapura">Ratnapura</option>
				            <option value="Kegalle">Kegalle</option>
						  </select>
               

            <label for="vehicle_no">Vehicle Registration Number:</label>
            <input type="text" id="vehicle_no" name="vehicle_no" required>

            <label for="mileage">Mileage:</label>
            <input type="number" id="mileage" name="mileage" required>

            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="4"></textarea>
	         <input type="hidden" id="usernameField" name="usernameField" value="" >
	       <div class="sub-bttn" style="display: flex; justify-content: center;">
               <input type="submit" name="submit" id="submit" value="Submit" style="background-color: green; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; text-align: center;">
           </div>
			 
        </form>
 
		

 
 
   </div>
   
 </section>
 
 <br><br><br><br><br>
 
 <div class = "past-reservation"  style="display: flex; justify-content: center;">
 
   <form class="mb-5" method="post" id="myReservation"   onclick="document.getElementById('reservationsList').style.display='block'" >
		<input type="hidden" id="usernameField2" name="usernameField2" value="" >
		<input type="submit" class="res" id="pastRes" name= "pastRes" value="Past Reservation" style="background-color:	#1434A4; color: white; border: none; padding: 12px 30px; border-radius: 5px; cursor: pointer; text-align: center; font-size:20px;">
	</form>
 
 </div>
 
  
 
 
 <% if (request.getParameter("pastRes") != null) { %>
<div class="past-reservationsList" id="pastReservationsList" style="display: block;">

 <table>
    <tr>
        <th>Date</th>
        <th>Time</th>
        <th>Location</th>
        <th>Registration</th>
        <th>Mileage</th>
        <th>Message</th>
    </tr>
    
    <%
    try {
        connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        String selectQuery = "SELECT * FROM vehicle_service WHERE username = ? AND date < CURDATE()";
        PreparedStatement preparedStatement1 = connection.prepareStatement(selectQuery);
        preparedStatement1.setString(1, request.getParameter("usernameField2"));

        ResultSet resultSet = preparedStatement1.executeQuery();

        while (resultSet.next()) {
            String date = resultSet.getString("date");
            String time = resultSet.getString("time");
            String location = resultSet.getString("location");
            String vehicle_no = resultSet.getString("vehicle_no");
            String mileage = resultSet.getString("mileage");
            String message = resultSet.getString("message");

            %>
            <tr class="invisible-row" onmouseover="this.classList.add('hovered')" onmouseout="this.classList.remove('hovered')">
                <td><%= date %></td>
                <td><%= time %></td>
                <td><%= location %></td>
                <td><%= vehicle_no %></td>
                <td><%= mileage %></td>
                <td><%= message %></td>
            </tr>
            <%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (connection != null) {
            connection.close();
        }
    }
    %>
   
  
</table>

</div>
 
 <% } %>
 
 <br><br><br>
 
 <div class="future-reservation" style="display: flex; justify-content: center;">

    <form class="mb-5" method="post" id="myFutureReservation" onclick="document.getElementById('futureReservationsList').style.display='block'">
        <input type="hidden" id="usernameField2" name="usernameField2" value="">
        <input type="submit" class="res" id="futureRes" name="futureRes" value="Future Reservation" style="background-color: #1434A4; color: white; border: none; padding: 12px 30px; border-radius: 5px; cursor: pointer; text-align: center; font-size: 20px;">
    </form>

</div>

<% if (request.getParameter("futureRes") != null) { %>
<div class="future-reservationsList" id="futureReservationsList" style="display:block;">

    <table>
        <tr>
            <th>Date</th>
            <th>Time</th>
            <th>Location</th>
            <th>Registration</th>
            <th>Mileage</th>
            <th>Message</th>
            <th>Delete</th>
        </tr>

        <%
        try {
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            String selectQuery = "SELECT * FROM vehicle_service WHERE username = ?AND date > CURDATE()";
            PreparedStatement preparedStatement1 = connection.prepareStatement(selectQuery);
            preparedStatement1.setString(1, request.getParameter("usernameField2"));

            ResultSet resultSet = preparedStatement1.executeQuery();

            while (resultSet.next()) {
            	String booking_id = resultSet.getString("booking_id");
                String date = resultSet.getString("date");
                String time = resultSet.getString("time");
                String location = resultSet.getString("location");
                String vehicle_no = resultSet.getString("vehicle_no");
                String mileage = resultSet.getString("mileage");
                String message = resultSet.getString("message");

                %>
                <tr>
                    <td><%= date %></td>
                    <td><%= time %></td>
                    <td><%= location %></td>
                    <td><%= vehicle_no %></td>
                    <td><%= mileage %></td>
                    <td><%= message %></td>
                     <td>
                <form method="post" action="delete_reservation.jsp">
                    <input type="hidden" name="deleteID" value="<%= booking_id %>">
                    <input type="submit" name="delete" value="Delete" style="background-color:red;">
                </form>
            </td>
                </tr>
                <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
        %>

    </table>

</div>
<% } %>
 
</body>
</html>

