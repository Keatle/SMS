<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="training.aspx.cs" Inherits="BlossomsWeb.training" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

          <div style="width: 100%; margin: auto;padding:30px">
    <div id:"training">
    <h2>Training</h2>
               <br />
        </div>
        <div style="display: flex; align-items: center; width:60%; justify-content: space-between;">
    <div style="font-size:18px">
        <asp:Label ID="lblSociety" runat="server" Text="Society name:" CssClass="label"></asp:Label> <br />
    </div>
       <div style="width:40%">
        <asp:Button ID="btnProgress" runat="server" CssClass="btn btn-primary" Text="In Progress" OnClientClick="btnProgress_Click" />
                   <asp:Button ID="btnComplete" runat="server" CssClass="btn btn-primary" Text="Complete" OnClientClick="btnComplete_Click" />
                   <asp:Button ID="btnCancelled" runat="server" CssClass="btn btn-primary" Text="Cancelled" OnClientClick="btnCancel_Click" />

    </div>
</div>    
              </div>
        <hr />
</asp:Content>
