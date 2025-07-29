<%@ Page Title="" Language="C#" MasterPageFile="~/treasurer.Master" AutoEventWireup="true" CodeBehind="statement.aspx.cs" Inherits="BlossomsWeb.statement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <h2>Statement</h2>

<section class="w3l-content-w-photo-6">
	<!-- /specification-6-->
	  <div class="content-photo-6-mian py-5">
			 <div class="container py-lg-5">
					<div class="align-photo-6-inf-cols row">
						
						<div class="photo-6-inf-right col-lg-6">
								<h3 class="hny-title mb-0 text-center">View <span>Statement</span> </h3>
					

    
    <form id="categoryForm" action="#">
        <label for="category">Select Category:</label>
        <select id="category" name="category">
            <option value="date">Date</option>
            <option value="type">Type</option>
            <option value="amount">Amount</option>
        </select>
        <button type="submit">View Statement</button>
		 <button type="submit">Download Statement</button>
    </form>

    <div id="statementDisplay">
        <!-- Statement will be displayed here -->
    </div>

    <script>
        document.getElementById('categoryForm').addEventListener('submit', function(event) {
            event.preventDefault();
            var category = document.getElementById('category').value;
            // Here you would fetch the statement data based on the selected category
            // For demonstration purposes, let's assume we have the statement data in a variable
            var statementData = [
                { ID: '1', Name: 'Event 1', Description: 'Description 1', Date: 'January 1, 2022', Type: 'Campaign', 'Amount Requested': 'R1000', 'Amount Allocated': 'R800', 'Funds Raised': 'R600', 'Date Updated': '' },
                { ID: '2', Name: 'Event 2', Description: 'Description 2', Date: 'February 15, 2022', Type: 'Shirts', 'Amount Requested': 'R1500', 'Amount Allocated': 'R1200', 'Funds Raised': 'R900', 'Date Updated': 'May 3, 2022' }
            ];
            displayStatement(statementData);
        });

        function displayStatement(data) {
            var statementDisplay = document.getElementById('statementDisplay');
            statementDisplay.innerHTML = ''; // Clear previous content
            var table = document.createElement('table');
            table.border = '1';
            table.cellSpacing = '0';
            table.cellPadding = '8';
            table.width = '100%';

            var thead = document.createElement('thead');
            var tbody = document.createElement('tbody');

            // Create table header
            var headerRow = document.createElement('tr');
            for (var key in data[0]) {
                var th = document.createElement('th');
                th.textContent = key;
                headerRow.appendChild(th);
            }
            thead.appendChild(headerRow);

            // Create table body
            data.forEach(function(item) {
                var row = document.createElement('tr');
                for (var key in item) {
                    var cell = document.createElement('td');
                    cell.textContent = item[key];
                    row.appendChild(cell);
                }
                tbody.appendChild(row);
            });

            table.appendChild(thead);
            table.appendChild(tbody);
            statementDisplay.appendChild(table);
        }
    </script>
						</div>
						
					</div>
				 </div>
			 </div>
	 </section>
   <!-- //specification-6-->
     
								

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

</asp:Content>
