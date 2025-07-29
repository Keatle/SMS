<%@ Page Title="" Language="C#" MasterPageFile="~/chairperson.Master" AutoEventWireup="true" CodeBehind="society.aspx.cs" Inherits="BlossomsWeb.society" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <h2>Society Name</h2>
 <br />
    <h4>Depertment</h4>
     <br />
    <p>Description 

        ...

        ...
    </p>
     <br />

    <div>
        <h2>Executive Committee</h2>
        <br />
     
        <div style="display: flex; ">
            <div style="padding: 30px">
                <img src="images/logo-icon.png" alt="Logo" width="100" height="100">
                <h3>Treasurer</h3>
                <p>Full Name</p>
            </div>
          <div style="padding: 30px">
              <img src="images/logo-icon.png" alt="Logo" width="100" height="100">
                <h3>Secretary</h3>
                <p>Full Name</p>
            </div>
          <div style="padding: 30px">
                <img src="images/logo-icon.png" alt="Logo" width="100" height="100">
                <h3>Chairperson</h3>
                <p>Full Name</p>
            </div>
        </div>
           
    </div>
</asp:Content>
