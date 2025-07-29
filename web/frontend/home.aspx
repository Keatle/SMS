<%@ Page Title="" Language="C#" MasterPageFile="~/main.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="BlossomsWeb.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">    

  <body>
 <!--  Main banner section -->
 <section class="w3l-main-banner">
   <div class="companies20-content">
     <div class="companies-wrapper">
       <div class="container">
         <div class="banner-item">
           <div class="banner-view">
             <div class="banner-info">
               <h3 class="banner-text">
                 Empowering Communities and <br> Cultivating Growth.
               </h3>
               <p class="my-4 mb-sm-5">Aiming to enhance the efficiency and effectiveness of managing university societies and foster a vibrant and engaged campus community.
               </p><br>
<a href="societies.aspx#what-is-society" class="btn btn-primary theme-button mr-3">What is a Society?</a>
<a href="societies.aspx#registered-societies" class="btn btn-outline-primary theme-button">Already registered Societies.</a>

             </div>
           </div>
         </div>
       </div>
     </div>
   </div>
 </section>
 <!--  //Main banner section -->
<section class="w3l-index5" id="about">
  <div class="new-block py-5">
    <div class="container py-lg-3">
      <div class="header-section text-center">
        <h3>Why be part of a Society?</h3>
        <p class="mt-3 mb-5">Joining a university society goes beyond academics, offering a sense of community, personal growth, and valuable experiences. It's a platform to connect with like-minded peers, develop skills, and create lasting memories that enrich your university journey.</p>
        <a href="signup.aspx" class="btn btn-primary theme-button">Register your Society</a>
      </div>
      <div class="list-single-view mt-5">
        <div class="row">
          <div class="col-md-12 mt-3">
            <div class="grids5-info">
              <a href="#url" class="d-block zoom"><img src="assets/images/p1.jpg" alt="" class="img-fluid news-image" /></a>
              <div class="blog-info">
                <p class="date"></p>
                <h4>What to submit</h4>
                <p class="blog-text">Societies are required to submit several documents for registration, including the constitution of the society, executive list, petition with names and signatures, year plan, budget, logo, and membership fee.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="list-single-view mt-3">
        <div class="row">
          <div class="col-md-12 mt-3">
            <div class="grids5-info">
              <a href="#url" class="d-block zoom"><img src="assets/images/p2.jpg" alt="" class="img-fluid news-image" /></a>
              <div class="blog-info">
                <p class="date"></p>
                <h4>Existing Societies</h4>
                <p class="blog-text">Existing Societies are required to submit their 2024 anual report before they can be allowed to re-register.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="list-single-view mt-3">
        <div class="row">
          <div class="col-md-12 mt-3">
            <div class="grids5-info">
              <a href="#url" class="d-block zoom"><img src="assets/images/p3.jpg" alt="" class="img-fluid news-image" /></a>
              <div class="blog-info">
                <p class="date"></p>
                <h4>Restrictions</h4>
                <p class="blog-text">When registering a society, certain restrictions may apply. These can include adhering to university policies and guidelines, ensuring the society's activities align with the institution's values and mission, maintaining transparency in financial matters, and obtaining necessary approvals or endorsements from relevant authorities within the university. Additionally, societies may need to demonstrate a viable and sustainable plan for their activities, adhere to legal and ethical standards, and uphold inclusivity and diversity principles within their membership and activities.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
     
    </div>
  </div>
</section>
<!-- stats -->
<section class="w3l-stats py-lg-5 py-4" id="stats">
  <div class="gallery-inner container py-md-5 py-4">
    <div class="row stats-con text-white">
      <div class="col-md-3 col-6 stats_info counter_grid">
        <span class="fa fa-smile-o"></span>
        <p class="counter">196</p>
        <h4>Registered Societies</h4>
      </div>
      <div class="col-md-3 col-6 stats_info counter_grid1">
        <span class="fa fa-graduation-cap"></span>
        <p class="counter">96</p>
        <h4>Eevents Hosted</h4>
      </div>
      <div class="col-md-3 col-6 stats_info counter_grid mt-md-0 mt-5">
        <span class="fa fa-history"></span>
        <p class="counter">25</p>
        <h4>Banned Societies</h4>
      </div>
      <div class="col-md-3 col-6 stats_info counter_grid2 mt-md-0 mt-5">
        <span class="fa fa-users"></span>
        <p class="counter">890</p>
        <h4>Students joined</h4>
      </div>
    </div>
  </div>
