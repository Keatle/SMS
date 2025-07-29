<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="meetings.aspx.cs" Inherits="BlossomsWeb.meetings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div style="width: 80%; margin: auto;">
    <div id:"meeting">
    <h2>Meeting</h2>
               <br />
        </div>
        <div style="display: flex; align-items: center; width:60%; justify-content: space-between;">
    <div style="font-size:18px">
        <asp:Label ID="lblMeeting" runat="server" Text="Meeting Title:" CssClass="label"></asp:Label> <br />
    </div>
       <div style="width:40%">
        <asp:Button ID="btnMeeting" runat="server" CssClass="btn btn-primary" Text="View Meeting" OnClientClick="openForm('meetingForm');" />
    </div>
</div>        
        <hr />

    <div class="form-popup" id="meetingForm" style="display:none;">
  <form class="form-container">
    <asp:TextBox ID="txtAgenda" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Meeting Agenda" Readonly="true"></asp:TextBox><br />
    <asp:TextBox ID="txtMinutes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="10" placeholder="Meeting Minutes" ></asp:TextBox>
    <button type="button" class="btn btn-primary" onclick="closeForm('meetingForm')">Close</button>
</form>

</div>
            </div>
      <script>
        // Function to open the popup form
        function openForm(formId) {
            document.getElementById(formId).style.display = "block";
        }

        // Function to close the popup form
        function closeForm(formId) {
            document.getElementById(formId).style.display = "none";
        }
      </script>

</asp:Content>
