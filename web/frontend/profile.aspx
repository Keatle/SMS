<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="BlossomsWeb.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <body>
    <form id="form1">
        <div class="container">
            <h2>My Profile</h2>
            <asp:Label ID="lblSociety" runat="server" Text="My Societies:"></asp:Label>
            <asp:DropDownList ID="ddlSociety" runat="server" CssClass="form-control" Enabled="false"></asp:DropDownList>
            <asp:Label ID="lblName" runat="server" Text="Full Name:"></asp:Label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:Label ID="lblStdNo" runat="server" Text="Student number:"></asp:Label>
            <asp:TextBox ID="txtStdNo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            <asp:Label ID="lblEmail" runat="server" Text="Email address:"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:Label ID="lblPassword" runat="server" Text="Password:" ></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="********" ReadOnly="true"></asp:TextBox>
            <asp:Label ID="lblConfirmPassword" runat="server" Text="Confirm Password:"></asp:Label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="********" ReadOnly="true"></asp:TextBox>
            <center>
                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary theme-button mt-4" OnClick="btnUpdate_Click" Visible="true" />
            </center>
            <hr />
            <asp:Label ID="lblUpdateSuccessMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
            <asp:Label ID="lblUpdateErrorMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        </div>
    </form>
</body>


</asp:Content>