</section>
<!-- //stats -->
<section class="w3l-index-block4">
  <div class="feature-16-main py-5">
    <div class="container py-lg-3">
      <div class="header-section text-center">
        <h3>Our Features</h3>
       
      </div>
      <div class="features-grids">
        <div class="row">
          <div class="col-md-6">
            <div class="feature-16-gd">
              <div class="icon">
                <img src="assets/images/seminors.png" class="img-fluid" alt="" />
              </div>
              <div class="feature-16-gd-info">
                <h4 class="mt-4 mb-2">Online Registration Portal:</h4>
                <p> A user-friendly platform for seamless registration and management of society memberships and activities.</p>
                <ul>
				
                  <li>User-friendly interface accessible to students and society leaders.</li>
                  <li>Simplified registration process with clear instructions and form fields.</li>
                  <li>Customizable registration forms based on society requirements.</li>
                  <li>Secure login and profile management for registered members.</li>
                </ul>
                <a href="services.aspx" class="btn btn-primary theme-button mt-4">Learn more</a>
              </div>
            </div>
          </div>
          <div class="col-md-6 mt-md-0 mt-4">
            <div class="feature-16-gd">
              <div class="icon">
                <img src="assets/images/course.png" class="img-fluid" alt="" />
              </div>
              <div class="feature-16-gd-info">
                <h4 class="mt-4 mb-2">Automated Processing:</h4>
                <p>Streamlining administrative tasks such as registration approvals, updates, and data management, saving time and reducing manual errors.</p>
                <ul>
				
                  <li>Automated approval workflows for registration submissions.</li>
                  <li>Real-time updates and notifications for status changes.</li>
                  <li>Data validation to ensure accuracy and completeness of submissions.</li>
                  <li>Historical tracking of registration activities for audit purposes.</li>
                </ul>
                <a href="services.aspx" class="btn btn-primary theme-button mt-4">Learn more</a>
              </div>
            </div>
          </div>
          <div class="col-md-6 mt-4">
            <div class="feature-16-gd">
              <div class="icon">
                <img src="assets/images/library.png" class="img-fluid" alt="" />
              </div>
              <div class="feature-16-gd-info">
                <h4 class="mt-4 mb-2">Budget Management:</h4>
                <p>Providing tools for societies to manage finances, track expenses, and plan budgets for events and initiatives.</p>
                <ul>
				
				
                  <li>Comprehensive budgeting tools for planning income and expenses.</li>
                  <li>Categorization of expenses by event, activity, or project.</li>
                  <li>Reporting features for financial transparency and accountability.</li>
                  <li>Budget tracking and monitoring to stay within financial limits.</li>
                </ul>
                <a href="services.aspx" class="btn btn-primary theme-button mt-4">Learn more</a>
              </div>
            </div>
          </div>
          <div class="col-md-6 mt-4">
            <div class="feature-16-gd">
              <div class="icon">
                <img src="assets/images/teacher.png" class="img-fluid" alt="" />
              </div>
              <div class="feature-16-gd-info">
                <h4 class="mt-4 mb-2">Event Coordination:</h4>
                <p>Facilitating the planning, promotion, and management of events, including scheduling, ticketing, attendee management, and feedback collection</p>
                <ul>
				
				
                  <li>Event scheduling with customizable dates, times, and locations.</li>
                  <li>Promotion tools such as event listings, social media integration, and email campaigns.</li>
                  <li>Ticketing and registration management for attendees.</li>
                  <li>Check-in and attendance tracking during events.</li>
                </ul>
                <a href="services.aspx" class="btn btn-primary theme-button mt-4">Learn more</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section> 
<!-- //subscribe -->
<section class="w3l-get-started">
  <div class="new-block top-bottom">
    <div class="container">
      <div class="middle-section">
        <div class="section-width">
          <h2>Unleashing Potential, Inspiring Community</h2>
        </div>
        <div class="link-list-menu">
            <p class="mb-5">Our website is a one-stop platform for managing university societies, offering streamlined registration, automated processing, clear communication, event tracking, budget management, engagement initiatives, and feedback collection. It simplifies administrative tasks and fosters a vibrant community for societies to thrive on campus.</p>
            <a href="about.aspx" class="btn btn-outline-light btn-more">About Us</a>
        </div>
      </div>
    </div>
  </div>
  </section>
<section class="w3l-testimonials" id="testimonials">
  <div class="testimonials py-5">
    <div class="container py-lg-5">
      <div class="header-section text-center">
        <h3>What our society members Saying</h3>
      </div>
      <div class="row mt-4">
        <div class="col-md-10 mx-auto">
          <div class="owl-one owl-carousel owl-theme">
            <div class="item">
              <div class="slider-info mt-lg-4 mt-3">
                <div class="img-circle">
                  <img src="assets/images/student1.jpg" class="img-fluid testimonial-img" alt="client image">
                </div>
                <div class="message">
                  <span class="fa fa-quote-left" aria-hidden="true"></span>
                  <p>Being in a society is amazing! It's like finding your community within the university, where you connect, grow, and make lasting memories with like-minded peers. It's a space for personal development, leadership opportunities, and meaningful connections that enhance your university experience in a profound way.
