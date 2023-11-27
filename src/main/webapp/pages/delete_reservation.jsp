<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.services.jsp.*" %>

<%
if (request.getParameter("delete") != null) {
    String deleteID = request.getParameter("deleteID");

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Establish the connection using the database URL, username, and password
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://172.187.178.153:3306/isec_assessment2", "isec", "EUHHaYAmtzbv");

        // Construct the DELETE query
        String deleteQuery = "DELETE FROM vehicle_service WHERE booking_id = ?";
        preparedStatement = connection.prepareStatement(deleteQuery);
        preparedStatement.setString(1, deleteID);

        // Execute the DELETE query
        preparedStatement.executeUpdate();

        // Redirect back to the page where the deletion was initiated
        response.sendRedirect("home.jsp");
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // Handle any exceptions or errors during deletion
    } finally {
        // Close resources (connection, statement, etc.)
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
