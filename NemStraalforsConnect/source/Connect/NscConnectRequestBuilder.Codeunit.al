namespace Nsc.Connect;
using Nsc.Core.DataExchangeFormats.Xml;

codeunit 1000002 NscConnectRequestBuilder
{
    var
        XmlBuilder: Codeunit XmlBuilder;

    procedure PrepareDocument(): XmlDocument
    var
        Document: XmlDocument;
        DocumentRoot: XmlElement;
    begin
        Document := XmlBuilder.CreateDocument('ForsendelseI');

        Document.GetRoot(DocumentRoot);

        XmlBuilder.AddAttribute(DocumentRoot, 'xmlns', 'urn:oio:fjernprint:3.0.0');
        XmlBuilder.AddAttribute(DocumentRoot, 'xmlns:dkal', 'urn:oio:dkal:1.0.0');

        exit(Document);
    end;

    procedure AddAfsendelseId(AfsendelseId: Text; var Parent: XmlElement)
    begin
        XmlBuilder.AddElementWithValue('AfsendelseIdentifikator', AfsendelseId, Parent);
    end;

    procedure AddForsendelseTypeId(ForsendelsesTypeId: Text; var Parent: XmlElement)
    begin
        XmlBuilder.AddElementWithValue('ForsendelseTypeIdentifikator', ForsendelsesTypeId, Parent);
    end;

    procedure AddForsendelseModtagerWithCpr(CprNumber: Text; var Parent: XmlElement)
    var
        GroupRoot: XmlElement;
        InnerGroupRoot: XmlElement;
    begin
        GroupRoot := XmlBuilder.AddElementGroup('ForsendelseModtager', Parent);
        InnerGroupRoot := XmlBuilder.AddElementGroup('AfsendelseModtager', GroupRoot, 'dkal');

        XmlBuilder.AddElementWithValue('CPRnummerIdentifikator', CprNumber, InnerGroupRoot);
    end;

    procedure AddFileFormatNamePdf(var Parent: XmlElement)
    begin
        XmlBuilder.AddElementWithValue('FilformatNavn', 'PDF', Parent, 'dkal');
    end;

    procedure AddForsendelseIndhold(Base64Indhold: Text; var Parent: XmlElement)
    begin
        XmlBuilder.AddElementWithValue('MeddelelseIndholdData', Base64Indhold, Parent, 'dkal');
    end;

    procedure AddDokumentParameters(var Parent: XmlElement)
    begin
        XmlBuilder.AddElement('DokumentParametre', Parent);
    end;

    procedure AddKanalUafhaengigeParametre(Username: Text; KanalKode: Text; var Parent: XmlElement)
    var
        GroupRoot: XmlElement;
    begin
        GroupRoot := XmlBuilder.AddElementGroup('KanalUafhaengigeParametreI', Parent);

        XmlBuilder.AddElementWithValue('BrugerNavn', Username, GroupRoot);
        XmlBuilder.AddElementWithValue('KanalKode', KanalKode, GroupRoot);
    end;
}