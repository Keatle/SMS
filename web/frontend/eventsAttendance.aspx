<%@ Page Title="" Language="C#" MasterPageFile="~/secretary.Master" AutoEventWireup="true" CodeBehind="eventsAttendance.aspx.cs" Inherits="BlossomsWeb.eventsAttendance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div style="padding:30px">

            <h2>Attendance</h2>
               <div style="display: flex; align-items: center; width:60%; justify-content: space-between;">
        <form id="Form1">
            <%--<label for="eventName">Event Name:</label>
            <asp:TextBox ID="txteventName" runat="server" CssClass="form-control" placeholder="Enter Event Name" required></asp:TextBox><br />

            <label for="eventDate">Meeting Date:</label>
            <asp:TextBox ID="txtmeetingDate" runat="server" CssClass="form-control" placeholder="Enter Event Date" required></asp:TextBox><br />

            <label for="eventTime">Meeting Time:</label>
            <asp:TextBox ID="txtmeetingTime" runat="server" CssClass="form-control" placeholder="Enter Event Time" required></asp:TextBox><br />

            <label for="venue">Venue:</label>
            <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control" placeholder="Enter Venue" required></asp:TextBox><br />--%>

    <div>
    <label for="code">Attendance code:</label>
    <asp:TextBox ID="txtCode" runat="server" CssClass="form-control" placeholder=" " required></asp:TextBox><br />
</div>
<div>
    <label for="count">Number of times entered:</label>
    <asp:TextBox ID="txtCount" runat="server" CssClass="form-control" placeholder=" " ReadOnly="true"></asp:TextBox><br />
</div>
<div style="width:40%">
    <asp:Button ID="btnGenerate" runat="server" Text="Generate" CssClass="btn btn-primary" OnClientClick="generateCode();" />
</div>

<script>
    let count = 0; // Initialize count variable

    function generateRandomCode(length) {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let code = '';
        for (let i = 0; i < length; i++) {
            const randomIndex = Math.floor(Math.random() * characters.length);
            code += characters.charAt(randomIndex);
        }
        return code;
    }

    function generateCode() {
        const randomCode = generateRandomCode(6);
        document.getElementById("<%= txtCode.ClientID %>").value = randomCode;
        
        // Increment count and update the textbox
        count++;
        document.getElementById("<%= txtCount.ClientID %>").value = count;
    }
</script>


</asp:Content>
