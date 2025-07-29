<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="events.aspx.cs" Inherits="BlossomsWeb.events" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div style="padding:30px">
     <h2>Current Events</h2>
    <div style="display: flex; align-items: center; width:100%; justify-content: space-between;">
        <div>
    <label for="code">Enter Code:</label>
    <asp:TextBox ID="txtCode" runat="server" CssClass="form-control" placeholder="" ></asp:TextBox><br />
</div>
<div style="width:40%">
    <asp:Button ID="btnEnterCode" runat="server" CssClass="btn btn-primary"  Text="Enter Code" OnClick="btnEnterCode_Click" />
</div>
    </div>
    <br />

 <h2>Upcoming Events</h2>
        <br />
    <div id="upcoming" style="padding: 20px;">
       
<div style="width: 100%; display: flex;">
    <div style="width: 70%;">
        <h2 style="display: inline-block; margin-right: 20px;">Event Name</h2>
            <p style="display: inline-block;">Society</p>
        <p>Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description</p>
        <div style="width: 100%; display: flex;">
            <div style="width: 50%;">
                Date & time
            </div>
            <div style="width: 50%;">
                Location
            </div>
        </div>
    </div>
    <div style="width: 30%;">
        <center>
            <h2>Event Type</h2>
            <br />
            <asp:Button ID="btnRSVP" runat="server" Text="RSVP" CssClass="btn btn-outline-primary theme-button" OnClick="btnRSVP_Click" />
        </center>
    </div>
</div>

</div>

<h2>Previous Events</h2>
               <br />
<div id="previous" style="background-color: #dcdcdc; padding: 20px;">
    <div style="width: 100%; display: flex;">
        <div style="width: 70%;">
            <h2 style="display: inline-block; margin-right: 20px;">Event Name</h2>
            <p style="display: inline-block;">Society</p>
            <p>Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description</p>
            <div style="width: 100%; display: flex;">
                <div style="width: 50%;">
                    Date & time
                </div>
                <div style="width: 50%;">
                    Location
                </div>
            </div>
        </div>
        <div style="width: 30%;">
            <center>
                <h2>Event Type</h2>         
            </center>
        </div>
    </div>
    <hr/>
    <div id="previousEvents"> 
    </div>
</div>


</div>

</asp:Content>
