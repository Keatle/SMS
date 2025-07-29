<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="BlossomsWeb.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    	
           <link rel="stylesheet" type="text/css" href="css\register.css">

</head>
  <body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Register</h2>
            <label for="society">Select Society:</label>
            <asp:DropDownList ID="society" runat="server" CssClass="form-control" required>
                <asp:ListItem Text="Society 1" Value="S1"></asp:ListItem>
                <asp:ListItem Text="Society 2" Value="S2"></asp:ListItem>
                <asp:ListItem Text="Society 3" Value="S3"></asp:ListItem>
            </asp:DropDownList>
                       <asp:TextBox ID="stdno" runat="server" placeholder="Student number" CssClass="form-control" required autofocus></asp:TextBox>
 <asp:TextBox ID="name" runat="server" placeholder="Full Name" CssClass="form-control" required ></asp:TextBox>
            <asp:TextBox ID="email" runat="server" placeholder="Email address" CssClass="form-control" required></asp:TextBox>
            <asp:TextBox ID="password" runat="server" TextMode="Password" placeholder="Password" CssClass="form-control" required></asp:TextBox>
            <asp:TextBox ID="confirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" CssClass="form-control" required></asp:TextBox>
            <center>
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary theme-button mt-4" OnClick="btnRegister_Click" />
            </center>
             <hr />
                  <asp:Label ID="lblSuccessMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
          <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        <hr />
                <p class="signup">Already have an account? <a href="login.aspx" class="signuplink">Log in now</a></p>
                             <p class="signup"><a href="home.aspx" class="signuplink">Return to home</a></p>

        </div>
    </form>
</body>
</html>
