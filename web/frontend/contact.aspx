<%@ Page Title="" Language="C#" MasterPageFile="~/main.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="BlossomsWeb.contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <body>

<!-- breadcrum -->
<section class="w3l-skill-breadcrum">
  <div class="breadcrum">
    <div class="container">
      <p><a href="home.aspx">Home</a> &nbsp; / &nbsp; Contact</p>
    </div>
  </div>
</section>
<!-- //breadcrum -->
<!-- contact form -->
<section class="w3l-contacts-12" id="contact">
	<div class="container py-5">
		<div class="contacts12-main py-md-3">
			<div class="header-section text-center">
				<h3 class="mb-md-5 mb-4">Fill out the form.
			</div>
			<form action="https://sendmail.w3layouts.com/submitForm" method="post" class="">
				<div class="main-input">
					<input type="text" name="w3lName" placeholder="Enter your name" class="contact-input" required="" />
					<input type="email" name="w3lSender" placeholder="Enter your mail" class="contact-input" required="" />
					<input type="email" name="w3lSubject" placeholder="Subject" class="contact-input" />
					<textarea class="contact-textarea contact-input" name="w3lMessage" placeholder="Enter your message" required=""></textarea>
				</div>
				<div class="text-right">
					<button class="btn-secondary btn theme-button">Send</button>
				</div>
			</form>
		</div>
	</div>
	<div class="contant11-top-bg py-5">
		<div class="container py-lg-3">
			<div class="d-grid contact section-gap">
				<div class="contact-info-left d-grid">
					<div class="contact-info">
						<div class="icon">
							<span class="fa fa-location-arrow" aria-hidden="true"></span>
						</div>
						<div class="contact-details">
							<h4>Address:</h4>
							<p>Kingsway Campus, Auckland Park Auckland Park 2092 </p>
						</div>
					</div>
					<div class="contact-info">
						<div class="icon">
							<span class="fa fa-phone" aria-hidden="true"></span>
						</div>
						<div class="contact-details">
							<h4>Phone:</h4>
							<p><a href="tel: 011 559 4555"> 011 559 4555</a></p>
							<p><a href="tel: 011 559 4555"> 011 559 4555</a></p>
						</div>
					</div>
					<div class="contact-info">
						<div class="icon">
							<span class="fa fa-envelope-open-o" aria-hidden="true"></span>
						</div>
						<div class="contact-details">
							<h4>Mail:</h4>
							<p><a href="mailto:mail@example.com" class="email">mylife@uj.ac.za</a></p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</section>
