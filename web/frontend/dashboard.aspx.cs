using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BlossomsWeb
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

                if (!IsPostBack)
                {
                    if (Request.QueryString["studentNumber"] != null)
                    {
                        string studentNumber = Request.QueryString["studentNumber"];
                       studentNumberLabel.Text = "Hi!  " + studentNumber;
                    }
                }
            /*
             if (Session["UserType"] != null)
             {
                 string userType = Session["UserType"].ToString();
                 switch (userType)
                 {                 
                     case "Student":
                         this.MasterPageFile = "~/student.master";
                         break;
                    case "Chairperson":
                        this.MasterPageFile = "~/chairperson.master";
                        break;
                    case "Treasurer":
                        this.MasterPageFile = "~/treasurer.master";
                        break;
                    case "Secretary":
                        this.MasterPageFile = "~/secretary.master";
                        break;
                    case "Admin":
                        this.MasterPageFile = "~/admin.master";
                        break;
                    default:
                        studentNumberLabel.Text = "Invalid User.";
                        break;
                 }
             }
             else
             {
                 Response.Redirect("dashboard.aspx");
             }*/  
        }

        

    }
}