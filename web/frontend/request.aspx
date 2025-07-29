<%@ Page Title="" Language="C#" MasterPageFile="~/treasurer.Master" AutoEventWireup="true" CodeBehind="request.aspx.cs" Inherits="BlossomsWeb.request" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>Request Funds</h2>

    <section class="w3l-content-w-photo-6">
	<!-- /specification-6-->
	  <div class="content-photo-6-mian py-5">
			 <div class="container py-lg-5">
					<div class="align-photo-6-inf-cols row">
						
						<div class="photo-6-inf-right col-lg-6">
								<h3 class="hny-title mb-0 text-center">Upload Details For <span>Funds Requested</span> </h3>
						<form action="submit_event_details.php" method="POST">
        <label for="eventName">Name of Function:</label>
        <input type="text" id="eventName" name="eventName" required><br><br>

        <label for="eventDate">Date:</label>
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
		
        <label for="eventDescription">List of What is needed:</label><br>
        <textarea id="eventDescription" name="eventDescription" rows="4" cols="50" required></textarea><br><br>
		
		
		<label for="proofOfPayment">Estimate Amount Required:</label>
       <input type="number" id="amountRaised" name="amountRaised" min="0" required><br><br>



        <input type="submit" value="Submit Request">
    </form>
						</div>
						<div class="photo-6-inf-left col-lg-6">
								<img src="assets/images/1.jpg" class="img-fluid" alt="">
						</div>
					</div>
				 </div>
			 </div>
	 </section>
<!-- //video-6-->
<section class="w3l-ecommerce-main">
	<!-- /products-->
	<div class="ecom-contenthny py-5">
		<div class="container py-lg-5">
			<h3 class="hny-title mb-0 text-center">Uploaded Requests <span>Submitted</span></h3>
			
			<!-- /row-->
			<div class="ecom-products-grids row mt-lg-5 mt-3">
				<div class="col-lg-3 col-6 product-incfhny mt-4">
					    <div class="product-grid2 transmitv">
     
        <div class="product-content">
            <!-- Display event name as title -->
            <h3 class="title"><a href="#">Name</a></h3>
            <!-- Display event details such as date, type, description, etc. -->
            <div class="event-details">
              
                <span class="detail-value">Date</span>
            </div>
            <div class="event-details">
              
                <span class="detail-value">Type</span>
            </div>
            <div class="event-details">
                
                <span class="detail-value">Description</span>
            </div>
            <!-- Optionally, display event price or registration details -->
            <div class="event-details">
             
                <span class="detail-value">Amount Requested</span>
            </div>
        </div>
    </div>

				</div>
				<div class="col-lg-3 col-6 product-incfhny mt-4">
					    <div class="product-grid2 transmitv">

        <div class="product-content">
            <!-- Display event name as title -->
            <h3 class="title"><a href="#">Name</a></h3>
            <!-- Display event details such as date, type, description, etc. -->
            <div class="event-details">
              
                <span class="detail-value">Date</span>
            </div>
            <div class="event-details">
              
                <span class="detail-value">Type</span>
            </div>
            <div class="event-details">
                
                <span class="detail-value">Description</span>
            </div>
            <!-- Optionally, display event price or registration details -->
            <div class="event-details">
             
                <span class="detail-value">Amount Requested</span>
            </div>
        </div>
    </div>

				</div>
				<div class="col-lg-3 col-6 product-incfhny mt-4">
					    <div class="product-grid2 transmitv">
       
        <div class="product-content">
            <!-- Display event name as title -->
            <h3 class="title"><a href="#">Name</a></h3>
            <!-- Display event details such as date, type, description, etc. -->
            <div class="event-details">
              
                <span class="detail-value">Date</span>
            </div>
            <div class="event-details">
              
                <span class="detail-value">Type</span>
            </div>
            <div class="event-details">
                
                <span class="detail-value">Description</span>
            </div>
            <!-- Optionally, display event price or registration details -->
            <div class="event-details">
             
                <span class="detail-value">Amount Requested</span>
            </div>
        </div>
    </div>

				</div>
				<div class="col-lg-3 col-6 product-incfhny mt-4">
					    <div class="product-grid2 transmitv">
       
        <div class="product-content">
            <!-- Display event name as title -->
            <h3 class="title"><a href="#">Name</a></h3>
            <!-- Display event details such as date, type, description, etc. -->
            <div class="event-details">
              
                <span class="detail-value">Date</span>
            </div>
            <div class="event-details">
              
                <span class="detail-value">Type</span>
            </div>
            <div class="event-details">
                
                <span class="detail-value">Description</span>
            </div>
            <!-- Optionally, display event price or registration details -->
            <div class="event-details">
             
                <span class="detail-value">Amount Requested</span>
            </div>
        </div>
    </div>

				</div>

			</div>
			<!-- //row-->
		</div>
	</div>
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
