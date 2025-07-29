using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlossomsWeb
{
    public partial class societies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          /*  List<Society> societies = GetSocietyData();

            string html = "";
            foreach (var society in societies)
            {
                string html = "<tr>";
                html += "<th style='width: 70%;'>";
                html += "<h2 style='display: inline-block; margin-right: 20px;'>" + society.Name + "</h2>";
                html += "<p style='display: inline-block;'>" + society.YearRegistered + "</p>";
                html += "<br />";
                html += "<p>" + society.Description + "</p>";
                html += "<br />";
                html += "Department";
                html += "</th>";
                html += "<th style='width: 30%;'>";
                html += "<center>";
                html += "<h2>Members</h2>";
                html += "<br />";
                html += "<h4>" + society.TotalMembers + "</h4>";
                html += "</center>";
                html += "</th>";
                html += "</tr>";

            }
            societies.InnerHtml = html; */
        }
    }
}