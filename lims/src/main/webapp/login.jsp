<%@ page import="java.sql.*" errorPage=""%>
<html>
<head>
<title>Apna Life Insurance</title>
</head>
<body bgcolor="#A3A3D1">
	<%!Statement st1, st;%>
	<%!ResultSet rs, rs1;
	String usid;%>

	<% try {
		System.out.println("Inside login.jsp");
		Class.forName("com.mysql.cj.jdbc.Driver");
		System.out.println("Inside login.jsp - got class - ");
		Connection con = DriverManager.getConnection("jdbc:mysql://life-insurance-db.czoolxtyfpit.us-east-1.rds.amazonaws.com/life_insurance_mgmt", "rootuser",
				"rootpassword");
		System.out.println("Inside login.jsp --- got connection - " + con.getMetaData().getURL());
		int userid = Integer.parseInt(request.getParameter("userid").trim());
		usid = request.getParameter("userid").trim();

		String password = request.getParameter("password").trim();
		String type = request.getParameter("type").trim();
		System.out.println("username is:" + userid);
		System.out.println("password is:" + password);
		System.out.println("type is:" + type);
		st = con.createStatement();
		st1 = con.createStatement();
		ResultSet rs = st
				.executeQuery("select * from login where userid=" + userid + " and password='" + password + "'");
		if (rs.next()) {
			System.out.println("inside the login loop");
			rs1 = st1.executeQuery(
					"select type from login where password='" + password + "' and type='" + type + "'");
			if (rs1.next()) {
				if (type.equals("CEO")) {
					response.sendRedirect("./mainceo.htm");
				} else if (type.equals("MANAGER")) {
					response.sendRedirect("./managerall.jsp?mid=" + userid);
				} else if (type.equals("AGENT")) {
					response.sendRedirect("./agentall.jsp?aid=" + userid);
				}
				if (type.equals("CUSTOMER")) {
					response.sendRedirect("./custall.jsp?uid=" + userid);
				}
			}

			else {
				response.sendRedirect("./loginfailed.htm");
			}
		} else {
			response.sendRedirect("./loginfailed.htm");
		}
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	%>

</body>
</html>
