namespace Nsc.Core.UI;
using Nsc.Core.Persistance;

page 1000007 "Nsc Delivery Submissions Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Nsc Delivery Submission";

    layout
    {
        area(Content)
        {
            repeater(Submissions)
            {
                field("Delivery Status"; Rec."Delivery Status")
                {
                    ToolTip = 'Delivery status';
                }
            }
        }
    }
}