<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="BlossomsWeb.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <link rel="stylesheet" type="text/css" href="css\login.css">

</head>

  <body>
<div class="container">
    <form  runat="server">
    <h2>Login</h2>
    <asp:Panel ID="loginPanel" runat="server">
        <asp:Label ID="lblUsername" runat="server" AssociatedControlID="txtUsername">Student Number</asp:Label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required></asp:TextBox>

        <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword">Password:</asp:Label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" required></asp:TextBox>

        <center>
            <asp:Button ID="btnLogin" runat="server" Text="Log in" CssClass="btn btn-primary theme-button mt-4" OnClick="btnLogin_Click" />
        </center>

        <hr />

        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>

        <hr />

       <%-- <div class="new-signup">
            <a href="#reload" class="signuplink">Forgot username or password?</a>
        </div>--%>
    </asp:Panel>

    <p class="signup">Don’t have an account yet? <a href="register.aspx" class="signuplink">Register now</a></p>
    <p class="signup"><a href="home.aspx" class="signuplink">Return to home</a></p>
</form>

</div>


 </body>
</html>
