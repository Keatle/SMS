using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlossomsWeb
{
    public partial class applications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ViewEvents_Click(object sender, EventArgs e)
        {
           /* List<Event> events = Database.GetEvents();

            // Display the fetched data (for demonstration purposes, you can use a GridView or other controls)
            // Example: Bind the events data to a GridView
            // gridEvents.DataSource = events;
            // gridEvents.DataBind();

            // Open the popup form after fetching and displaying the data
            eventsForm.Style["display"] = "block";*/
        }

        protected void ViewBudget_Click(object sender, EventArgs e)
        {
             /*Budget budget = Database.GetBudget();

            // Display the fetched data (for demonstration purposes, you can use labels or other controls)
            // Example: Display budget data in labels
            // lblBudgetAmount.Text = budget.Amount.ToString("C");
            // lblBudgetDescription.Text = budget.Description;

            // Open the popup form after fetching and displaying the data
            budgetForm.Style["display"] = "block";*/
        }

        protected void ViewSocieties_Click(object sender, EventArgs e)
        {
           /*  List<Society> societies = Database.GetSocieties();

            // Example: Bind the societies data to a GridView
            // gridSocieties.DataSource = societies;
            // gridSocieties.DataBind();

            societiesForm.Style["display"] = "block";*/
        }

        protected void Process_Click(object sender, EventArgs e)
        {
            // Perform processing logic here

            // For demonstration purposes, let's display a success message
            ClientScript.RegisterStartupScript(this.GetType(), "ProcessSuccess", "alert('Event processed successfully!');", true);
        }

        protected void Reject_Click(object sender, EventArgs e)
        {
            // Perform rejection logic here

            // For demonstration purposes, let's display a success message
            ClientScript.RegisterStartupScript(this.GetType(), "RejectSuccess", "alert('Event rejected!');", true);
        }

    }
}