</p>
                  <div class="name mt-4">
                    <h4>Adam Ster</h4>
              
                  </div>
                </div>
              </div>
            </div>
            <div class="item">
              <div class="slider-info mt-lg-4 mt-3">
                <div class="img-circle">
                  <img src="assets/images/student2.jpg" class="img-fluid testimonial-img" alt="client image">
                </div>
                <div class="message">
                  <span class="fa fa-quote-left" aria-hidden="true"></span>
                  <p>Being part of a society is truly enriching. It's a place where I belong, surrounded by friends who share my interests and passions. We collaborate, learn, and grow together, creating unforgettable experiences and making a positive impact on campus. It's a rewarding journey of personal development, friendship, and community engagement that adds so much value to my university experience.</p>
                  <div class="name mt-4">
                    <h4>Dennis Jack</h4>
                  </div>
                </div>
            </div>
            </div>
            <div class="item">
              <div class="slider-info mt-lg-4 mt-3">
                <div class="img-circle">
                  <img src="assets/images/student3.jpg" class="img-fluid testimonial-img" alt="client image">
                </div>
                <div class="message">
                  <span class="fa fa-quote-left" aria-hidden="true"></span>
                  <p>Being in a society is like finding a second family on campus. It's a supportive community where I can pursue my interests, develop new skills, and build lasting friendships. From organizing events to contributing to meaningful projects, being part of a society is a rewarding experience that enhances my university journey in countless ways.</p>
                  <div class="name mt-4">
                    <h4>Camillae</h4>
                  
                  </div>
                </div>
              </div>
            </div>
         
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<div class="w3l-faq-block py-5">
  <div class="container py-lg-5">
    <div class="header-section mb-4">
      <h3>FAQ</h3>
    </div>
    <div class="row">
      <div class="col-md-8 mt-md-0 mt-5">
        <div class="tab-content" id="nav-tabContent">
          <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
            <section class="w3l-faq" id="faq">
              <div class="faq-page">
                <ul>
                  <li>
                    <input type="checkbox" checked>
                    <i></i>
                    <h2>We denounce with righteous?</h2>
                    <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Voluptates amet earum velit nobis aliquam
                      laboriosam nihil debitis facere voluptatibus consectetur quae quasi fuga, ad corrupti libero omnis sapiente
                      non assumenda excepturi aperiam iste minima autem.</p>
                  </li>
                  <li>
                    <input type="checkbox" checked>
                    <i></i>
                    <h2>At vero eos iusto odio ducimus qui?</h2>
                    <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Voluptates amet earum velit nobis aliquam
                      laboriosam nihil quasi fuga, ad corrupti libero omnis sapiente
                      non assumenda excepturi aperiam animi vitae eos nisi laudantium. Tempore reiciendis ipsam culpa, qui
                      voluptates eveniet, incidunt officiis eaque iste minima autem.</p>
                  </li>
                  
                </ul>
              </div>
            </section>
          </div>
     
        
        </div>
      </div>
    </div>
  </div>

</div>
<section class="w3l-subscribe">
  <div class="subscription-infhny">
    <div class="container-fluid">
      <div class="subscription-grids row">
        <div class="subscription-right form-right-inf col-lg-6 p-md-5 p-4">
          <div class="px-lg-5 py-md-0 py-3">
            <div class="header-section">
              <h3>Join our Platform to get <span>email updates!</span></h3>
              <p class="mt-3">Subscribe and get notified at first on the latest society events!</p>
            </div>
            <form action="#" method="post" class="signin-form mt-lg-5 mt-4">
              <div class="forms-gds">
                <div class="form-input">
                  <input type="email" name="" placeholder="Your email here" required="">
                </div>
                <div class="form-input"><button class="btn btn-primary theme-button">Subscribe</button></div>
              </div>
            </form>
          </div>
        </div>
        <div class="subscription-left forms-25-info col-lg-6 ">

        </div>
      </div>
    </div>
</section>
   <!-- footer -->
   <footer class="w3l-footer-29-main" id="footer">
     <div class="footer-29 py-5">
       <div class="container pb-lg-3">
         <div class="row footer-top-29">
           <div class="col-lg-4 col-md-6 footer-list-29 footer-1 mt-md-4">
            <a class="navbar-brand" href="index.aspx"><img src="assets/images/logo-icon.png" alt="" style="width: 100px; height: auto;" />Society Management</a>
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
               <li><a href="index.aspx">Home</a></li>
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
