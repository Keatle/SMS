using BlossomsWeb.ServiceReference1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlossomsWeb
{
    public partial class login : System.Web.UI.Page
    {
        ServiceClient sr = new ServiceClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            /* homeLink.NavigateUrl = "~/home.aspx";
             registerLink.NavigateUrl = "~/register.aspx";
             forgotPasswordLink.NavigateUrl = "~/forgotPassword.aspx";


             */
        }


        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string userType;
            var id = sr.userLogin(txtUsername.Text, txtPassword.Text);

            if (id != null)
            {
                string username = txtUsername.Text.Trim().ToUpper(); // Convert username to uppercase and remove leading/trailing spaces

                if (username.StartsWith("A"))
                {
                    userType = "Admin";
                }
                else if (username.StartsWith("L")) // Added closing parenthesis
                {
                    userType = "Secretary";
                }
                else if (username.StartsWith("C"))
                {
                    userType = "Chairperson";
                }
                else if (username.StartsWith("T"))
                {
                    userType = "Treasurer";
                }
                else
                {
                    userType = "Student";
                }

                Session["UserType"] = userType; // Set the user type in session
                Session["LoggedInUserID"] = id; // Assuming you're storing the logged-in user's ID

                Response.Redirect("dashboard.aspx?studentNumber=" + username);

            }
            else
            {
                lblErrorMessage.Text = "Invalid login credentials. Try again.";
                lblErrorMessage.Visible = true;
            }


        }
    }
}