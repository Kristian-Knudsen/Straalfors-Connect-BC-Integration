namespace Nsc.UI;
using Nsc.Persistance;

page 1000000 NscSetup
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = NscSetup;

    layout
    {
        area(Content)
        {
            group(GeneralSettings)
            {
                Caption = 'General settings';
                field(IncludeInvoices; Rec.IncludeInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Include invoices to send';
                    ToolTip = 'Should sales invoices be picked up and sent to Strålfors Connect?';
                }

                field(IncludeCreditMemos; Rec.IncludeCreditMemos)
                {
                    ApplicationArea = All;
                    Caption = 'Include creditmemos to send';
                    ToolTip = 'Should sales credit memos be picked up and sent to Strålfors Connect?';
                }

                field(IncludeReminders; Rec.IncludeReminders)
                {
                    ApplicationArea = All;
                    Caption = 'Include reminders to send';
                    ToolTip = 'Should reminders be picked up and sent to Strålfors Connect?';
                }
            }

            group(AdminstrationSettings)
            {
                Caption = 'Administration settings';
                field(SenderSystemId; Rec.SenderSystemId)
                {
                    ApplicationArea = All;
                    Caption = 'Sending system id';
                    ToolTip = 'Sender System Id provided by Strålfors Connect, through the self service portal';
                }

                field(DeliveryTypeId; Rec.DeliveryTypeId)
                {
                    ApplicationArea = All;
                    Caption = 'Delivery Type Id';
                    ToolTip = 'Delivery type Id provided by Strålfors Connect, through the self service portal';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ReplaceCertificate)
            {
                ApplicationArea = All;
                Caption = 'Replace public certificate';
                Image = Refresh;
                ToolTip = 'Replaces the current certificate - Using this feature might stop the integration from working';

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                begin
                    if not UploadIntoStream('Key files|*.cer', InStr) then
                        exit;

                    Rec.Certificate.CreateOutStream(OutStr);
                    CopyStream(OutStr, InStr);

                    Rec.Modify(true);
                end;
            }

            action(ReplaceCertificateKey)
            {
                ApplicationArea = All;
                Caption = 'Replace private certificate';
                Image = Refresh;
                ToolTip = 'Replaces the current certificate key - Using this feature might stop the integration from working';

                trigger OnAction()
                var
                    InStr: InStream;
                    OutStr: OutStream;
                begin
                    if not UploadIntoStream('Key files|*.pfx;', InStr) then
                        exit;

                    Rec.CertificateKey.CreateOutStream(OutStr);
                    CopyStream(OutStr, InStr);

                    Rec.Modify(true);
                end;
            }
        }
    }
}