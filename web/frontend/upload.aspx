<%@ Page Title="" Language="C#" MasterPageFile="~/treasurer.Master" AutoEventWireup="true" CodeBehind="upload.aspx.cs" Inherits="BlossomsWeb.upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <h2>Upload Funds</h2>

         
<section>
	<!-- /video-6-->
	<div>
		<div class="container-fluid">				
				  </div>
				<div class="video-gd-left col-lg-4 p-lg-5 p-4">
					<h3 class="hny-title mb-0 text-center">Upload Details For Funds Raised </h3>
						<form action="submit_event_details.php">
        <label for="eventName">Event Name:</label>
        <input type="text" id="eventName" name="eventName" required><br><br>

        <label for="eventDate">Event Date:</label>
        <input type="date" id="eventDate" name="eventDate" required><br><br>

        <label for="eventType">Event Type:</label>
        <select id="eventType" name="eventType" required>
            <option value="Conference">Conference</option>
            <option value="Seminar">Seminar</option>
            <option value="Workshop">Workshop</option>
            <option value="Webinar">Webinar</option>
            <option value="Other">Other</option>
        </select><br><br>

        <label for="eventDescription">Event Description:</label><br>
        <textarea id="eventDescription" name="eventDescription" rows="4" cols="50" required></textarea><br><br>
		
		<label for="proofOfPayment">Proof of Payment:</label>
        <input type="file" id="proofOfPayment" name="proofOfPayment" accept="image/*" required><br><br>


        <label for="amountRaised">Amount Raised:</label>
        <input type="number" id="amountRaised" name="amountRaised" min="0" required><br><br>

        <input type="submit" value="Submit">
    </form>
					</div>

	</div>
</section>
<!-- //video-6-->
<section class="w3l-ecommerce-main">
	<!-- /products-->
	<div class="ecom-contenthny py-5">
		<div class="container py-lg-5">
			<h3 class="hny-title mb-0 text-center">Uploaded Funds <span>Raised</span></h3>
			<p class="text-center">All Uploaded Details</p>
			<!-- /row-->
			<div class="ecom-products-grids row mt-lg-5 mt-3">
				<div class="col-lg-3 col-6 product-incfhny mt-4">
					    <div class="product-grid2 transmitv">
        <div class="product-image2">
            <a href="#">
                <!-- Display event image -->
                <img class="pic-1 img-fluid" src="event_image.jpg">
                <img class="pic-2 img-fluid" src="event_image.jpg">
            </a>
            <ul class="social">
                <!-- Add social icons or links here -->
                <li><a href="#" data-tip="Quick View"><span class="fa fa-eye"></span></a></li>
                <!-- Optionally, add more social icons or links -->
            </ul>
        </div>
        <div class="product-content">
            <!-- Display event name as title -->
            <h3 class="title"><a href="#">Event Name</a></h3>
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
             
                <span class="detail-value">Amount Raised</span>
            </div>
        </div>
    </div>

				</div>
				<div class="col-lg-3 col-6 product-incfhny mt-4">
					    <div class="product-grid2 transmitv">
        <div class="product-image2">
            <a href="#">
                <!-- Display event image -->
                <img class="pic-1 img-fluid" src="event_image.jpg">
                <img class="pic-2 img-fluid" src="event_image.jpg">
            </a>
            <ul class="social">
                <!-- Add social icons or links here -->
                <li><a href="#" data-tip="Quick View"><span class="fa fa-eye"></span></a></li>
                <!-- Optionally, add more social icons or links -->
            </ul>
        </div>
        <div class="product-content">
            <!-- Display event name as title -->
            <h3 class="title"><a href="#">Event Name</a></h3>
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
             
                <span class="detail-value">Amount Raised</span>
            </div>
        </div>
    </div>

				</div>
				<div class="col-lg-3 col-6 product-incfhny mt-4">
					    <div class="product-grid2 transmitv">
        <div class="product-image2">
            <a href="#">
                <!-- Display event image -->
                <img class="pic-1 img-fluid" src="event_image.jpg">
                <img class="pic-2 img-fluid" src="event_image.jpg">
            </a>
            <ul class="social">
                <!-- Add social icons or links here -->
                <li><a href="#" data-tip="Quick View"><span class="fa fa-eye"></span></a></li>
                <!-- Optionally, add more social icons or links -->
            </ul>
        </div>
        <div class="product-content">
            <!-- Display event name as title -->
            <h3 class="title"><a href="#">Event Name</a></h3>
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
             
                <span class="detail-value">Amount Raised</span>
            </div>
        </div>
    </div>

				</div>
				<div class="col-lg-3 col-6 product-incfhny mt-4">
					    <div class="product-grid2 transmitv">
        <div class="product-image2">
            <a href="#">
                <!-- Display event image -->
                <img class="pic-1 img-fluid" src="event_image.jpg">
                <img class="pic-2 img-fluid" src="event_image.jpg">
            </a>
            <ul class="social">
                <!-- Add social icons or links here -->
                <li><a href="#" data-tip="Quick View"><span class="fa fa-eye"></span></a></li>
                <!-- Optionally, add more social icons or links -->
            </ul>
        </div>
        <div class="product-content">
            <!-- Display event name as title -->
            <h3 class="title"><a href="#">Event Name</a></h3>
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
             
                <span class="detail-value">Amount Raised</span>
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

</asp:Content>
