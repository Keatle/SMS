using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlossomsWeb
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           /* if (!IsPostBack)
            {
                // Assuming you have a method to retrieve user information based on user ID
                User user = GetUserInformation();

                if (user != null)
                {
                    // Populate form fields with user information
                    lblSociety.Text = "Select Society:";
                    ddlSociety.SelectedValue = user.Society;
                    txtName.Text = user.Name;
                    txtStdNo.Text = user.StudentNumber;
                    txtEmail.Text = user.Email;
                 // For demonstration purposes only, do not display passwords

                    // Enable update button
                    btnUpdate.Visible = true;
                }
                else
                {
                    // User information not found, handle accordingly
                    lblUpdateErrorMessage.Text = "Failed to retrieve user information.";
                    lblUpdateErrorMessage.Visible = true;
                }
            }*/
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Implement update logic here
            // Retrieve updated information from form fields and update the database
        }
    }
}