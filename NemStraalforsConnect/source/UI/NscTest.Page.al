namespace Nsc.UI;
using Nsc.Connect;

page 1000001 "Nsc Test"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action(Test)
            {

                trigger OnAction()
                var
                    NscDocBuilder: Codeunit "Nsc Request Builder";
                    TestDocRoot: XmlElement;
                begin
                    TestDocRoot := NscDocBuilder.PrepareDocumentAndReturnRoot();

                    NscDocBuilder.AddAfsendelseId(Guid.CreateGuid(), TestDocRoot);
                    NscDocBuilder.AddForsendelseTypeId('123', TestDocRoot);
                    NscDocBuilder.AddForsendelseModtagerWithCpr('0102031234', TestDocRoot);
                    NscDocBuilder.AddFileFormatNamePdf(TestDocRoot);
                    NscDocBuilder.AddForsendelseIndhold('123', TestDocRoot);
                    NscDocBuilder.AddDokumentParameters(TestDocRoot);
                    NscDocBuilder.AddKanalUafhaengigeParametre('Aurora Software', 'Digital Post', TestDocRoot);

                    Message('%1', TestDocRoot);
                end;
            }
        }
    }
}