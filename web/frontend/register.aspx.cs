using BlossomsWeb.ServiceReference1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlossomsWeb
{
    public partial class register : System.Web.UI.Page
    {
        ServiceClient sr = new ServiceClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            // loginLink.NavigateUrl = "~/login.aspx";

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {

            string selectedSociety = society.SelectedValue;
            string fullName = name.Text;
            string studentNumber = stdno.Text;
            string emailAddress = email.Text;
            string userPassword = password.Text;
            string confirmPasswordInput = confirmPassword.Text; 

            if (userPassword == confirmPasswordInput) 
            {
                bool registrationResult = sr.userRegister(studentNumber, fullName, emailAddress, userPassword, confirmPasswordInput); // Changed confirmPassword to confirmPasswordInput

                if (registrationResult)
                {
                    lblSuccessMessage.Text = "Registration successful. Proceed to login!";
                    lblSuccessMessage.Visible = true;
                    Response.Redirect("login.aspx");
                }
                else
                {
                    lblErrorMessage.Text = "Registration failed. Please try again.";
                    lblErrorMessage.Visible = true;
                }
            }
            else
            {
                lblErrorMessage.Text = "Passwords do not match";
                lblErrorMessage.Visible = true;
            }

        }
    }
}