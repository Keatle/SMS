<%@ Page Title="" Language="C#" MasterPageFile="~/secretary.Master" CodeBehind="minutes.aspx.cs" Inherits="BlossomsWeb.minutes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <h2>Meeting Minutes</h2>
     <div style="margin: auto;padding: 30px">
        <form id="Form1">
            <label for="meetingTitle">Meeting Title:</label>
            <asp:TextBox ID="txtmeetingName" runat="server" CssClass="form-control" placeholder="Enter meeting Name" required></asp:TextBox><br />

            <label for="meetingDate">Meeting Date:</label>
            <asp:TextBox ID="txtmeetingDate" runat="server" CssClass="form-control" placeholder="Enter meeting Date" required></asp:TextBox><br />

            <label for="meetingTime">Meeting Time:</label>
            <asp:TextBox ID="txtmeetingTime" runat="server" CssClass="form-control" placeholder="Enter meeting Time" required></asp:TextBox><br />

            <label for="venue">Venue:</label>
            <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control" placeholder="Enter Venue" required></asp:TextBox><br />

            <label for="guest">Minutes:</label>
            <asp:TextBox ID="txtMinutes" runat="server" TextMode="MultiLine" Rows="10"  CssClass="form-control" placeholder="Enter Minutes" required></asp:TextBox><br />

            <div style="display: flex; justify-content: space-between;">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click"/>
            </div>
        </form>
           </div>
</asp:Content>
