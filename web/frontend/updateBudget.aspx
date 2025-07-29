<%@ Page Title="" Language="C#" MasterPageFile="~/treasurer.Master" AutoEventWireup="true" CodeBehind="updateBudget.aspx.cs" Inherits="BlossomsWeb.updateBudget" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <h2>Update Budget</h2>

      <table border="1" cellspacing="0" cellpadding="8" width="100%">
        <thead>
            <tr>
			<th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Date</th>
				<th>Type</th>
                <th>Amount Requested</th>
                <th>Amount Allocated</th>
                <th>Funds Raised</th>
				<th>Date Updated</th>
            </tr>
        </thead>
        <tbody>
            <tr>
			<td>1</td>
                <td>Event 1</td>
                <td>Description 1</td>
                <td>January 1, 2022</td>
				<td>Campaign</td>
                <td>R1000</td>
                <td>R800</td>
                <td>R600</td>
				<td></td>
            </tr>
            <tr>
			<td>2</td>
                <td>Event 2</td>
                <td>Description 2</td>
                <td>February 15, 2022</td>
				<td>Shirts</td>
                <td>R1500</td>
                <td>R1200</td>
                <td>R900</td>
				<td>May 3, 2022</td>
            </tr>
         
        </tbody>
    </table>
<!-- //video-6-->
<section class="w3l-ecommerce-main">
     
<section class="w3l-content-w-photo-6">
	<!-- /specification-6-->
	  <div class="content-photo-6-mian py-5">
			 <div class="container py-lg-5">
					<div class="align-photo-6-inf-cols row">
						
						<div class="photo-6-inf-right col-lg-6">
								<h3 class="hny-title mb-0 text-center">Update <span>Budget</span> </h3>
						<form action="submit_event_details.php" method="POST">
        <label for="eventName">Budget Transaction ID:</label>
        <input type="text" id="eventName" name="eventName" required><br><br>

        <label for="eventDate">Date Edited:</label>
        <input type="date" id="eventDate" name="eventDate" required><br><br>

        <label for="eventType">Type:</label>
        <select id="eventType" name="eventType" required>
		
            <option value="Conference">Conference</option>
            <option value="Seminar">Seminar</option>
            <option value="Workshop">Event</option>
            <option value="Webinar">Webinar</option>
            <option value="Other">Other</option>
        </select><br><br>
 <label for="eventDescription">Description:</label><br>
        <textarea id="eventDescription" name="eventDescription" rows="4" cols="50" required></textarea><br><br>
		
		<label for="proofOfPayment"> Amount Requested:</label>
       <input type="number" id="amountRaised" name="amountRaised" min="0" required><br><br>
	   
		<label for="proofOfPayment"> Amount Allocated:</label>
       <input type="number" id="amountRaised" name="amountRaised" min="0" required><br><br>
	   
	   	<label for="proofOfPayment"> Raised Funds:</label>
       <input type="number" id="amountRaised" name="amountRaised" min="0" required><br><br>

        <input type="submit" value="Submit Update">
    </form>
						</div>
						<div class="photo-6-inf-left col-lg-6">
								<img src="assets/images/g1.jpg" class="img-fluid" alt="">
						</div>
					</div>
				 </div>
			 </div>
	 </section>

</section>
<!-- //products-->
<section class="w3l-content-5">
	<!-- /content-6-section -->
	<div class="content-5-main">
		<div class="container">
			<div class="content-info-in row">
				<div class="content-gd col-md-6 offset-lg-3 text-center">
					
				</div>

			</div>

		</div>
	</div>
</section>
<!-- //content-6-section -->



</asp:Content>
