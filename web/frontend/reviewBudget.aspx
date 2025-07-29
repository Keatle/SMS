<%@ Page Title="" Language="C#" MasterPageFile="~/treasurer.Master" AutoEventWireup="true" CodeBehind="reviewBudget.aspx.cs" Inherits="BlossomsWeb.reviewBudget" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>Review Budget</h2>

         
								<h3 class="hny-title mb-0 text-center">Submitted Expense <span>Requestes</span> </h3>

    <table border="1" cellspacing="0" cellpadding="8" width="100%">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Date</th>
                <th>Type</th>
                <th>List of Items needed</th>
                <th>Estimated Amount</th>
                <th>Status</th>
                <th>Action</th>
                <th>Reason for Decline</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Event 1</td>
                <td>Description 1</td>
                <td>January 1, 2022</td>
                <td>Campaign</td>
                <td>Food, drinks, etc</td>
                <td>R800</td>
                <td>Pending</td>
                <td>
                    <button onclick="acceptRequest(1)">Accept</button>
                    <button onclick="declineRequest(1)">Decline</button>
                </td>
                <td>
                    <select id="reason1">
                        <option value="">Select Reason</option>
                        <option value="exceeds">Violates Budget Policies</option>
                        <option value="insufficient">Insufficient Funds</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Event 2</td>
                <td>Description 2</td>
                <td>March 1, 2022</td>
                <td>Campaign</td>
                <td>Tables, etc</td>
                <td>R500</td>
                <td>Pending</td>
                <td>
                    <button onclick="acceptRequest(2)">Accept</button>
                    <button onclick="declineRequest(2)">Decline</button>
                </td>
                <td>
                    <select id="reason2">
                        <option value="">Select Reason</option>
                        <option value="exceeds">Violates Budget Policies</option>
                        <option value="insufficient">Insufficient Funds</option>
                    </select>
                </td>
            </tr>
        </tbody>
    </table>
<p>

</P>
    <script>
        function acceptRequest(id) {
            // Logic to accept the request and update status
            alert('Request ' + id + ' accepted.');
        }

        function declineRequest(id) {
            var reason = document.getElementById('reason' + id).value;
            if (reason) {
                // Logic to decline the request and update status with reason
                alert('Request ' + id + ' declined due to: ' + reason);
            } else {
                alert('Please select a reason for declining the request.');
            }
        }
    </script>
<!-- //video-6-->



<!-- //content-6-section -->






</asp:Content>
