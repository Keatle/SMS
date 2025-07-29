using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlossomsWeb
{
    public partial class events : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*List<Event> events = GetEventData();
            StringBuilder upcomingHtml = new StringBuilder();
            StringBuilder previousHtml = new StringBuilder();

            // Dynamically generate HTML for each event
            string html = "";
            foreach (var evt in events)
            {
                html += "<tr>";
                html += "<th style='width: 70%;'>";
                html += "<h2 style='display: inline-block; margin-right: 20px;'>" + evt.Name + "</h2>";
                html += "<p style='display: inline-block;'>" + evt.Society + "</p>";
                html += "<p>" + evt.Description + "</p>";
                html += "<br />";
                html += "<table style='width: 100%;'>";
                html += "<tr>";
                html += "<td style='width: 50%;'>" + evt.DateTime + "</td>";
                html += "<td style='width: 50%;'>" + evt.Location + "</td>";
                html += "</tr>";
                html += "</table>";
                html += "</th>";
                html += "<th style='width: 30%;'>";
                html += "<center>";
                html += "<h2>Event Type</h2>";
                html += "<br />";

                if (DateTime.Parse(evt.DateTime) > DateTime.Today)
                {
                    // Event is upcoming, add RSVP button
                    html += "<asp:Button ID='btnRSVP' runat='server' Text='RSVP' CssClass='btn btn-outline-primary theme-button' OnClick='btnRSVP_Click' CommandArgument='" + evt.EventID + "' />";
                    html += "</center>";
                    upcomingHtml.AppendLine(html);
                }
                else
                {
                    // Event is previous, do not add RSVP button
                    html += "</center>";
                    previousHtml.AppendLine(html);
                }

                html += "</th>";
                html += "</tr>";
            }

            upcomingEvents.InnerHtml = upcomingHtml.ToString();
            previousEvents.InnerHtml = previousHtml.ToString();
            */
        }
        protected void btnRSVP_Click(object sender, EventArgs e)
        {
            // Add your C# code logic here to handle the button click event
            // This method will be executed when the button is clicked
        }

        protected void btnEnterCode_Click(object sender, EventArgs e)
        {

        }
    }
}