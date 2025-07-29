<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="executive.aspx.cs" Inherits="BlossomsWeb.executive" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div style="width: 80%; margin: auto;">
    <div id:"executive">
 <h2>Executive Members</h2>
               <br />
        </div>
        <div style="display: flex; align-items: center; width:60%; justify-content: space-between;">
    <div style="font-size:18px">
        <asp:Label ID="lblSociety" runat="server" Text="Society name:" CssClass="label"></asp:Label> <br />
    </div>
       <div style="width:40%">
        <asp:Button ID="btnMembers" runat="server" CssClass="btn btn-primary" Text="View Members" OnClientClick="openForm('executiveForm');" />
    </div>
</div>        
        <hr />

    <div class="form-popup" id="executiveForm" style="display:none;">
  <form class="form-container">
   <div style="width:40%">
       <asp:DropDownList ID="memberMenu" runat="server" CssClass="btn btn-outline-primary theme-button">
    <asp:ListItem Text="Chairperson" Value="1"></asp:ListItem>
    <asp:ListItem Text="Treasurer" Value="2"></asp:ListItem>
    <asp:ListItem Text="Secretary" Value="3"></asp:ListItem>
</asp:DropDownList>
       <hr />
           <asp:TextBox ID="txtSocietyMember" runat="server" CssClass="form-control" placeholder="Member Name" Required="true"></asp:TextBox><br />

        <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary" Text="Add Member" OnClientClick="btnAdd_Click" />
                   <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update Member" OnClientClick="btnUpdate_Click" />
                   <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary" Text="Delete" OnClientClick="btnDelete_Click" />
    <button type="button" class="btn cancel" onclick="closeForm('executiveForm')">Close</button>

    </div>
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
