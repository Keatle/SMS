<%@ Page Title="" Language="C#" MasterPageFile="~/chairperson.Master" AutoEventWireup="true" CodeBehind="chairNotifications.aspx.cs" Inherits="BlossomsWeb.chairNotifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div style="width: 80%; margin: auto;">
    <div id:"notifications">
    <h2>Notifications</h2>
               <br />
        </div>
        <div style="display: flex; align-items: center; width:60%; justify-content: space-between;">
    <div style="font-size:18px">
        <asp:Label ID="lblNotification" runat="server" Text="Society name:" CssClass="label"></asp:Label> <br />
    </div>
       <div style="width:40%">
        <asp:Button ID="btnNotification" runat="server" CssClass="btn btn-primary" Text="View Notification" OnClientClick="openForm('notificationForm');" />
    </div>
</div>        
        <hr />

    <div class="form-popup" id="notificationForm" style="display:none;">
  <form class="form-container">
    <asp:TextBox ID="txtSociety" runat="server" CssClass="form-control" placeholder="Society Name" Required="true"></asp:TextBox><br />
    <asp:TextBox ID="txtContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder=" " Required="true"></asp:TextBox>
    <button type="button" class="btn cancel" onclick="closeForm('notificationForm')">Close</button>
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