<!-- //contact form -->
   <!-- footer -->
    <footer class="w3l-footer-29-main" id="footer">
     <div class="footer-29 py-5">
       <div class="container pb-lg-3">
         <div class="row footer-top-29">
           <div class="col-lg-4 col-md-6 footer-list-29 footer-1 mt-md-4">
            <a class="navbar-brand" href="home.aspx"><img src="assets/images/logo-icon.png" alt="" style="width: 100px; height: auto;" />Society Management</a>
             <p>"Empower, Engage, Excel" encapsulates the essence of society life, where members are empowered to pursue their passions, engage in meaningful activities, and excel in personal and professional growth.</p>
           </div>
           <div class="col-lg-2 col-md-6 footer-list-29 footer-2 mt-5">
            <h6 class="footer-title-29">Explore More</h6>
             <ul>
               <li><a href="#gallery.aspx">Gallery</a></li>
             </ul>
           </div>
          
           <div class="col-lg-2 col-md-6 footer-list-29 footer-4 mt-5">
            <h6 class="footer-title-29">Quick Links</h6>
             <ul>
               <li><a href="home.aspx">Home</a></li>
               <li><a href="about.aspx">About</a></li>
               <li><a href="services.aspx">Services</a></li>
               <li><a href="#blog.aspx"> Blog</a></li>
               <li><a href="contact.aspx">Contact</a></li>
             </ul>
           </div>
         </div>
       </div>
     </div>
     <div id="footers14-block" class="py-3">
       <div class="container">
         <div class="footers14-bottom text-center">
           <div class="social">
             <a href="#facebook" class="facebook"><span class="fa fa-facebook" aria-hidden="true"></span></a>
             <a href="#google" class="google"><span class="fa fa-google-plus" aria-hidden="true"></span></a>
             <a href="#twitter" class="twitter"><span class="fa fa-twitter" aria-hidden="true"></span></a>
             <a href="#instagram" class="instagram"><span class="fa fa-instagram" aria-hidden="true"></span></a>
             <a href="#youtube" class="youtube"><span class="fa fa-youtube" aria-hidden="true"></span></a>
           </div>
           <div class="copyright mt-1">
             <p>&copy; 2020 Skill. All Rights Reserved | Design by <a href="https://w3layouts.com/">W3Layouts</a></p>
           </div>
         </div>
       </div>
     </div>

     <!-- move top -->
     <button onclick="topFunction()" id="movetop" title="Go to top">
       <span class="fa fa-angle-up" aria-hidden="true"></span>
     </button>
     <script>
       // When the user scrolls down 20px from the top of the document, show the button
       window.onscroll = function () {
         scrollFunction()
       };

       function scrollFunction() {
         if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
           document.getElementById("movetop").style.display = "block";
         } else {
           document.getElementById("movetop").style.display = "none";
         }
       }

       // When the user clicks on the button, scroll to the top of the document
       function topFunction() {
         document.body.scrollTop = 0;
         document.documentElement.scrollTop = 0;
       }
     </script>
     <!-- /move top -->

   </footer>
   <!-- Footer -->

   <!-- jQuery and Bootstrap JS -->
   <script src="assets/js/jquery-3.3.1.min.js"></script>
   <script src="assets/js/bootstrap.min.js"></script>

   <!-- Template JavaScript -->

   <!-- stats number counter-->
   <script src="assets/js/jquery.waypoints.min.js"></script>
   <script src="assets/js/jquery.countup.js"></script>
   <script>
     $('.counter').countUp();
   </script>
   <!-- //stats number counter -->


   <!-- testimonials owlcarousel -->
   <script src="assets/js/owl.carousel.js"></script>

   <!-- script for owlcarousel -->
   <script>
     $(document).ready(function () {
       $('.owl-one').owlCarousel({
         loop: true,
         margin: 0,
         nav: false,
         responsiveClass: true,
         autoplay: false,
         autoplayTimeout: 5000,
         autoplaySpeed: 1000,
         autoplayHoverPause: false,
         responsive: {
           0: {
             items: 1,
             nav: false
           },
           480: {
             items: 1,
             nav: false
           },
           667: {
             items: 1,
             nav: false
           },
           1000: {
             items: 1,
             nav: false
           }
         }
       })
     })
   </script>
   <!-- //script for owlcarousel -->
   <!-- //testimonials owlcarousel -->

   <!-- script for courses -->
   <script>
     $(document).ready(function () {
       $('.owl-two').owlCarousel({
         loop: true,
         margin: 30,
         nav: false,
         responsiveClass: true,
         autoplay: false,
         autoplayTimeout: 5000,
         autoplaySpeed: 1000,
         autoplayHoverPause: false,
         responsive: {
           0: {
             items: 1,
             nav: false
           },
           480: {
             items: 1,
             nav: false
           },
           667: {
             items: 2,
             nav: false
           },
           1000: {
             items: 3,
             nav: false
           }
         }
       })
     })
   </script>
   <!-- //script for courses -->

   <!-- disable body scroll which navbar is in active -->
   <script>
     $(function () {
       $('.navbar-toggler').click(function () {
         $('body').toggleClass('noscroll');
       })
     });
   </script>
   <!-- disable body scroll which navbar is in active -->

   </body>

</asp:Content>
