<%@ Page Title="" Language="C#" MasterPageFile="~/chairperson.Master" AutoEventWireup="true" CodeBehind="members.aspx.cs" Inherits="BlossomsWeb.members" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="newMembers" style="padding:30px">
        <h2>New Members</h2>
        <br />
              <div style="display: flex; align-items: center; width:100%; justify-content: space-between;">
    <div>
            <label for="name">Student Name(s):</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" style="width: 500px;" placeholder=" " ReadOnly="true"></asp:TextBox><br />

            <label for="stdNo">Student Number:</label>
            <asp:TextBox ID="txtstdNo" runat="server" CssClass="form-control" style="width: 500px;" placeholder=" " ReadOnly="true"></asp:TextBox><br />

            <label for="email">Emain Address:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" style="width: 500px;" placeholder=" " ReadOnly="true"></asp:TextBox><br />    
    </div>
       <div style="width:40%">
        <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary" Text="Add Member" OnClick="btnAdd_Click" />
    </div>
</div>        
        <hr />
    </div>

    <div id="existingMembers" style="padding:30px">
        <h2>Existing Members</h2>
         <br />
                      <div style="display: flex; align-items: center; width:100%; justify-content: space-between;">
        <div>
            <asp:TextBox ID="eName" runat="server" CssClass="form-control" style="width: 500px;" placeholder="Student Name" ReadOnly="true"></asp:TextBox><br />

            <asp:TextBox ID="eStdNo" runat="server" CssClass="form-control" style="width: 500px;" placeholder="Studen Number" ReadOnly="true"></asp:TextBox><br />

            <asp:TextBox ID="eEmail" runat="server" CssClass="form-control" style="width: 500px;" placeholder="Email Address" ReadOnly="true"></asp:TextBox><br />    
    </div>
          <div style="width:40%">
                 <asp:Button ID="btnRemove" runat="server" CssClass="btn btn-primary" Text="Remove Member" OnClick="btnRemove_Click" />
</div>
    </div>
        </div>

</asp:Content>
