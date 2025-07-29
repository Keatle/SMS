<%@ Page Title="" Language="C#" MasterPageFile="~/secretary.Master" AutoEventWireup="true" CodeBehind="transport.aspx.cs" Inherits="BlossomsWeb.transport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <h2>Transport Booking</h2>
    <div style="margin: auto;padding: 30px">
        <form id="Form1">
            <label for="eventName">Event Name:</label>
            <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control" placeholder="Enter Event Name" required></asp:TextBox><br />

            <label for="eventDate">Event Date:</label>
            <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" placeholder="Enter Event Date" required></asp:TextBox><br />

            <label for="eventTime">Event Time:</label>
            <asp:TextBox ID="txtEventTime" runat="server" CssClass="form-control" placeholder="Enter Event Time" required></asp:TextBox><br />

            <label for="venue">Location:</label>
            <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control" placeholder="Enter Venue" required></asp:TextBox><br />

            <label for="guest">Estimated Travel Time:</label>
            <asp:TextBox ID="txtGuest" runat="server" CssClass="form-control" placeholder="Enter Guest" required></asp:TextBox><br />

            <label for="estimatedBudget">Estimated Budget:</label>
            <asp:TextBox ID="txtEstimatedBudget" runat="server" CssClass="form-control" placeholder="Enter Estimated Budget" required></asp:TextBox><br />

            <div style="display: flex; justify-content: space-between;">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click"/>
            </div>
        </form>
</asp:Content>
