<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="applications.aspx.cs" Inherits="BlossomsWeb.applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="display: flex; width: 100%">
    <div style="width: 18% ; font-size: 20px; padding: 10px">
        <ul>
            <li><a href="#events">Events</a></li>
            <hr />
            <li><a href="#budget">Budget</a></li>
              <hr />
            <li><a href="#societies">Societies</a></li>
              <hr />
        </ul>
    </div>
    <div style="width: 80%">

        <div id="events">
            <h2>Events Application </h2>  
            <br />
        </div>
        <div style="display: flex; align-items: center; width:60%; justify-content: space-between;">
    <div style="font-size:18px">
        <asp:Label ID="lblSocietyName" runat="server" Text="Society name:" CssClass="label"></asp:Label> <br />
        <asp:Label ID="lblEvent" runat="server" Text="Event name:" CssClass="label"></asp:Label>
    </div>
       <div style="width:40%">
        <asp:Button ID="btnEvents" runat="server" class="btn btn-primary" Text="View Event" OnClientClick="openForm('eventsForm');return false;" />
    </div>
</div>        
        <hr />

<div class="form-popup" id="eventsForm" style="display:none;">
    <div style="width: 80%; margin: auto;">
        <form id="Form1">
            <h2>Event Details</h2>
            <label for="eventName">Event Name:</label>
            <asp:TextBox ID="txtEventName" runat="server" CssClass="form-control" placeholder="Enter Event Name" ReadOnly="true"></asp:TextBox><br />

            <label for="eventDate">Event Date:</label>
            <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control" placeholder="Enter Event Date" ReadOnly="true"></asp:TextBox><br />

            <label for="eventTime">Event Time:</label>
            <asp:TextBox ID="txtEventTime" runat="server" CssClass="form-control" placeholder="Enter Event Time" ReadOnly="true"></asp:TextBox><br />

            <label for="venue">Venue:</label>
            <asp:TextBox ID="txtVenue" runat="server" CssClass="form-control" placeholder="Enter Venue" ReadOnly="true"></asp:TextBox><br />

            <label for="guest">Guest:</label>
            <asp:TextBox ID="txtGuest" runat="server" CssClass="form-control" placeholder="Enter Guest" ReadOnly="true"></asp:TextBox><br />

            <label for="estimatedBudget">Estimated Budget:</label>
            <asp:TextBox ID="txtEstimatedBudget" runat="server" CssClass="form-control" placeholder="Enter Estimated Budget" ReadOnly="true"></asp:TextBox><br />

            <div style="display: flex; justify-content: space-between;">
                <asp:Button ID="btnProcess" runat="server" Text="Process" CssClass="btn btn-primary" OnClick="Process_Click" />
                <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="btn btn-danger" OnClick="Reject_Click" />
                <asp:Button ID="btnClose" runat="server" Text="Close" CssClass="btn btn-primary" OnClientClick="closeForm('eventsForm')" />
            </div>
        </form>
    </div>
</div>

        <br />
        <div id="budget">
        <h2>Budget Request </h2>  
            <br />
        </div>
        <div style="display: flex; align-items: center; width:60%; justify-content: space-between;">
    <div style="font-size:18px">
        <asp:Label ID="lblSocietyName2" runat="server" Text="Society name:" CssClass="label"></asp:Label> <br />
    </div>
       <div style="width:40%">
        <asp:Button ID="btnBudget" runat="server" CssClass="btn btn-primary" Text="View Budget" OnClientClick="openForm('budgetForm'); return false;" />
    </div>
</div>        
        <hr />

<div class="form-popup" id="budgetForm" style="display:none;">
    <form class="Form2" >
        <h2>Budget Request</h2>
        <br />
        <asp:TextBox ID="txtBudgetAmount" runat="server" placeholder="Budget Amount" Required="true"></asp:TextBox>
        <asp:LinkButton ID="btnViewBudget" runat="server" CssClass="btn" OnClientClick="return viewBudget()">View Budget</asp:LinkButton>
        <button type="button" class="btn cancel" onclick="closeForm('budgetForm')">Close</button>
    </form>
</div>
        <br />
        <div id="societies">
               <h2>Society Application </h2>  
            <br />
        </div>
        <div style="display: flex; align-items: center; width:60%; justify-content: space-between;">
    <div style="font-size:18px">
        <asp:Label ID="lblSocietyName3" runat="server" Text="Society name:" CssClass="label"></asp:Label> <br />
    </div>
       <div style="width:40%">
        <asp:Button ID="btnSocietiesS" runat="server" CssClass="btn btn-primary" Text="View Society" OnClientClick="openForm('societiesForm');return false;" />
    </div>
</div>        
        
        <br />
<div class="form-popup" id="societiesForm" style="display:none;">
        <div style="width: 80%">
    <form class="Form3" >
    
        <h2>Societies Application</h2>
        <br />

        <div id="Div1" runat="server" style="text-align: left;">
        <table class="table table-bordered">
        <tr>
            <th>Society Name</th>
            <th>Constitution</th>
            <th>Executive List</th>
            <th>Petition List</th>
            <th>Year Plans</th>
            <th>Budget</th>
            <th>Logo</th>
            <th>Proof of Payment</th>
            <th>Action</th>
        </tr>
        <tbody id="gvSubmittedData">
        </tbody>
    </table>
</div>

    </form>
</div>
            </div>
</div>
    </div>
    <script>
        function openForm(formId) {
            document.getElementById(formId).style.display = "block";
        }

        function closeForm(formId) {
            document.getElementById(formId).style.display = "none";
        }
    </script>
</asp:Content>
